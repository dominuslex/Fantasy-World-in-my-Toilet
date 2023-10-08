extends Control

var loading_screen
@export var starting_map : PackedScene

func _ready():
	loading_screen = get_node("LoadingScreen")
	
func _on_start_game_pressed():
	loading_screen.show()
	loading_screen.load_scene(starting_map)
