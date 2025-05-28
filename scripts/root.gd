# ROOT
extends Node

enum GameState {
	IDLE,
	MINIGAME_RUNNING
}
var current_state: GameState = GameState.IDLE


func _input(e):
	if e.is_action_pressed('esc'):
		# quit game
		get_tree().quit()

	if e.is_action_pressed('left-click') and current_state == GameState.IDLE:
		var game = preload("res://scenes/fishing_minigame.tscn").instantiate()
		game.depth = 10
		game.position = Vector2(-400, -250)

		current_state = GameState.MINIGAME_RUNNING

		game.connect("finished", Callable(self, "_on_minigame_finished"))

		get_tree().get_root().add_child(game)

func _on_minigame_finished():
	current_state = GameState.IDLE
