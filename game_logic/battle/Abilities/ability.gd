extends Node2D

class_name Ability

var targets
	


func use(user : Battler, target):
	print(user.name, " v. ", target.name)
	pass
	
func run_to_target(user: Battler, target : Battler) -> bool:
	if user != target:
		user.audio_stream.stream = ResourceLoader.load("res://audio/sfx/footstep grass light step.wav")
		user.audio_stream.play()
		var tween = create_tween()
		tween.tween_property(
			user.sprite, 
			"global_position", 
			target.sprite.global_position + Vector2(target.sprite.sprite_frames.get_frame_texture("idle",0).get_width(),0), 
			.5)
		await tween.finished
	return true
		
func jump_to_start_position(user: Battler, jump_height : float = 100, duration : float = .5) -> bool:
	var tween = create_tween()
	var halfway_distance = user.sprite.position / 2
	tween.tween_property(user.sprite, "global_position", Vector2(user.sprite.global_position.x - (halfway_distance.x + halfway_distance.x/2),user.sprite_origin.y - jump_height), duration/2).set_ease(tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(user.sprite,"position", Vector2.ZERO,duration/2).set_ease(tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	await tween.finished
	return true

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
