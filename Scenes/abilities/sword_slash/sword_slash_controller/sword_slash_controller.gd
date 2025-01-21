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
		var player = get_tree().get_first_node_in_group("player") as Node2D
		if player == null:
			return
			
		var player_pos = player.global_position
		var player_velocity = player.velocity
			
		# if space is pressed, spawn sword
		var children = player.get_children()
		var sword_instance = sword_ability.instantiate() as Node2D
	
# Flip the sword based on movement direction
		if player_velocity.x < 0:
			sword_instance.scale.x = -1
		else:
			sword_instance.scale.x = 1

		player.add_child(sword_instance)
	
		can_use_ability = false
		$CooldownTimer.start()
		
func on_cooldown_timer_timeout():
	print("timeout")
	can_use_ability = true
