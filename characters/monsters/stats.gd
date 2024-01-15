@tool
extends Resource

class_name Stats

var default_stat_99_curve : Curve = load("res://game_logic/battle/stat curves/default_stat_99_curve.tres")
var default_stat_999_curve : Curve = load("res://game_logic/battle/stat curves/default_stat_999_curve.tres")

@export_range(1,99) var level: int = 1: set = _set_lvl_stats
@export_range(10,12000) var hp : int = 10
@export_range(0,999) var mp : int = 1
var cp : int = 200
@export_range(1,99) var strength : int = 1
@export_range(1,99) var magic : int = 1
@export_range(1,99) var spirit : int = 1
@export_range(1,99) var endurance : int = 1
@export_range(1,99) var agility : int = 1
@export_range(1,99) var luck : int = 1

var current_hp : int
var current_mp : int
var current_cp : int = 0
var status_effects = []


@export_category("Growth Curves")
@export var hp_curve : Curve = default_stat_999_curve
@export var mp_curve : Curve = default_stat_999_curve
@export var st_curve : Curve = default_stat_99_curve
@export var ma_curve : Curve = default_stat_99_curve
@export var sp_curve : Curve = default_stat_99_curve
@export var en_curve : Curve = default_stat_99_curve
@export var ag_curve : Curve = default_stat_99_curve
@export var lu_curve : Curve = default_stat_99_curve
@export var exp_needed_curve : Curve = default_stat_999_curve

var experience_total: int
var experience_this_level: int
var experince_needed: int


func _set_lvl_stats (value) :
	level = value
	experience_this_level = experience_this_level - experince_needed
	experince_needed = get_experience_needed(level)
	
	if (hp_curve) :
		hp = round(hp_curve.sample(value * .01))
	if (mp_curve) :
		mp = round(mp_curve.sample(value * .01))
	if (st_curve) :
		strength = round(st_curve.sample(value * .01))
	if (ma_curve) :
		magic = round(ma_curve.sample(value * .01))
	if (sp_curve) :
		spirit = round(sp_curve.sample(value * .01))
	if (en_curve) :
		endurance = round(en_curve.sample(value * .01))
	if (ag_curve) :
		agility = round(ag_curve.sample(value * .01))
	if (lu_curve) :
		luck = round(lu_curve.sample(value * .01))
		
func get_experience_needed(level):
	return round(pow(level + 1, 1.6) + level * 4)

###### CREATE SIGNAL for HP change ######
