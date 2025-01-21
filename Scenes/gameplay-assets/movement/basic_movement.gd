extends Node

@export var movement_speed: float = 10.0
@export var parent: CharacterBody2D

var player: Node2D = null

func _ready():
	# Get the parent automatically if not set
	if !parent:
		parent = get_parent() as CharacterBody2D
		
	player = get_tree().get_first_node_in_group("player")
	print("Movement ready - Parent: ", parent, " Player: ", player)
	
func _physics_process(_delta):
	if !player or !parent:
		print("Missing references - Parent: ", parent, " Player: ", player)
		return
		
	var direction = get_direction_to_player()
	parent.velocity = direction * movement_speed
	parent.move_and_slide()

func get_direction_to_player() -> Vector2:
	if player != null:
		return (player.global_position - parent.global_position).normalized()
	return Vector2.ZERO
