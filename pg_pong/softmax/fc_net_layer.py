import numpy as np

from layers import *
from layer_utils import *

def softmax( f, aggregate_axis = 0 ):
    # instead: first shift the values of f so that the highest number is 0:
    f_max = np.max(f, axis= aggregate_axis )
    f -= f_max.reshape( f_max.shape + (1,) )
    f_exp = np.exp(f)
    f_sum = np.sum( f_exp, axis=aggregate_axis )
    return f_exp / f_sum.reshape( f_sum.shape + (1,) )


# ===================


def forwardpass_test():
    # ( ( x,w,b ), lru_x  )
    _scores1, cache_fc_lelu = affine_relu_forward(X, model["W1"], np.zeros( [1,H] ) )
    # cache_h_fc: (s,w,b)
    scores , cache_h_fc = affine_forward( _scores1 , model["W2"], np.zeros( [1,C] )  )

    scores_softmax = softmax( scores, aggregate_axis=1 ) [0]
    for i in range(10):
        action = np.random.choice( C , p = scores_softmax )
        print (scores_softmax , action)

    return scores, cache_fc_lelu, cache_h_fc


def backpass_test( y ):
    loss, grads = 0, {}
    reg = 0.3

    W1= model['W1']
    W2= model['W2']

    # stack

    
    loss, smx_grad = softmax_loss( ep_scores, y )  # loss of score
    # + loss of regularization
    # **loss won't be actually used in calculating gradients**
    loss += 0.5 * reg * ( (W1*W1).sum() + (W2*W2).sum() )
    
    dx2, dw2, db2 = affine_backward(smx_grad, ep_cache_h_fc  )
    grads["W2"] = dw2 + reg * W2
    # grads["b2"] = db2   # ignore bias

    dx1, dw1, db1 = affine_relu_backward( dx2, ep_cache_fc_lelu )
    grads["W1"] = dw1 + reg * W1
    # grads["b1"] = db1   # ignore bias
    return loss, grads

if __name__ == '__main__':
    D = 80 * 80
    H = 200 # number of hidden layer neurons
    C = 2 # for softmax

    model = {}
    model['W1'] = np.random.randn(D,H) / np.sqrt(D) # "Xavier" initialization
    model['W2'] = np.random.randn(H,C) / np.sqrt(H)

    X = np.random.randn( D )
    X = X.reshape(  1, -1  ) # 1 sample

    g_scores = []
    g_cache_fc_lelu = [ [],[],[],[] ]
    g_cache_h_fc = [ [],[],[] ]

    nSample = 3
    # forward test , test 3 samples
    for i in range(nSample):
        scores, cache_fc_lelu, cache_h_fc = forwardpass_test()

        g_scores.extend( scores )
        print( "scores:{}".format( scores[0].shape ) )
        for _i, _v in enumerate(cache_fc_lelu):
            print( "cache_fc_lelu[{}]:{}".format( _i, cache_fc_lelu[_i].shape ) )
            if _i == 1 : continue  # W
            g_cache_fc_lelu[_i].extend( _v )
        for _i, _v in enumerate(cache_h_fc):
            print( "cache_h_fc[{}]:{}".format( _i, cache_h_fc[_i].shape ) )
            if _i == 1 : continue  # W
            g_cache_h_fc[_i].extend( _v )

    ep_scores = np.vstack( g_scores )
    print( "ep_scores:{}".format( ep_scores.shape ) )

    ep_cache_fc_lelu = [ None, model['W1'], None, None  ] 
    ep_cache_h_fc =  [ None, model['W2'], None ]
    for _i, _v in enumerate(cache_fc_lelu):
        if _i != 1 :
            ep_cache_fc_lelu[_i] = np.vstack( g_cache_fc_lelu[_i] )
        print( "ep_cache_fc_lelu[{}]:{}".format( _i, ep_cache_fc_lelu[_i].shape ) )
    for _i, _v in enumerate(cache_h_fc):
        if _i != 1 :
            ep_cache_h_fc[_i]  = np.vstack( g_cache_h_fc[_i] )
        print( "ep_cache_h_fc[{}]:{}".format( _i, ep_cache_h_fc[_i].shape ) )

    # backpass test
    y = np.zeros( nSample, dtype=int )
    loss, grads = backpass_test( y )
    print( loss, grads )


