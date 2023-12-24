extends Node2D

class_name Ability

var battle_animation_player : AnimationPlayer
	
	
func _ready():
	var battle_scene = get_tree().root.get_node("BattleScene")
	if battle_scene :
		battle_animation_player = battle_scene.get_node("BattleAnimationPlayer")

func use(user : Battler, target : Battler):
	print(user.name, " v. ", target.name)
	pass
	
func run_to_target(user: Battler, target : Battler) -> bool:
	var tween = create_tween()
	tween.tween_property(
		user.sprite, 
		"global_position", 
		target.sprite.global_position + Vector2(target.sprite.sprite_frames.get_frame_texture("idle",0).get_width(),-50), 
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
