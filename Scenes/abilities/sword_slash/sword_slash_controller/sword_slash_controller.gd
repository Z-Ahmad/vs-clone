extends Node2D


@export var sword_ability: PackedScene
@export var cooldown_time: float = 2

var can_use_ability: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$CooldownTimer.timeout.connect(on_cooldown_timer_timeout)
	pass
#	run on_timer_timeout whenever the timer runs out
	#$Timer.timeout.connect(on_timer_timeout)


#func on_timer_timeout():
func _process(delta):
	
	if Input.is_action_just_pressed("ui_accept") and can_use_ability:
		var player = get_tree().get_first_node_in_group("player")
		if player == null:
			return
			
		var spawn_position = player.global_position
		var spawn_direction = player.last_direction
			
			
		# if space is pressed, spawn sword
		var sword_instance = sword_ability.instantiate() as Node2D
	
# Flip the sword based on player direction
		if spawn_direction.x < 0:
			sword_instance.scale.x = -1
		else:
			sword_instance.scale.x = 1

		player.add_child(sword_instance)
	
		# Start cooldown	
		can_use_ability = false
		$CooldownTimer.start()
		
func on_cooldown_timer_timeout():
	print("timeout")
	can_use_ability = true
