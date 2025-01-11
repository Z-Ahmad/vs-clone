extends CharacterBody2D

const SPEED = 150.0

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(_delta):
	# Get input directions
	var directionX = Input.get_axis("ui_left", "ui_right")
	var directionY = Input.get_axis("ui_up", "ui_down")
	
	# Set velocity based on both directions simultaneously
	velocity.x = directionX * SPEED
	velocity.y = directionY * SPEED
	
	# Update animation based on movement
	if velocity.length() > 0:
		animated_sprite.play("run")
		# Flip sprite based on horizontal movement direction
		if directionX != 0:
			animated_sprite.flip_h = directionX < 0
	else:
		animated_sprite.play("idle")
	
	move_and_slide()
