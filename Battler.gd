extends Node2D

@export var stats : Stats

func _process(delta):
	level_up()

# Called when the node enters the scene tree for the first time.
func gain_experience(amount):
	if not stats.level == 99 :
		stats.experience_total += amount
		stats.experience_this_level += amount
		if stats.experience_this_level >= stats.experince_needed:
			level_up()


func level_up():
	stats.level = clamp(stats.level + 1, 1, 99)


