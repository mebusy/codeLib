import numpy as np

def softmax( f, aggregate_axis = 0 ):
    # instead: first shift the values of f so that the highest number is 0:
    f_max = np.max(f, axis= aggregate_axis )
    f -= f_max.reshape( f_max.shape + (1,) )
    f_exp = np.exp(f)
    f_sum = np.sum( f_exp, axis=aggregate_axis )
    return f_exp / f_sum.reshape( f_sum.shape + (1,) )


def affine_forward(x, w, b):
    """
    Computes the forward pass for an affine (fully-connected) layer.

    The input x has shape (N, d_1, ..., d_k) where x[i] is the ith input.
    We multiply this against a weight matrix of shape (D, M) where
    D = \prod_i d_i

    Inputs:
    x - Input data, of shape (N, d_1, ..., d_k)
    w - Weights, of shape (D, M)
    b - Biases, of shape (M,)

    Returns a tuple of:
    - out: output, of shape (N, M)
    - cache: (x, w, b)
    """
    out = x.reshape(x.shape[0], -1).dot(w) + b
    cache = (x, w, b)
    return out, cache


def affine_backward(dout, cache):
    """
    Computes the backward pass for an affine layer.

    Inputs:
    - dout: Upstream derivative, of shape (N, M)
    - cache: Tuple of:
      - x: Input data, of shape (N, d_1, ... d_k)
      - w: Weights, of shape (D, M)

    Returns a tuple of:
    - dx: Gradient with respect to x, of shape (N, d1, ..., d_k)
    - dw: Gradient with respect to w, of shape (D, M)
    - db: Gradient with respect to b, of shape (M,)
    """
    x, w, b = cache
    dx = dout.dot(w.T).reshape(x.shape)
    dw = x.reshape(x.shape[0], -1).T.dot(dout)
    db = np.sum(dout, axis=0)
    return dx, dw, db


def relu_forward(x):
    """
    Computes the forward pass for a layer of rectified linear units (ReLUs).

    Input:
    - x: Inputs, of any shape

    Returns a tuple of:
    - out: Output, of the same shape as x
    - cache: x
    """
    out = np.maximum(0, x)
    cache = x
    return out, cache


def relu_backward(dout, cache):
    """
    Computes the backward pass for a layer of rectified linear units (ReLUs).

    Input:
    - dout: Upstream derivatives, of any shape
    - cache: Input x, of same shape as dout

    Returns:
    - dx: Gradient with respect to x
    """
    x = cache
    dx = np.where(x > 0, dout, 0)
    return dx


def softmax_loss(x, y):
    """
    Computes the loss and gradient for softmax classification.

    Inputs:
    - x: Input data, of shape (N, C) where x[i, j] is the score for the jth class
      for the ith input.
    - y: Vector of labels, of shape (N,) where y[i] is the label for x[i] and
      0 <= y[i] < C

    Returns a tuple of:
    - loss: Scalar giving the loss
    - dx: Gradient of the loss with respect to x
    """
    probs = np.exp(x - np.max(x, axis=1, keepdims=True))
    probs /= np.sum(probs, axis=1, keepdims=True)
    N = x.shape[0]
    loss = -np.sum(np.log(probs[np.arange(N), y])) / N
    dx = probs.copy()
    dx[np.arange(N), y] -= 1
    dx /= N
    return loss, dx


# ==================================================================

def affine_relu_forward(x, w, b):
    """
    Convenience layer that perorms an affine transform followed by a ReLU

    Inputs:
    - x: Input to the affine layer
    - w, b: Weights for the affine layer

    Returns a tuple of:
    - out: Output from the ReLU
    - cache: Object to give to the backward pass
    """
    a, fc_cache = affine_forward(x, w, b)
    out, relu_cache = relu_forward(a)
    cache = fc_cache + (relu_cache, )
    return out, cache


def affine_relu_backward(dout, cache):
    """
    Backward pass for the affine-relu convenience layer
    """
    x, w, b , relu_cache = cache
    da = relu_backward(dout, relu_cache)
    dx, dw, db = affine_backward(da, (x, w, b ) )
    return dx, dw, db


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

# if __name__ == '__main__':
def test():
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

if __name__ == '__main__':
    pass

