extends CharacterBody2D

@export var movement_speed = 150.0
@export var last_direction = Vector2.RIGHT #default direction
const MAX_HEALTH = 100.0

var current_health = MAX_HEALTH

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(_delta):
	player_movement()
	
	
func player_movement () :
	# Get input directions
	var direction = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	).normalized()  # Normalize the input vector
	
	if direction.length() > 0:
		last_direction = direction
	
	# Set velocity based on normalized direction
	velocity = direction * movement_speed
	
	# Update animation based on movement
	if velocity.length() > 0:
		animated_sprite.play("run")
		# Flip sprite based on horizontal movement direction
		if direction.x != 0:
			animated_sprite.flip_h = direction.x < 0
	else:
		animated_sprite.play("idle")
	
	move_and_slide()
