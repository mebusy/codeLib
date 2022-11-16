from map import map_create

class obj_Game:
    def __init__(self):
        self.current_map = map_create()
        self.urrent_objects = []
        self.message_history = []
