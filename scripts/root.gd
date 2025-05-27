# ROOT
extends Node

func _input(e):
	if e.is_action_pressed('esc'):
		# quit game
		get_tree().quit()

	if e.is_action_pressed('left-click'):
		var game = preload("res://scenes/fishing_minigame.tscn").instantiate()
		game.depth = 10
		game.position = Vector2(-400, -250)
		get_tree().get_root().add_child(game)
