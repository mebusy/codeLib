

# .___________. __   __       _______
# |           ||  | |  |     |   ____|
# `---|  |----`|  | |  |     |  |__
#     |  |     |  | |  |     |   __|
#     |  |     |  | |  `----.|  |____
#     |__|     |__| |_______||_______|

class struct_Tile:
    def __init__(self, block_path):
        self.block_path = block_path
        self.explored = False 
