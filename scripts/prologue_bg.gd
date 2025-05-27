extends AnimatedSprite2D


@onready var bg = $"."
@export var fade_delay : float = 1.0
@export var fade_duration : float = 2.0
@onready var footsteps = $"../Footsteps"
@onready var message_timer = $"../Message/MessageTimer"
var is_active: bool = false
signal hide_message

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
	if e.is_action_pressed('esc'):
		# quit game
		get_tree().quit()

	if not is_active or bg.frame >= 2:
		return

	# if left-click
	if e.is_action_pressed('left-click'):
		# reset message timer
		message_timer.wait_time = 12
		message_timer.start()
		# hide message
		hide_message.emit()
		
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
		
		if bg.frame >= 2:
			# begin main
			get_tree().change_scene_to_file("res://scenes/root.tscn")

		else:
			is_active = true
