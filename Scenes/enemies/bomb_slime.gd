extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
const FUSE_RADIUS = 60.0
const MAX_SPEED = 35.0
const MIN_SPEED = 10.0

var player = null
var is_fusing = false
var is_exploding = false
var current_speed = 10.0

func _ready():
	player = get_tree().get_first_node_in_group("player") as Node2D
	var frames = animated_sprite.sprite_frames
	frames.set_animation_loop("fuse", false)
	frames.set_animation_loop("explosion", false)
	frames.set_animation_speed("explosion", 8.0)
	animated_sprite.play("idle")

func _process(_delta):
	if !player:
		return
		
	var distance = global_position.distance_to(player.global_position)
	var direction = get_direction_to_player()
	velocity = direction * current_speed
	move_and_slide()
	
	if distance <= FUSE_RADIUS and !is_exploding:
		if !is_fusing:
			is_fusing = true
			current_speed = MAX_SPEED

			animated_sprite.play("fuse")
			print("Starting fuse animation")
			await animated_sprite.animation_finished
			print("Fuse animation finished")
			
			if distance <= FUSE_RADIUS:
				is_exploding = true
				is_fusing = false
				current_speed = 0.0
				print("Starting explosion animation")
				animated_sprite.play("explosion")
				print("Current frame: ", animated_sprite.frame)
				await animated_sprite.animation_finished
				print("Explosion animation finished")
				queue_free()
	elif !is_exploding:
		is_fusing = false
		current_speed = MIN_SPEED
		animated_sprite.play("idle")


func get_direction_to_player():
	if player != null:
		return (player.global_position - global_position).normalized()
	return Vector2.ZERO
