extends AnimatedSprite2D


@onready var bg = $"."
@export var fade_delay : float = 1.0
@export var fade_duration : float = 2.0
@onready var footsteps = $"../Footsteps"
var is_active: bool = false

func set_fade(value: float):
	# modifies shader `fade` parameter
	material.set_shader_parameter("fade", value)

func _ready():
	# set initial fade to 0 (black)
	set_fade(0.0)

	await fade(fade_delay, fade_duration)
	is_active = true

func fade(delay: float, duration: float):
	var tween = create_tween()
	
	# wait
	tween.tween_interval(delay)
	
	# tween fade property from 0 to 1
	tween.tween_method(set_fade, 0.0, 1.0, duration)
	
	return tween.finished  # allows `await` to wait for completion



func _input(e):
	if not is_active or bg.frame >= 2:
		return

	# if any key is pressed - including mouse-down, not including `esc`
	if (e is InputEventKey and e.pressed and e.keycode != KEY_ESCAPE) or \
	   (e is InputEventMouseButton and e.pressed):

		is_active = false
		var tween = create_tween()
		
		# fade out
		tween.tween_method(set_fade, 1.0, 0.0, 0.4)
		footsteps.play()
		
		await tween.finished
		
		# next frame
		bg.frame += 1
		
		# fade in
		tween = create_tween()
		tween.tween_method(set_fade, 0.0, 1.0, 0.4)
		await tween.finished
		
		# Re-enable input
		is_active = true
