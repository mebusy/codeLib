
import gym

episode_number = 0

# def print_episode(func):
#     @functools.wraps(func)
#     def wrapper(*args, **kw):
#         # xxxx 
#         return func(*args, **kw)
#     return wrapper



def modifyFuncs(env):

    # === function modify start  =======

    rawMethod = env.__class__.reset

    def env_reset(self):
        print "training: " , episode_number
        rawMethod(self ) 
    

    env.__class__.reset = env_reset 
    
    # === function modify end =======



if __name__ == '__main__':
     
    env = gym.make( 'MsPacmanDeterministic-v0' )
    # for debug only
    modifyFuncs(env)

    observation = env.reset()
     
    while True:
        env.render()
        action = env.action_space.sample() 
        observation, reward, done, info = env.step(action)
        
        if done:
            episode_number += 1 
            observation = env.reset()   
    print 'done'
