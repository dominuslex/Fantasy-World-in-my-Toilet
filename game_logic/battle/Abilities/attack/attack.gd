extends Ability

@export var sound_run : AudioStream
@export var sound_attack : AudioStream

func use(user : Battler, target : Battler):
	super(user,target)
	var user_attack : float = float(user.stats.strength)
	var target_defense : float = float(target.stats.endurance)
	var damage = calculate_damage(user_attack, target_defense)
	
	if(user != target) : 
		user.audio_stream.stream = sound_run
		user.audio_stream.play()
		await run_to_target(user,target)
	user.sprite.play("attack")

	await get_tree().create_timer(.5).timeout
	user.audio_stream.stream = sound_attack
	user.audio_stream.play()
	await user.sprite.animation_finished
	await get_tree().create_timer(.2).timeout
	if(user != target) :
		await jump_to_start_position(user)
	user.sprite.play("idle")
	
	
	print("Damage: ", damage)
	if damage > 0:
		target.change_hp(-damage)
	else:
		print("NO DAMAGE!")
		
	print(target.stats.current_hp, " of " , target.stats.hp, " hp remaining.")
