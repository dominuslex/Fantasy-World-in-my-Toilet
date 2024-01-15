extends Ability

@export var sound_run : AudioStream
@export var sound_attack : AudioStream
var ability_targets : Array

func use(user : Battler, targets):
	super(user,targets)
	
	if targets is Array:
		ability_targets = targets
		
	elif targets is Battler:
		var target = targets
		ability_targets.clear()
		ability_targets.append(target)
		if user.animation_player.get_animation("attack"):
			await run_to_target(user,targets)
			user.animation_player.play("attack")
			await user.animation_player.animation_finished
			apply_damage(user,target)
			#if target.animation_player.get_animation("hit") :
				#target.animation_player.play("hit")
			if (user != target):
				await jump_to_start_position(user)
		else:
			await programatic_animation(user, target)
		user.sprite.play("idle")


func apply_damage(user : Battler, target : Battler):
	var user_attack : float = float(user.stats.strength)
	var target_defense : float = float(target.stats.endurance)
	var damage = calculate_damage(user_attack, target_defense)
	
	print("Damage: ", damage)
	if damage > 0:
		target.change_hp(-damage)
	else:
		print("NO DAMAGE!")
		
	print(target.stats.current_hp, " of " , target.stats.hp, " hp remaining.")

func programatic_animation(user, targets) -> bool:
	if(user != targets) : 
		user.audio_stream.stream = sound_run
		user.audio_stream.play()
		await run_to_target(user,targets)
	user.sprite.play("attack")

	await get_tree().create_timer(.5).timeout
	user.audio_stream.stream = sound_attack
	user.audio_stream.play()
	await user.sprite.animation_finished
	await get_tree().create_timer(.2).timeout
	if(user != targets) :
		await jump_to_start_position(user)
	return true
	
func play_hit_animation() :
	for target : Battler in ability_targets :
		target.animation_player.play("hit")
		target.hurt.emit()
	
