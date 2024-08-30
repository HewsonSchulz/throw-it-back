extends ColorRect

@export var fade_delay : float = 1.0
@export var fade_duration : float = 2.0

func _ready():
	# set initial fade to 0 (black)
	set_fade(0.0)

	fade(fade_delay, fade_duration)

func set_fade(value: float):
	# modifies shader `fade` parameter
	material.set_shader_parameter("fade", value)

func fade(delay: float, duration: float):
	var tween = create_tween()
	
	# wait
	tween.tween_interval(delay)
	
	# tween fade property from 0 to 1
	tween.tween_method(set_fade, 0.0, 1.0, duration)
