extends Ability

func use(user : Battler, target : Battler):
	var user_attack : float = float(user.stats.strength)
	var target_defense : float = float(target.stats.endurance)
	var damage = calculate_damage(user_attack, target_defense)
	
	user.sprite.play("attack")
	
	
	
	print("Damage: ", damage)
	if damage > 0:
		target.change_hp(-damage)
	else:
		print("NO DAMAGE!")
		
	print(target.stats.current_hp, " of " , target.stats.hp, " hp remaining.")
