#!python3

import tkinter as tk

# window
window = tk.Tk()
window.title("My Window")
window.geometry("400x320")

# widgets
label1 = tk.Label(window, text="Label 1", background="red")
label2 = tk.Label(window, text="Label 2", background="blue")

# pack
# label1.pack(side="left", expand=True, fill="y")  # expand to entire window
# label2.pack(side="bottom")

# grid
# window.columnconfigure(0, weight=1)  # 3 columns with different weights (1, 1, 2)
# window.columnconfigure(1, weight=1)
# window.columnconfigure(2, weight=2)
# window.rowconfigure(0, weight=1)  # 1 row with weight 1
# window.rowconfigure(1, weight=1)  # 1 row with weight 1
#
# label1.grid(row=0, column=1, sticky="nsew")  # sticky: n, s, e, w, ne, se, sw, nw
# label2.grid(row=1, column=1, columnspan=2, sticky="nsew")

# place
label1.place(x=200, y=150, width=150, anchor="nw")
label2.place(
    relx=0.5, rely=0.5, anchor="center", relwidth=0.5, relheight=0.5
)  # large botton which has area of 1/4 of window

# run
window.mainloop()
