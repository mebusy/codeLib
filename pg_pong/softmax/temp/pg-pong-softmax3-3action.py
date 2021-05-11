""" Trains an agent with (stochastic) Policy Gradients on Pong. Uses OpenAI Gym. """
import numpy as np
# import cPickle as pickle
import pickle  # python3
import gym

from fc_net_layer import *

# hyperparameters
H = 200 # number of hidden layer neurons
C = 3 # for softmax

batch_size = 10 # every how many episodes to do a param update?
learning_rate = 1e-3  # 1e-4 
gamma = 0.99 # discount factor for reward
decay_rate = 0.99 # decay factor for RMSProp leaky sum of grad^2
resume = True # resume from previous checkpoint?
render = False

# iter_values = [] # no used

# model initialization
D = 80 * 80 # input dimensionality: 80x80 grid


if resume:
  model = pickle.load(open('save.p', 'rb'))
else:
  model = {}
  model['W1'] = np.random.randn(D,H) / np.sqrt(D) # "Xavier" initialization
  model['W2'] = np.random.randn(H,C) / np.sqrt(H)
  
grad_buffer = { k : np.zeros_like(v) for k,v in model.items() } # update buffers that add up gradients over a batch
rmsprop_cache = { k : np.zeros_like(v) for k,v in model.items() } # rmsprop memory


def prepro(I):
  """ prepro 210x160x3 uint8 frame into 6400 (80x80) 1D float vector """
  I = I[35:195] # crop
  I = I[::2,::2,0] # downsample by factor of 2
  I[I == 144] = 0 # erase background (background type 1)
  I[I == 109] = 0 # erase background (background type 2)
  I[I != 0] = 1 # everything else (paddles, ball) just set to 1
  return I.astype(np.float).ravel()

def discount_rewards(r):
  """ take 1D float array of rewards and compute discounted reward """
  discounted_r = np.zeros_like(r) # an array of zeros with the same shape
  running_add = 0
  for t in reversed(range(0, r.size)): # [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
    if r[t] != 0: running_add = 0 # reset the sum, since this was a game boundary (pong specific!)
    running_add = running_add * gamma + r[t]
    discounted_r[t] = running_add
  return discounted_r

def policy_forward(x):
    # ignore bias 
    # ( ( x,w,b ), lru_x  )
    _scores1, cache_fc_lelu = affine_relu_forward(x, model["W1"], np.zeros( [1,H] ) )
    # cache_h_fc: (s,w,b)
    scores , cache_h_fc = affine_forward( _scores1 , model["W2"], np.zeros( [1,C] )  )
    return scores, cache_fc_lelu, cache_h_fc

def policy_backward(y, discounted_epr):
    """ backward pass. (eph is array of intermediate hidden states) """
    # dW2 = np.dot(eph.T, epdlogp).ravel()
    # dh = np.outer(epdlogp, model['W2'])
    # dh[eph <= 0] = 0 # backpro prelu
    # dW1 = np.dot(dh.T, epx)

    loss, grads = 0, {}
    reg = 0.2

    W1= model['W1']
    W2= model['W2']

    # stack


    loss, smx_grad = softmax_loss( ep_scores, y )  # loss of score
    # hack
    smx_grad *= discounted_epr

    # + loss of regularization
    # **loss won't be actually used in calculating gradients**
    loss += 0.5 * reg * ( (W1*W1).sum() + (W2*W2).sum() )

    dx2, dw2, db2 = affine_backward(smx_grad, ep_cache_h_fc  )
    grads["W2"] = dw2 + reg * W2
    # grads["b2"] = db2   # ignore bias

    dx1, dw1, db1 = affine_relu_backward( dx2, ep_cache_fc_lelu )
    grads["W1"] = dw1 + reg * W1
    # grads["b1"] = db1   # ignore bias

    return grads

env = gym.make("Pong-v0")
observation = env.reset()
prev_x = None # used in computing the difference frame
fake_labels , drs = [],[]

g_scores = []
g_cache_fc_lelu = [ [],[],[],[] ]
g_cache_h_fc = [ [],[],[] ]

