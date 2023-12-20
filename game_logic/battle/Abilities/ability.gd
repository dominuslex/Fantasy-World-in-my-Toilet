extends Node2D

class_name Ability

func use(user : Battler, target : Battler):
	pass

func calculate_damage(attack : float, defense : float) -> float:
	var damage
	if (attack >= defense):
		damage = (attack * 2) - defense
		var random_damage_modifier = randi_range(0,ceil(damage/16))
		var random_dir = pow(-1, randi() % 2)
		damage += random_damage_modifier * random_dir
	else:
		damage = attack * (attack / (defense * 1.2))
		var random_damage_modifier = randi_range(0,ceil(damage/16))
		var random_dir = pow(-1, randi() % 2)
		damage += random_damage_modifier * random_dir
		damage = ceil(damage)
	return damage
