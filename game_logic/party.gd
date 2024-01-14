extends Node

@onready var team = $Team 
@onready var backup = $Backup
@onready var not_in_party = $NotInParty

@export var team_formation : int
	
func _ready():
	print ("Team: ", team.get_children())
	print ("Backup: ", backup.get_children())
	print ("NotInParty: ", not_in_party.get_children())
	
	
func remove_from_party (hero:Hero):
	hero.reparent(not_in_party)
	print ("Team: ", team.get_children())
	print ("Backup: ", backup.get_children())
	print ("NotInParty: ", not_in_party.get_children())
	
func remove_from_team(hero:Hero):
	hero.reparent(backup)
	
func add_to_team(hero:Hero):
	if team.get_child_count() <3 :
		hero.reparent(team)
	else :
		hero.reparent(backup)
		print("No more space on the team, hero placed in backup")

func swap_positions(first_hero_to_swap:Hero, second_hero_to_swap:Hero):
	var first_hero_to_swap_parent = first_hero_to_swap.get_parent()
	var first_hero_to_swap_index = first_hero_to_swap.get_index()
	
	var second_hero_to_swap_parent = second_hero_to_swap.get_parent()
	var second_hero_to_swap_index = second_hero_to_swap.get_index()

	first_hero_to_swap.reparent(second_hero_to_swap_parent)

	second_hero_to_swap_parent.move_child(first_hero_to_swap,second_hero_to_swap_index)	#Change the index of the first hero on the new parent which was originally second hero's parent
	
	second_hero_to_swap.reparent(first_hero_to_swap_parent)
	first_hero_to_swap_parent.move_child(second_hero_to_swap,first_hero_to_swap_index) #Change the index of the second hero on the new parent which was originally first hero's parent
	print ("Team: ", team.get_children())
	print ("Backup: ", backup.get_children())
	print ("NotInParty: ", not_in_party.get_children())
	
		


func _on_button_pressed():
	swap_positions($Backup/Hero,$Team/Xander)
