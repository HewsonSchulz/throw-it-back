extends AnimatedSprite2D

func _ready():
	# set initial fade to 0 (black)
	set_fade(0.0)

	fade(1, 2)

func set_fade(value: float):
	# modifies shader `fade` parameter
	material.set_shader_parameter("fade", value)

func fade(delay: float, duration: float):
	var tween = create_tween()
	
	# wait
	tween.tween_interval(delay)
	
	# tween fade property from 0 to 1
	tween.tween_method(set_fade, 0.0, 1.0, duration)
