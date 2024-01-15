extends Node2D
class_name Battler

@onready var icon : AnimatedSprite2D = $Icon

@export var stats : Stats
@onready var state_chart : StateChart = get_node("%StateChart")
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var sprite_origin : Vector2 = sprite.global_position
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var audio_stream : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var hp_progress_bar : TextureProgressBar = $HPTextureProgressBar
var fade : float
var is_monster : bool


signal hp_changed(old_hp : int, new_hp : int)
signal hurt()

func _ready():
	stats.current_hp = stats.hp
	hp_progress_bar.max_value = stats.hp
	hp_progress_bar.value = stats.current_hp

func _process(_delta):
	pass

func change_hp(amount : int) -> int:
	# Prevent hp from going above max hp
	var old_hp = stats.current_hp
	if stats.current_hp + amount > stats.hp + 1 :
		stats.current_hp = stats.hp
	# Prevent hp from going below 0
	elif stats.current_hp + amount < 0:
		stats.current_hp = 0
		battler_death()
	# If not above max hp or below 0 then change hp by amount
	else: 
		stats.current_hp += amount
	#returning int just in case I want to get that information somewhere for some reason (like aborbing hp)
	var tween = create_tween()
	tween.tween_property(hp_progress_bar,"value", stats.current_hp, .4)
	hp_changed.emit(old_hp, stats.current_hp)
	return stats.current_hp
		
	
func use_ability(ability : Ability, user : Battler = self, target = self):
	if target is Battler:
		state_chart.send_event("UseAbility")
		ability.use(user, target)
		print(ability.name + " used on " + target.name)
	elif target is Array:
		for i : Battler in target :
			state_chart.send_event("UseAbility")
			ability.use(user, i)
			
func battler_death():
	var tween = create_tween()
	tween.tween_method(set_shader_value,1.0,0.0,1)
	audio_stream.stream = ResourceLoader.load("res://audio/sfx/death_test.wav")
	audio_stream.play()
	pass

func set_shader_value(value: float):
	sprite.material.set_shader_parameter("fade", value)
	
# Called when the node enters the scene tree for the first time.
func gain_experience(amount):
	if not stats.level == 99 :
		stats.experience_total += amount
		stats.experience_this_level += amount
		if stats.experience_this_level >= stats.experince_needed:
			level_up()


func level_up():
	stats.level = clamp(stats.level + 1, 1, 99)
	
func update_hp_progressbar(current_hp : int):
	var hp_progressbar : TextureProgressBar = $HPTextureProgressBar
	hp_progressbar
	pass
	
func battle_init():
	sprite.play("idle")


func _on_button_pressed():
	use_ability($Abilities/Attack,self, self)


func _on_area_2d_mouse_entered():
	print(self.name)
	
	pass # Replace with function body.
	

