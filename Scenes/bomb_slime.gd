extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
var player = null
var is_fusing = false
const DETECTION_RADIUS = 30.0

func _ready():
	player = get_node("/root/Node2D/Player")
	print("Player reference: ", player)
	animated_sprite.play("idle")
	print("Available animations: ", animated_sprite.sprite_frames.get_animation_names())
	# Get the sprite frames resource
	var frames = animated_sprite.sprite_frames
	# Set loop to false for specific animations
	frames.set_animation_loop("fuse", false)
	frames.set_animation_loop("explosion", false)

func _process(_delta):
	if !player:
		print("No player reference!")
		return
		
	var distance = global_position.distance_to(player.global_position)
	print("Distance to player: ", distance)
	
	if distance <= DETECTION_RADIUS:
		print("Player in range! Is fusing: ", is_fusing)
		if !is_fusing:
			# Start fuse sequence
			is_fusing = true
			animated_sprite.play("fuse")
			print("Starting fuse animation")
			# Wait for fuse animation to complete
			await animated_sprite.animation_finished
			if distance <= DETECTION_RADIUS:
				print("BOOM!")
				# Player still in range, explode!
				animated_sprite.play("explosion", false)
				await animated_sprite.animation_finished
				print("Explosion finished, removing node")
				queue_free()
	else:
		# Reset if player moves away
		if is_fusing:
			print("Player escaped! Resetting...")
		is_fusing = false
		animated_sprite.play("idle")
