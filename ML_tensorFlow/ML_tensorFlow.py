

# to start tensorboard
# tensorboard --logdir=./logs

# use float division
from __future__ import division  

import numpy as np 
import math

#"""
# following 2 line , is for virtual env
import matplotlib as mpl
mpl.use('TkAgg')

import matplotlib.pyplot as plt
#"""

import tensorflow as tf 

def length( y ):
	return y.size

def plot( x , y ,  marker , *a  ):
	plt.scatter(x,y , marker=marker[-1:] )

def readOctaveData( filename ) :
	return np.loadtxt( filename , delimiter=','  )   #
	
def test():
	a = tf.constant( [ [1,2] , [3,4] ] )
	b = tf.constant ( [[4],[5]] )

	with tf.Session() as sess:
		print sess.run( a*  b  )


	pass

def ex1():
	data = readOctaveData( "ex1data1.txt" ) 
	
	train_X = data[:,0]  
	train_Y = data[:,1] 

	learning_rate = 0.01
	iterate_step = 400

	plot( train_X, train_Y , 'x', 'MarkerSize', 10 ); 
	plt.show(block=False)

	m = length(train_Y);  

	train_X = np.insert( train_X.reshape( length(train_X) ,1 ) , 0, 1 , axis =1 )
	train_Y = train_Y.reshape( length(train_Y) ,1 )

	# Define the model
	X = tf.placeholder(tf.float32, [None, 2 ])  # We want to be able to input any number of  sample , None means any length
	y = tf.placeholder(tf.float32, [None, 1 ])
	theta = tf.Variable(tf.zeros([2,1]) )

	hx = tf.matmul(X , theta) 
	error = tf.sub( hx ,y )
	cost = tf.matmul( tf.transpose( error ) , error  )

	ave = tf.constant( 1.0/(2*m) )
	J = tf.mul(cost, ave )
	train_op = tf.train.GradientDescentOptimizer( learning_rate ).minimize( J )

	# Create session to run
	with tf.Session() as sess:
		sess.run( tf.global_variables_initializer() )
		var_theta = 0
		for i in xrange( iterate_step ):
			_,var_theta, var_J= sess.run( [train_op , theta, J ] , feed_dict={ X: train_X ,  y : train_Y }  )
			#print var_J
		print var_theta , var_theta.shape

		#print np.matmul(train_X,var_theta).shape , train_X[:,1].shape
		plt.plot( train_X[:,1], np.matmul(train_X,var_theta) );   
		plt.show()

def plotDecisionBoundary( theta , X , y  ) :
	if X.shape[1] <= 3:
		# Theta*x = [t0,t1,t2] dot [x0,x1,x2] = t0 + t1*x1 + t2*x2  = 0
		# => t0 + t1*plot_x + t2*plot_y = 0
		# => t0 + t1*plot_x = -t2*plot_y   
		# => (t0 + t1*plot_x)/(-t2) = plot_y   

		# Only need 2 points to define a line, so choose two endpoints
		plot_x = [np.min(X[:,1])-2,  np.max(X[:,1])+2]
		# Calculate the decision boundary line
		plot_y =  (theta[1]*plot_x + theta[0])/(-theta[2])
		#print plot_y
		
		plt.plot( plot_x , plot_y )
		
		pass
	else:
		# Here is the grid range
		u = np.linspace(-1, 1.5, 50);
		v = np.linspace(-1, 1.5, 50);

		print u.shape

		z = np.zeros( (u.shape[0], v.shape[0]) );
		# Evaluate z = theta*x over the grid
		for i in xrange( u.shape[0] ):
			for j in xrange( v.shape[0] ) :
				z[i,j] = np.dot(mapFeature( np.array(u[i] , ndmin=2 ), np.array(v[j] , ndmin=2 ) )  , theta);

		z = np.transpose(z)
		plt.contour (  u,v,z   )

	plt.show()

def sigmoid( z ):
	return 1.0 / ( 1.0 +   math.e ** (-z) )

def predict( theta , X ):
	return np.floor( sigmoid( np.matmul (X , theta) ) + 0.5 )


def ex2_logisticRegression():

	data = readOctaveData( "ex2data1.txt" ) 
	train_X = data[:, [0,1]]
	train_y = data[:, 2]
	pos = train_y == 1
	neg = train_y == 0

	learning_rate = 0.08
	iterate_step = 4000

	#print train_X.shape
	#print train_X[ pos , 0  ].shape
	plot( train_X[ pos , 0  ] , train_X[ pos , 1 ] , marker='k+' )
	plot( train_X[ neg , 0  ] , train_X[ neg , 1 ] , marker='ko' )
	plt.show( block=False )

	train_X = np.insert( train_X , 0, 1 , axis =1 )
	train_y = train_y.reshape( length(train_y) ,1 )

	m,n = train_X.shape 

	# Define the model
	X = tf.placeholder(tf.float32, [None, n ]) 
	y = tf.placeholder(tf.float32, [None, 1 ])
	theta = tf.Variable(tf.zeros([n,1]) )

	hx0 = tf.matmul(X , theta) 
	hx = sigmoid( hx0 )
	J = (1.0/m) *  tf.reduce_sum(  (-y)* tf.log( hx )  - (1-y)* tf.log( 1-hx )   )
	train_op = tf.train.AdamOptimizer( learning_rate ).minimize( J )

	# Create session to run
	with tf.Session() as sess:
		sess.run( tf.global_variables_initializer() )
		var_theta = 0

		"""
		t0 =  tf.matmul(  tf.convert_to_tensor(train_X, dtype=tf.float32)  , tf.constant([[-25.161272 ],[ 0.206233 ],[0.201470]])  )
		t1 = sigmoid( t0 )
		t2 = (1.0/m) *  tf.reduce_sum(  (-train_y)* tf.log( t1 )  - (1-train_y)* tf.log( 1-t1 )   )
		print sess.run( t2 )
		#"""

		for i in xrange( iterate_step ):
			_,var_theta, var_J = sess.run( [train_op , theta , J  ] , feed_dict={ X: train_X ,  y : train_y }  )

			#print var_J  
			pass
		print var_J, var_theta , var_theta.shape

		# np.array( [[-25.161272 ],[ 0.206233 ],[0.201470]] )
		plotDecisionBoundary( var_theta, train_X , train_y  ) 

		# Compute accuracy on our training set
		p = predict(var_theta, train_X );
		#print p  == train_y 
		print  'Train Accuracy: %f' % (np.mean( 1.0*(p == train_y)) * 100) ; 

	pass


