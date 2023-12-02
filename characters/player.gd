@tool
extends Node2D

@export var stats : Stats

func _physics_process(_delta):
	if not Engine.is_editor_hint():
		$Character.direction.x = Input.get_axis("ui_left", "ui_right")
		$Character.direction.y = Input.get_axis("ui_up", "ui_down")

func _process(_delta):
	if Engine.is_editor_hint():
		pass
