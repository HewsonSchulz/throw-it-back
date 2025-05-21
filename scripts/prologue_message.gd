extends Label

var tween: Tween
var start_position: Vector2
@export var hover_distance: float = 20.0
@export var hover_duration: float = 2.0
@export var wait_time: float = 0.0
@export var init_wait_time: float = 12.0
@export var fade_in_duration: float = 1.0

func _ready():
	start_position = position
	modulate.a = 0.0  # start invisible

	var fade_tween = create_tween()
	fade_tween.tween_interval(init_wait_time)
	fade_tween.tween_property(self, "modulate:a", 1.0, fade_in_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	tween = create_tween().set_loops()
	
	# hover down
	tween.tween_property(self, "position:y", start_position.y + hover_distance, hover_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	# wait
	tween.tween_interval(wait_time)
	
	# hover up (back to start)
	tween.tween_property(self, "position:y", start_position.y, hover_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	# wait
	tween.tween_interval(wait_time)