def mapFeature( X1 , X2 ) :
	# Returns a new feature array with more features, comprising of 
	# X1, X2, X1.^2, X2.^2, X1*X2, X1*X2.^2, etc..
	#print np.sum( X1 )
	#print np.sum( X2 )

	degree = 6
	out = np.ones( [ X1.shape[0],1 ] )
		
	for n in xrange( degree ):
		i = n+1
		for j in xrange( i+1 ):

			tmp = np.multiply(  np.power( X1 , (i-j) ) , np.power (X2 , j) )
			tmp = tmp.reshape( tmp.shape[0] , 1 )
			out = np.concatenate((out, tmp ), axis=1)

	return out 

def ex2_regularizedLogisticRegression():



	data = readOctaveData( "ex2data2.txt" ) 
	train_X = data[:, 0:2 ]
	train_y = data[:, 2]
	pos = train_y == 1
	neg = train_y == 0

	learning_rate = 0.1
	iterate_step = 400

	#print train_X.shape
	#print train_X[ pos , 0  ].shape
	plot( train_X[ pos , 0  ] , train_X[ pos , 1 ] , marker='k+' )
	plot( train_X[ neg , 0  ] , train_X[ neg , 1 ] , marker='ko' )
	plt.show( block=False )


	train_X = mapFeature( train_X[:,0] , train_X[:,1] )
	#train_X = np.genfromtxt('mf.txt', delimiter=' ')[:,:] #  
	#print np.sum( train_X , axis=0)


	train_y = train_y.reshape( length(train_y) ,1 )
	m,n = train_X.shape

	# Define the model
	# here we showed the method to use float64
	X = tf.placeholder(tf.float64, [None, n ]) 
	y = tf.placeholder(tf.float64, [None, 1 ])
	theta = tf.Variable(tf.zeros([n,1] , dtype=tf.float64  ) )
	lamda = 1  # set regularization parameter lambda

	hx0 = tf.matmul(X , theta) 
	hx = sigmoid( hx0 )
	J = (1.0/m) *  tf.reduce_sum(  (-y)* tf.log( hx )  - (1-y)* tf.log( 1-hx )   ) + lamda / (2.0*m) * ( tf.reduce_sum (tf.mul( theta , theta ) ) )
	# handle feature 0 case
	J -= lamda /(2*m )* ( tf.pow( theta[0],2) ) ;
	# set name
	const_0_64 = tf.constant( 0,  dtype=tf.float64 )
	J = tf.add( const_0_64 , J , name = "loss" )

	# Visualize 1
	display_step = 20
	tf.summary.scalar( J.op.name , J[0])  # J is [1] , keey the value and tag same type

	# Visualize 2
	# Merge all summaries to a single operator
	merged_summary_op = tf.summary.merge_all()


	train_op = tf.train.AdamOptimizer( learning_rate ).minimize( J )

	# Create session to run
	with tf.Session() as sess:
		sess.run( tf.global_variables_initializer() )
		
		"""
		# the method to assign value to a variable
		p = theta.assign( np.transpose(np.array([
							1.273005,
							0.624876,
							1.177376,
							-2.020142,
							-0.912616,
							-1.429907,
							0.125668,
							-0.368551,
							-0.360033,
							-0.171068,
							-1.460894,
							-0.052499,
							-0.618889,
							-0.273745,
							-1.192301,
							-0.240993,
							-0.207934,
							-0.047224,
							-0.278327,
							-0.296602,
							-0.453957,
							-1.045511,
							0.026463,
							-0.294330,
							0.014381,
							-0.328703,
							-0.143796,
							-0.924883
			  ] , ndmin=2 ))  ) 
		sess.run(p)
		_, var_J = sess.run( [ J , J  ] , feed_dict={ X: train_X ,  y : train_y }  )
		print var_J
		#"""

		sess.run( tf.global_variables_initializer() )

		# Visualize 3
		step = 1
		summary_writer = tf.summary.FileWriter('./logs', graph_def=sess.graph_def )

		var_theta = 0
		for i in xrange( iterate_step ):
			_,var_theta, var_J = sess.run( [train_op , theta , J  ] , feed_dict={ X: train_X ,  y : train_y }  )
			#print var_J , var_J.shape
			# Visualize 4
			if step % display_step == 0:
				summary_str = sess.run(merged_summary_op, feed_dict={ X: train_X ,  y : train_y } )
				summary_writer.add_summary(summary_str, step)
				pass
			step += 1

		print var_J
		#print var_theta 
		#print var_theta.shape

	#plotDecisionBoundary( var_theta, train_X , train_y  ) 
	# Compute accuracy on our training set
	p = predict(var_theta, train_X );
	#print p  == train_y 
	print  'Train Accuracy: %f' % (np.mean( 1.0*(p == train_y)) * 100) ; 


	pass


if __name__ == '__main__':
	#test()
	#ex1()
	ex2_logisticRegression()
	#ex2_regularizedLogisticRegression()

	print 'done'



