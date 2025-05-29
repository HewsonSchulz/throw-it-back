# ROOT
extends Node

enum GameState {
	IDLE,
	MINIGAME_RUNNING
}

var current_state: GameState = GameState.IDLE
var reel_tween: Tween
@onready var bg2 = $BG2
@onready var splash = $Splash
@onready var reel = $Reel

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

		if reel_tween and reel_tween.is_valid():
			reel_tween.kill()

		reel_tween = create_tween()
		reel_tween.tween_property(reel, "volume_db", -30, fishing_fade * 4)

		bg2.material.set_shader_parameter("alpha_fade", 0.0)
		create_tween().tween_property(bg2.material, "shader_parameter/alpha_fade", 1.0, fishing_fade)
		
		go_fish(1, 10) #!

func go_fish(difficulty:int,depth:int,base_color:Color=Color(1, 1, 1),color_variance:float=0.2):
	var game = preload("res://scenes/fishing_minigame.tscn").instantiate()
	
	game.difficulty = difficulty
	game.depth = depth
	game.base_color = base_color
	game.color_variance = color_variance
	
	game.position = Vector2(-400, -250)
	
	current_state = GameState.MINIGAME_RUNNING
	game.connect("finished", Callable(self, "_on_minigame_finished"))
	get_tree().get_root().add_child(game)

func _on_minigame_finished():
	create_tween().tween_property(bg2.material, "shader_parameter/alpha_fade", 0.0, fishing_fade)

	if reel_tween and reel_tween.is_valid():
		reel_tween.kill()

	reel_tween = create_tween()
	reel_tween.tween_property(reel, "volume_db", -80, fishing_fade)

	current_state = GameState.IDLE
