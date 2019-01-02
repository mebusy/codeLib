import constants 

def helper_text_objects(incoming_text, incoming_color):
    
    Text_surface = constants.FONT_DEBUG_MESSAGE.render(incoming_text, False, incoming_color)

    return Text_surface, Text_surface.get_rect()
