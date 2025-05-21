extends AudioStreamPlayer2D

@export var FADE_DURATION := 3.0     # fade-in time

func _ready():
	volume_db = -80
	fade_in_music()

func fade_in_music():
	var tween := create_tween()
	tween.tween_property(
		self, "volume_db",
		0, FADE_DURATION
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
