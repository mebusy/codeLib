
#py

import os , math
import shutil

from PIL import Image, ImageColor, ImageEnhance, ImageChops , ImageOps
from colorsys import rgb_to_hls, hls_to_rgb

import numpy as np

from colorsys import rgb_to_hls, hls_to_rgb

import json


"""
im = Image.open("nevanda32black.png")
im.load()

im = im.convert( "RGBA" )

size = im.size 

TILE_W = 32
TILE_H = 32

TILES_HORI = size[0] / TILE_W
TILES_VERT = size[1] / TILE_H

print TILES_HORI , TILES_VERT


im_new_tileset = Image.new( "RGBA" , ( (TILE_W+1)* TILES_HORI  ,  (TILE_H+1)* TILES_VERT  ) , '#383737' )

for j in xrange(TILES_VERT  ):
	for i in xrange(TILES_HORI  ):

		x = i * TILE_W
		y = j * TILE_H 

		#print x,y

		box = ( x, y , x + TILE_W , y + TILE_H )
		im_tile = im.crop(box)

		x,y = i * (TILE_W+1), j * (TILE_H+1) 
		box_new = ( x, y , x + TILE_W , y + TILE_H )
		im_new_tileset.paste( im_tile , box_new  )

		# = Image.new( "RGBA" , ( TILE_W, TILE_H ) , '#383737' )
		#im_tile.paste( im,  )

		#if i==5 and j==5:
			#im_tile.show()


#im_new_tileset.show()
im_new_tileset.save( "new_tiles_set.png" , "PNG" )

"""



im = Image.open("new_tiles_set_m.png")
im.load()

print im.mode, im.format

#im.show()
#png_info = im.info

#print png_info


size = im.size 

TILE_W = 32+1
TILE_H = 32+1

TILES_HORI = size[0] / TILE_W
TILES_VERT = size[1] / TILE_H

TILE_FOLDER = "./all_tiles"

if os.path.exists( TILE_FOLDER ):
	shutil.rmtree( TILE_FOLDER )

os.mkdir(TILE_FOLDER) 

def point( x ):
	print x  

for j in xrange(TILES_VERT  ):
	for i in xrange(TILES_HORI  ):

		x = i * TILE_W
		y = j * TILE_H 

		#print x,y

		box = ( x, y , x + TILE_W-1 , y + TILE_H-1 )
		im_tile = im.crop(box)

		#im_tile.show()
		#print im_tile.mode
		im_tile.save( os.path.join( TILE_FOLDER ,  "%02d%02d.png" % (j,i) ) , "PNG" )

		#print A.mode
		#A.show()







def rgb2hls(t):
	""" convert PIL-like RGB tuple (0 .. 255) to colorsys-like
	HSL tuple (0.0 .. 1.0) """
	r,g,b,a = t
	r /= 255.0
	g /= 255.0
	b /= 255.0
	return rgb_to_hls(r,g,b)

def hls2rgb(t):
	""" convert a colorsys-like HSL tuple (0.0 .. 1.0) to a
	PIL-like RGB tuple (0 .. 255) """
	r,g,b = hls_to_rgb(*t)
	r *= 255
	g *= 255
	b *= 255
	return (int(r),int(g),int(b))

def trim(im):
	R,G,B,A = im.split()
	bg = Image.new( A.mode, A.size, A.getpixel((0, 0)))
	diff = ImageChops.difference(A, bg)
	bbox = diff.getbbox()
	#print bbox
	if not bbox:
		return im
	return im.crop(bbox)

def averageHSV( im ):

	#im = Image.new( "RGBA" , (32,32) , "#FF0024" )

	R,G,B,A = im.split()

	im = im.convert( "HSV" )
	#print im_tile.getcolors( 1024 ) 
	H,S,V = im.split()

	A = np.array(list(A.getdata())) / 255

	result = []

	S_mask = np.array(list(S.getdata())) / 255.0

	for Channel in [H,S,V] :
		v = np.array( list(Channel.getdata()) ) * A 
		if Channel == H:
			v = v * ( S_mask > 0.1 )
			pass
		v = np.sum(v)
		s = np.sum(A)

		if s == 0 :
			result.append( -1 )
		else:
			result.append( v * 1.0 / s / 255.0 )
	return result

