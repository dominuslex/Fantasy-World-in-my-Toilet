extends Node2D

var party

var monsters : Array
var heroes : Array

var team_formation
var hero_stat_ui_array : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	add_hero_stat_ui()
	setup_party()
	add_monsters()

	pass 

func setup_party():
	party = get_node("/root/Party")
	if party.team_formation == 0:
		team_formation = find_child("HerosOneFront")
	else:
		team_formation = find_child("HerosTwoFront")
	for index in party.team.get_child_count():
		if party.team.get_child(index).find_child("*Battler"):
			var hero : Hero
			var hero_battler : Battler
			var hero_marker : Marker2D
			
			
			hero = party.team.get_child(index)
			heroes.append(hero) # Adding Hero to heroes array. Connecting original hero to UI, to see if changes to the HP of instance will change OG hero
			
			if index == 0 :
				hero_marker = team_formation.find_child("HeroMarker1")
			elif index == 1 :
				hero_marker = team_formation.find_child("HeroMarker2")
			elif index == 2 :
				hero_marker = team_formation.find_child("HeroMarker3")
			
			hero_battler = hero.find_child("*Battler").duplicate(8)
			hero_marker.add_child(hero_battler)
			hero_stat_ui_array[index].connect_battler(hero_battler)
			hero_battler.visible = true

			print(hero)
			print("Heroes: ", heroes)
				# TO_DO Need to set the hero to the correct HeroMarker
func add_monsters():
	monsters.clear()
	for child in find_child("Monsters").get_children():
		if child is Battler :
			child.is_monster = true
			monsters.append(child)

			
func add_hero_stat_ui():
	var hero_stats_ui = get_node("Control/HeroStats")
	for child in hero_stats_ui.get_children():
		if child is HeroStatUI:
			hero_stat_ui_array.append(child)
		pass
	print("Hero UI: ", hero_stat_ui_array)
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func process_target_selection() -> Battler:
	var target : Battler
	return target
	

