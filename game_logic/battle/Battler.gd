extends Node2D
class_name Battler

@export var stats : Stats
@onready var state_chart : StateChart = get_node("%StateChart")
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var sprite_origin : Vector2 = sprite.global_position
@onready var audio_stream : AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready():
	stats.current_hp = stats.hp

func _process(_delta):
	pass

func change_hp(amount : int) -> int:
	# Prevent hp from going above max hp
	if stats.current_hp + amount > stats.hp + 1 :
		stats.current_hp = stats.hp
	# Prevent hp from going below 0
	elif stats.current_hp + amount < 0:
		stats.current_hp = 0
	# If not above max hp or below 0 then change hp by amount
	else: stats.current_hp += amount
	#returning int just in case I want to get that information somewhere for some reason (like aborbing hp)
	return stats.current_hp
		
	
func use_ability(ability : Ability, user : Battler = self, target : Battler = self):
	state_chart.send_event("UseAbility")
	ability.use(user, target)
	print(ability.name + " used on " + target.name)
	
#func apply_status_effect(status_effect : StatusEffect, duration : int = 1):
	#if not status_effect in stats.status_effects:
		#stats.status_effects.append(status_effect)
		#print(stats.status_effects.size())
		#
	#var effect_to_update : int = stats.status_effects.bsearch(status_effect)
	#stats.status_effects[effect_to_update].duration += duration
		#
	#for effect in stats.status_effects:
		#print(effect.duration)
	


# Called when the node enters the scene tree for the first time.
func gain_experience(amount):
	if not stats.level == 99 :
		stats.experience_total += amount
		stats.experience_this_level += amount
		if stats.experience_this_level >= stats.experince_needed:
			level_up()


func level_up():
	stats.level = clamp(stats.level + 1, 1, 99)
	
func battle_init():
	sprite.play("idle")


func _on_button_pressed():
	use_ability($Abilities/Attack,self, find_parent("BattleScene").find_child("Battler"))


func _on_area_2d_mouse_entered():
	print(self.name)
	pass # Replace with function body.
