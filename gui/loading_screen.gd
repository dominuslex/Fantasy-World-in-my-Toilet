extends Control

var progress = []
var scene_name
var scene_load_status = 0


func _ready():
	#hide()
	pass
	
func load_scene(scene_to_load : PackedScene):
	scene_name = scene_to_load.resource_path
	ResourceLoader.load_threaded_request(scene_name)
	
func _process(_delta):
	if scene_name:
		scene_load_status = ResourceLoader.load_threaded_get_status(scene_name, progress)
		$CountdownLabel.text = str(floor(progress[0]*100)) + "%"
		print($CountdownLabel.text)
		if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
			var new_scene = ResourceLoader.load_threaded_get(scene_name)
			get_tree().change_scene_to_packed(new_scene)
