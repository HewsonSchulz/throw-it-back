# ROOT
extends Node

func _input(e):
	if e.is_action_pressed('esc'):
		# quit game
		get_tree().quit()