running_reward = None
reward_sum = 0
episode_number = 0
while True:
  if render: env.render()

  # preprocess the observation, set input to network to be difference image
  cur_x = prepro(observation)
  x = cur_x - prev_x if prev_x is not None else np.zeros(D)
  prev_x = cur_x

  # reshape for fitting cs231n code
  x = x.reshape( 1, -1 )

  # forward the policy network and sample an action from the returned probability
  scores, cache_fc_lelu, cache_h_fc = policy_forward(x)
  # handle cache  
  g_scores.extend( scores )
  for _i, _v in enumerate(cache_fc_lelu):
      if _i == 1 : continue  # W
      g_cache_fc_lelu[_i].extend( _v )
  for _i, _v in enumerate(cache_h_fc):
      if _i == 1 : continue  # W
      g_cache_h_fc[_i].extend( _v )

  # calc softmax
  scores_softmax = softmax( scores, aggregate_axis=1 ) [0]  # only 1 result

  # pick action
  # action = 2 if np.random.uniform() < aprob else 3 # roll the dice!
  action = 1 + np.random.choice( C , p = scores_softmax )

  # record various intermediates (needed later for backprop)
  # y = 1 if action == 2 else 0 # a "fake label"
  fake_labels.append( action -1 )
  # dlogps.append(y - aprob) # grad that encourages the action that was taken to be taken (see http://cs231n.github.io/neural-networks-2/#losses if confused)

  # step the environment and get new measurements
  observation, reward, done, info = env.step(action)
  reward_sum += reward

  drs.append(reward) # record reward (has to be done after we call step() to get reward for previous action)

  if done: # an episode finished
    episode_number += 1

    # stack together all inputs, hidden states, action gradients, and rewards for this episode
    # epdlogp = np.vstack(dlogps)
    eplabels = np.vstack( fake_labels )
    epr = np.vstack(drs)

    ep_scores = np.vstack( g_scores )

    ep_cache_fc_lelu = [ None, model['W1'], None, None  ] 
    ep_cache_h_fc =  [ None, model['W2'], None ]
    for _i, _v in enumerate(cache_fc_lelu):
        if _i != 1 :
            ep_cache_fc_lelu[_i] = np.vstack( g_cache_fc_lelu[_i] )
    for _i, _v in enumerate(cache_h_fc):
        if _i != 1 :
            ep_cache_h_fc[_i]  = np.vstack( g_cache_h_fc[_i] )


    fake_labels, drs = [],[] # reset array memory

    g_scores = []
    g_cache_fc_lelu = [ [],[],[],[] ]
    g_cache_h_fc = [ [],[],[] ]

    # compute the discounted reward backwards through time
    discounted_epr = discount_rewards(epr)
    # standardize the rewards to be unit normal (helps control the gradient estimator variance)
    discounted_epr -= np.mean(discounted_epr)
    discounted_epr /= np.std(discounted_epr)

    # epdlogp *= discounted_epr # modulate the gradient with advantage (PG magic happens right here.)
    grad = policy_backward(eplabels,discounted_epr)
    for k in model: grad_buffer[k] += grad[k] # accumulate grad over batch

    # perform rmsprop parameter update every batch_size episodes
    if episode_number % batch_size == 0:
      for k,v in model.items():
        g = grad_buffer[k] # gradient
        rmsprop_cache[k] = decay_rate * rmsprop_cache[k] + (1 - decay_rate) * g**2
        model[k] -= learning_rate * g / (np.sqrt(rmsprop_cache[k]) + 1e-5)
        grad_buffer[k] = np.zeros_like(v) # reset batch gradient buffer

    # boring book-keeping
    running_reward = reward_sum if running_reward is None else running_reward * 0.99 + reward_sum * 0.01
    print ('resetting env. episode reward total was %f. running mean: %f' % (reward_sum, running_reward))
    # iter_values.append( (reward_sum, running_reward)   )

    if episode_number % 100 == 0: 
        pickle.dump(model, open('save.p', 'wb'))
        # pickle.dump( iter_values , open('pg-pong_iter_values', 'wb')  )
    reward_sum = 0
    observation = env.reset() # reset env
    prev_x = None

  if reward != 0: # Pong has either +1 or -1 reward exactly when game ends.
    # print(episode_number, reward)
    print ('ep %d: game finished, reward: %f' % (episode_number, reward) + ('' if reward == -1 else ' !!!!!!!!') )


