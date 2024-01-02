extends Node2D

var monsters : Array
var heroes : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	monsters.clear()
	heroes.clear()
	for child in find_child("Monsters").get_children():
		if child is Battler :
			child.is_monster = true
			monsters.append(child)
	for child in find_child("Heroes").get_children():
		if child is Battler :
			child.is_monster = true
			heroes.append(child)
	print(monsters,heroes)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func process_target_selection() -> Battler:
	var target : Battler
	return target
	

