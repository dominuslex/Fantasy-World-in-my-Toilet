extends AnimatedSprite2D

var animation_to_play = self.animation

func _on_walking_state_processing(_delta):
	var direction = get_parent().direction

	if direction.y > 0 :
		animation_to_play = "walk_down"
	elif direction.y < 0 :
		animation_to_play = "walk_up"
	if direction.x < 0 :
		animation_to_play = "walk_left"
	elif direction.x > 0 :
		animation_to_play = "walk_right"
	
		
	if animation_to_play != self.animation : 
		self.animation = animation_to_play



func _on_walking_state_entered():
	self.play()


func _on_idle_state_entered():
	self.pause()
	self.frame = 0
