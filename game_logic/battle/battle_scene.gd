extends Node2D

var party

var monsters : Array
var heroes : Array

var team_formation
var hero_stat_ui_array : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	setup_party()
	add_monsters()
	connect_hero_stat_ui()
	pass 

func setup_party():
	party = get_node("/root/Party")
	if party.team_formation == 0:
		team_formation = find_child("HerosOneFront")
	else:
		team_formation = find_child("HerosTwoFront")
	for index in party.team.get_child_count():
		print(index)
		if party.team.get_child(index).find_child("*Battler"):
			var hero_marker : Marker2D
			var hero : Battler
			if index == 0 :
				hero_marker = team_formation.find_child("HeroMarker1")
			elif index == 1 :
				hero_marker = team_formation.find_child("HeroMarker2")
			elif index == 2 :
				hero_marker = team_formation.find_child("HeroMarker3")
			print(hero_marker)
			hero = party.team.get_child(index).find_child("*Battler")
			hero.reparent(hero_marker, false)
			hero.visible = true
			heroes.append(hero)
			print(hero)
			print("Heroes: ", heroes)
				# TO_DO Need to set the hero to the correct HeroMarker
func add_monsters():
	monsters.clear()
	for child in find_child("Monsters").get_children():
		if child is Battler :
			child.is_monster = true
			monsters.append(child)

			
func connect_hero_stat_ui():
	for child in get_node("Control/HeroStats").get_children():
		if child == HeroStatUI:
			hero_stat_ui_array.append(child)
		pass
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func process_target_selection() -> Battler:
	var target : Battler
	return target
	

