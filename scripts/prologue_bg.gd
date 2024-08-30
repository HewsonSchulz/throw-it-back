extends AnimatedSprite2D

func _ready():
	# set initial modulate to black
	modulate = Color(0, 0, 0, 1)
	
	fade(5, 1)

func fade(delay: float, duration: float):
	var tween = create_tween()
	
	# wait
	tween.tween_interval(delay)
	
	# tween modulate property from black to white
	tween.tween_property(self, "modulate", Color(1, 1, 1, 1), duration)
