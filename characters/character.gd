extends CharacterBody2D

const SPEED = 3000
const TILE_SIZE = 24

var target_position : Vector2 = global_position
var direction : Vector2
var sprite : AnimatedSprite2D 

func _ready():
	sprite = get_node("%AnimatedSprite2D")

func move(direction : Vector2) :
	pass


#func _physics_process(_delta):
#
#	if (direction):
#		var global_position_nearest_tile : Vector2 = Vector2(closest_number(global_position.x, TILE_SIZE), closest_number(global_position.y, TILE_SIZE))
#		#if global_position.distance_to(global_position_nearest_tile) > .2 :
#		direction = direction * TILE_SIZE
#		target_position = global_position_nearest_tile + direction
#		print (target_position)
#
#	velocity = global_position.direction_to(target_position) * SPEED * _delta
#
#	if global_position.distance_to(target_position) > 2:
#		move_and_slide()
#
#
#	direction.x = Input.get_axis("ui_left", "ui_right")
#	direction.y = Input.get_axis("ui_up", "ui_down")
#
#	print(global_position)
#
#func closest_number(number : int, divisor : int) :
#	for i in divisor:
#		if((number - i) % divisor == 0) :
#			print(number - i)
#			return number - i
#		if ((number + i) % divisor == 0) :
#			print (number + i)
#			return number + i
#	return number
	
func animate():
	sprite.play("walk_down")
