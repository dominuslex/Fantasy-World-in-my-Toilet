extends Node2D

var anim_complete : bool
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	await anim_complete
	var anim : Animation = anim.animation_track_get_key_animation()

func _on_animation_player_animation_finished(anim_name):
	anim_complete = true
