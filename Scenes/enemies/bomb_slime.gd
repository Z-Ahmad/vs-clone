extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var movement = $Movement
var FUSE_RADIUS = 60.0

@export var normal_speed: float = 10.0
@export var fuse_speed: float = 67.0

var is_fusing = false
var is_exploding = false

func _ready():
	var frames = animated_sprite.sprite_frames
	frames.set_animation_loop("fuse", false)
	frames.set_animation_loop("explosion", false)
	frames.set_animation_speed("explosion", 8.0)
	animated_sprite.play("idle")
	movement.movement_speed = normal_speed

func _process(_delta):
	var player = get_tree().get_first_node_in_group("player")
	if !player:
		return
		
	var distance = global_position.distance_to(player.global_position)
	
	if distance <= FUSE_RADIUS and !is_exploding:
		if !is_fusing:
			is_fusing = true
			movement.movement_speed = fuse_speed
			animated_sprite.play("fuse")
			await animated_sprite.animation_finished
			
			if distance <= FUSE_RADIUS:
				is_exploding = true
				is_fusing = false
				animated_sprite.play("explosion")
				await animated_sprite.animation_finished
				get_node("healthbar").take_damage(100)
				queue_free()
	elif !is_exploding:
		is_fusing = false
		movement.movement_speed = normal_speed
		animated_sprite.play("idle")
