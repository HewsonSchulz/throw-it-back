# ROOT
extends Node

enum GameState {
	IDLE,
	MINIGAME_RUNNING
}

var current_state: GameState = GameState.IDLE

@onready var bg2 = $BG2

@export_range(0, 2.0, 0.1) var fishing_fade: float = 0.5

func _ready():
	# ensure bg2 uses a unique material so its alpha fades independently
	bg2.material = bg2.material.duplicate(true)
	bg2.material.set_shader_parameter("alpha_fade", 0.0)

func _input(e):
	if e.is_action_pressed('esc'):
		# quit game
		get_tree().quit()

	if e.is_action_pressed('left-click') and current_state == GameState.IDLE:
		# go fish!
		bg2.material.set_shader_parameter("alpha_fade", 0.0)
		create_tween().tween_property(bg2.material, "shader_parameter/alpha_fade", 1.0, fishing_fade)

		var game = preload("res://scenes/fishing_minigame.tscn").instantiate()
		game.depth = 10
		game.difficulty = 1
		game.position = Vector2(-400, -250)

		current_state = GameState.MINIGAME_RUNNING
		game.connect("finished", Callable(self, "_on_minigame_finished"))
		get_tree().get_root().add_child(game)

func _on_minigame_finished():
	create_tween().tween_property(bg2.material, "shader_parameter/alpha_fade", 0.0, fishing_fade)
	current_state = GameState.IDLE
