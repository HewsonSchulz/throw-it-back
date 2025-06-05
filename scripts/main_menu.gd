extends Control


func _on_start():
	get_tree().change_scene_to_file("res://scenes/prologue.tscn")

func _on_settings():
	pass #!

func _on_quit():
	get_tree().quit()