monster_mapping = [
	#j,i ,hueVal , majorH 
	(4,22  , None , 0.097   ) ,  #"you"
	(2, 9  , None , None   )  ,  # "rat"
	(1, 20 , None, 0.092  ) , #"kobold"
	(0, 14 , None, 0.105    ) , #"jackal"
	(5,17 , 0.05 , -0.389  ) , # (8, 3)  , #"eel"
	(5, 35 , None, 0.111  ) , # "monkey"
	(21, 28 , None, None   ) , # "bloat"
	(24, 31 , None, -0.194   ) , # "pit bloat"
	(1, 31 , None, None  ) , # "goblin"
	(1, 32 , None, None  ) , # "goblin conjurer"
	(1, 32 , None, None  ) , # "goblin mystic"
	None  ,  # "golbin totem"
	(1, 18 , None , None  ) , # "pink jelly"

]

all_major_hue = []
for key in xrange( len(monster_mapping) ):
	if  monster_mapping[key] == None:
		all_major_hue.append(  None  )
		continue 

	# hueVal: if not None, image will change to this color

	j,i ,hueVal , majorH   = monster_mapping[key]
	path_tile = os.path.join( TILE_FOLDER ,  "%02d%02d.png" % (j,i) ) 
	path_dst = "../../Brogue_U3D/Assets/Resources/Monster/monster_%03d.png" % (int)(key)
	#shutil.copy(path_tile, path_dst)

	im = Image.open( path_tile );
	im.load()



	im_trim = trim( im )
	factor = min( im.size[0]*1.0/ im_trim.size[0] ,  im.size[1]*1.0/ im_trim.size[1] )
	im_trim = im_trim.resize(  ( (int)(round(im_trim.size[0]*factor)) ,  (int)(round(im_trim.size[1]*factor)) ) , Image.ANTIALIAS )

	im_new = Image.new( im.mode, im.size , im.getpixel( (0,0) ) )
	x = ( im_new.size[0] - im_trim.size[0] )/2 
	y = ( im_new.size[1] - im_trim.size[1] )/2 

	im_new.paste(  im_trim , (  x,y  )  )

	if key == 10 :  # goblin mystic
		im_new = ImageOps.mirror(im_new)

	im = im_new
	#im = ImageEnhance.Contrast(im).enhance(1.6)
	#im = ImageOps.autocontrast( im.convert("RGB") )

	aveH ,aveS, aveV =  averageHSV( im )
	#print aveH ,aveS, aveV 

	if hueVal != None:
		# huaval  [0,360] , get from GIMP
		hueval_2_shift = hueVal  -  majorH 
		#print hueval_2_shift , hueVal  ,  aveH 
		imgdata = list(im.getdata())
		for i in range(0,len(imgdata)):
			r,g,b,a = imgdata[i]

			(h,l,s) = rgb2hls(imgdata[i])
			#s *= 0.2
			h += hueval_2_shift
			r,g,b = hls2rgb((h,l,s))
			imgdata[i] = ( r,g,b , a  )

		im.putdata(imgdata)

		#im = shiftHue.colorize( im , hueval_2_shift )

		all_major_hue.append( hueVal )

	else:
		all_major_hue.append( majorH  )
	
	im.save( path_dst , "PNG" )


	
	#im.show()
	#H.show("h")
	#S.show("s")
	#V.show("v")
#"""

print all_major_hue
print ''

out = ""
for i, v in enumerate(  all_major_hue ) :
	if i % 10 == 0:
		out += "\n"
	out = "%s%.3ff," %  (out,v or 99 ) 
print out