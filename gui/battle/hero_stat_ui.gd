extends VBoxContainer
class_name HeroStatUI

var connected_battler : Battler

@onready var icon : TextureRect = $HBoxContainer/Icon
@onready var stat_bar_container : VBoxContainer = $HBoxContainer/StatBarContainer
@onready var hp_progress_bar : TextureProgressBar = $HBoxContainer/StatBarContainer/HBoxContainer/HPProgressBar
@onready var mp_progress_bar : TextureProgressBar = $HBoxContainer/StatBarContainer/HBoxContainer2/MPProgressBar
@onready var cp_progress_bar : TextureProgressBar = $HBoxContainer/StatBarContainer/HBoxContainer3/CPProgressBar
@onready var progress_bar : ProgressBar = $ProgressBar

var icon_normal
var icon_dead : Texture2D
var icon_hurt : Texture2D
var icon_poisoned : Texture2D
var icon_confused : Texture2D

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func connect_battler(battler : Battler):
	connected_battler = battler
	icon.visible = true
	stat_bar_container.visible = true
	progress_bar.visible = true
	
	connected_battler.connect("hp_changed", hp_changed)
	connected_battler.connect("hurt", icon_hurt_animation)
	icon_normal = connected_battler.icon.sprite_frames.get_frame_texture("normal", 0)
	icon_dead = connected_battler.icon.sprite_frames.get_frame_texture("dead", 0)
	icon_hurt = connected_battler.icon.sprite_frames.get_frame_texture("hurt", 0)
	icon_poisoned = connected_battler.icon.sprite_frames.get_frame_texture("poisoned", 0)
	icon_confused = connected_battler.icon.sprite_frames.get_frame_texture("confused", 0)
	
	if icon_normal :
		icon.texture = icon_normal
	
	hp_progress_bar.max_value = connected_battler.stats.hp
	hp_progress_bar.value = connected_battler.stats.current_hp
	mp_progress_bar.max_value = connected_battler.stats.mp
	mp_progress_bar.value = connected_battler.stats.current_mp
	cp_progress_bar.max_value = connected_battler.stats.cp
	cp_progress_bar.value = connected_battler.stats.current_cp

	pass

func hp_changed(old_hp, new_hp):
	print("Old HP: ", old_hp, ", New HP: ", new_hp)
	
	var tween = create_tween()
	tween.tween_property(hp_progress_bar,"value", connected_battler.stats.current_hp, .4)
	
	pass

func icon_hurt_animation():
	icon.texture = icon_hurt
	await get_tree().create_timer(.5).timeout
	icon.texture = icon_normal
	

