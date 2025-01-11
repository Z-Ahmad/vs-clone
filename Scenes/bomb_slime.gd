extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
var player = null
var is_fusing = false
var is_exploding = false
const DETECTION_RADIUS = 30.0

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	var frames = animated_sprite.sprite_frames
	frames.set_animation_loop("fuse", false)
	frames.set_animation_loop("explosion", false)
	frames.set_animation_speed("explosion", 8.0)
	animated_sprite.play("idle")

func _process(_delta):
	if !player:
		return
		
	var distance = global_position.distance_to(player.global_position)
	
	if distance <= DETECTION_RADIUS and !is_exploding:
		if !is_fusing:
			is_fusing = true
			animated_sprite.play("fuse")
			print("Starting fuse animation")
			await animated_sprite.animation_finished
			print("Fuse animation finished")
			
			if distance <= DETECTION_RADIUS:
				is_exploding = true
				is_fusing = false
				print("Starting explosion animation")
				animated_sprite.play("explosion")
				print("Current frame: ", animated_sprite.frame)
				await animated_sprite.animation_finished
				print("Explosion animation finished")
				queue_free()
	elif !is_exploding:
		is_fusing = false
		animated_sprite.play("idle")
