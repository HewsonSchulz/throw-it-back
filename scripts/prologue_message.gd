extends Label

@export var hover_distance: float = 20.0
@export var hover_duration: float = 2.0
@export var wait_time: float = 0.0
@export var fade_in_duration: float = 1.0
@onready var timer = $MessageTimer


func _ready():
	var start_position: Vector2 = position
	modulate.a = 0.0  # start hidden
	
	var hover_tween: Tween = create_tween().set_loops()
	
	# hover down
	hover_tween.tween_property(self, "position:y", start_position.y + hover_distance, hover_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	# wait
	hover_tween.tween_interval(wait_time)
	
	# hover up (back to start)
	hover_tween.tween_property(self, "position:y", start_position.y, hover_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	# wait
	hover_tween.tween_interval(wait_time)


func _on_timer_timeout():
	# fade in
	create_tween().tween_property(self, "modulate:a", 1.0, fade_in_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)


func _on_bg_hide_message():
	modulate.a = 0.0  # hide


func _on_bg_kill_message():
	# disable node
	visible = false
	queue_free()
