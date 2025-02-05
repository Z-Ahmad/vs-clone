extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	animation_finished.connect(on_animation_finished)
	play("default")

func on_animation_finished():
	queue_free()
