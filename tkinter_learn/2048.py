#!/usr/local/bin/python3

import tkinter as tk
import colors as c
import random

class Game(tk.Frame):
    def __init__(self):
        tk.Frame.__init__(self)
        self.grid()
        self.master.title( "2048" )

        self.main_grid = tk.Frame(
            self, bg=c.GAME_COLOR, bd=3,width=600,height=600
        )
        self.main_grid.grid( pady=(100,0) )
        self.make_GUI()
        self.start_game()
        self.mainloop()


    def make_GUI(self):
        # make grid
        self.cells = []
        for i in range(4):
            row = []
            for j in range(4):
                cell_frame = tk.Frame(
                    self.main_grid,
                    bg=c.EMPTY_COLOR,
                    width= 150,
                    height=150
                )

                def click( event):
                    print( "click", event,i,j )

                cell_frame.grid(row=i,column=j, padx=5,pady=5)
                cell_frame.bind( "<Button-1>", click )
                
                cell_number = tk.Label( 
                    self.main_grid, 
                    bg=c.EMPTY_COLOR 
                )
                cell_number.grid(row=i,column=j)
                
                cell_data = { "frame":cell_frame, "number":cell_number }
                row.append(cell_data)
            self.cells.append(row)
        
        # make score header
        score_frame = tk.Frame(self)
        # top center
        score_frame.place( relx=0.5, y=45, anchor="center" )
        tk.Label(
            score_frame,
            text = "score",
            font = c.LABEL_FONT
        ).grid( row=0 )

        self.score_label = tk.Label(score_frame,text="0",font=c.LABEL_FONT)
        self.score_label.grid( row=1 )

    def start_game(self):
        self.matrix = [[0]*4 for _ in range(4)]

        # fille 2 random celles with 2s
        row = random.randint(0,3)
        col = random.randint(0,3)
        self.matrix[row][col] = 2
        self.cells[row][col]["frame"].configure(
            bg=c.TILE_COLORS[2]
        )
        self.cells[row][col]["number"].configure(
            bg=c.TILE_COLORS[2],
            fg=c.LABEL_COLORS[2],
            font=c.LABEL_FONT,
            text="2"
        )

        
 

if __name__=='__main__':
    Game()
