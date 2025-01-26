extends Area2D

func _ready():
	area_entered.connect(on_area_entered)
	
func on_area_entered(area: Area2D):
	print("area entered!")
	if area.get_parent().is_in_group("attack"):
		# Get the parent of the hurtbox (the enemy)
		var enemy = get_parent()
		enemy.queue_free()
