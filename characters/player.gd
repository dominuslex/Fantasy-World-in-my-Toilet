extends Node2D


func _physics_process(_delta):
	$Character.direction.x = Input.get_axis("ui_left", "ui_right")
	$Character.direction.y = Input.get_axis("ui_up", "ui_down")
