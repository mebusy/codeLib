#!/usr/local/bin/python3

import tkinter as tk
# use PIL handle image
from PIL import ImageTk as itk
from PIL import Image

# customized key down function
def click():
    input_text = textentry.get()
    # print( "get input text:", input_text )
    # clean output box
    output.delete(0.0, tk.END)
    output.insert( tk.END, input_text )

# #### main:
window = tk.Tk()
window.title( "learn tkinter" )

# set color
window.configure( bg="black" )

# #### photo
# tk work only with gif
photo1 = itk.PhotoImage( Image.open("/Volumes/WORK/WORK/mebusy_git_notes/imgs/1DConvolutionExample.jpg") )

tk.Label( window, image=photo1,  bg='black' ).grid( row=0, column=0, sticky=tk.E )

# create label
tk.Label( window, text="definition for: ", bg="black", fg="white", 
    font = "none 12 bold" ).grid( row=1,column=0, stick=tk.W )

# create a text entry box
textentry = tk.Entry( window, width=20, bg="white" )
textentry.grid( row=2, column=0, sticky=tk.W )

# add a submit button
tk.Button( window, text="SUBMIT", width=6, command=click ).grid( row=3, column=0, sticky=tk.W )

# create another label
tk.Label( window, text="\nDefinition:", bg="black", fg="white", 
    font="none 12 bold").grid( row=4, column=0, sticky=tk.W )

# create a text box
output = tk.Text( window, width=75,height=6, wrap=tk.WORD, background="white" )
output.grid( row=5, column=0, sticky=tk.W )



# #### run the main loop
window.mainloop()


