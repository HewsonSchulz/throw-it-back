extends AnimatedSprite2D

signal next_frame

@onready var prologue_bg = $"."

@export var fade_delay : float = 1.0
@export var fade_duration : float = 2.0

func set_fade(value: float):
	# modifies shader `fade` parameter
	material.set_shader_parameter("fade", value)

func _ready():
	# set initial fade to 0 (black)
	set_fade(0.0)

	fade(fade_delay, fade_duration)

func fade(delay: float, duration: float):
	var tween = create_tween()
	
	# wait
	tween.tween_interval(delay)
	
	# tween fade property from 0 to 1
	tween.tween_method(set_fade, 0.0, 1.0, duration)

#######################

func _on_next_frame():
# go to next frame
	if frame < sprite_frames.get_frame_count(animation) - 1:
		frame += 1
	else:
		frame = 0


#func _input(e): #!
	#if e.is_action_pressed('bruh'):
		#prologue_bg.emit_signal("next_frame")
