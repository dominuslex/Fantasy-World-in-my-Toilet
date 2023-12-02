extends CharacterBody2D

class_name Character

const MAX_SPEED = 150
const TILE_SIZE = 24

var speed = 0

var direction : Vector2 = Vector2.ZERO
var target_position : Vector2 = global_position
var target_direction : Vector2
var is_moving : bool

var sprite : AnimatedSprite2D 
var shape_cast : ShapeCast2D
var animation_to_play : String

@onready var state_chart = get_node("%StateChart")

func _ready():
	sprite = $AnimatedSprite2D
	animation_to_play = $AnimatedSprite2D.animation
	shape_cast = get_node("ShapeCast2D")
	global_position = closest_vector(global_position, TILE_SIZE)


func move(value: Vector2):
	direction = value

func _physics_process(_delta):
	
	speed = 0
	
	if not is_moving and direction != Vector2.ZERO :
		target_direction = direction.normalized()
		shape_cast.target_position = target_direction.round() * roundi(TILE_SIZE + TILE_SIZE/4)
		shape_cast.force_shapecast_update()
		if not shape_cast.is_colliding() :
			state_chart.send_event("movement_started")
			target_position = global_position + (target_direction * TILE_SIZE)
			is_moving = true
	elif not is_moving:
		state_chart.send_event("movement_completed") 
			
		
	elif  is_moving:
		speed = MAX_SPEED
		velocity = speed * target_direction * _delta
		var distance_to_target = global_position.distance_to(closest_vector(target_position,TILE_SIZE))
		var move_distance = velocity.length()
		if distance_to_target < move_distance:
			velocity = target_direction * distance_to_target
			is_moving = false
			
			
		#print ("Pos: ", target_position, "; Velocity: ", velocity, "; Distance: ", distance_to_target)
		move_and_collide(velocity)
		



func _on_walking_state_processing(_delta):
	if direction.y > 0 :
		animation_to_play = "walk_down"
	elif direction.y < 0 :
		animation_to_play = "walk_up"
	if direction.x < 0 :
		animation_to_play = "walk_left"
	elif direction.x > 0 :
		animation_to_play = "walk_right"
	
		
	if animation_to_play != sprite.animation : 
		sprite.animation = animation_to_play



func _on_walking_state_entered():
	sprite.play()


func _on_idle_state_entered():
	sprite.pause()
	sprite.frame = 0
	


func closest_number(number : int, divisor : int):
	for i in divisor:
		if((number - i) % divisor == 0) :
			return number - i
		if ((number + i) % divisor == 0) :
			return number + i
	print("Error in closest number")
	return number
	
func closest_vector(vector : Vector2, divisor : int):
	var x = closest_number(vector.x, divisor)
	var y = closest_number(vector.y, divisor)
	return Vector2(x, y)
