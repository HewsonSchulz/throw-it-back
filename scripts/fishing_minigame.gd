extends Control

@export_range(1, 93) var difficulty: int = 90
@export var depth: int = 1
@export var base_color: Color = Color(1, 1, 1)
@export_range(0.2, 0.6, 0.1) var color_variance: float = 0.2

@onready var grid: GridContainer = $Grid
var tile_scene: PackedScene = preload("res://scenes/tile.tscn")

const GRID_SIZE_PX = Vector2(400, 400)

var unique_color: Color

func _ready():
	randomize()
	grid.custom_minimum_size = GRID_SIZE_PX
	grid.add_theme_constant_override("h_separation", 0)
	grid.add_theme_constant_override("v_separation", 0)

	# If user hasn't set base_color, assign a random one
	if base_color == Color(1, 1, 1):
		base_color = Color.from_hsv(randf(), randf_range(0.5, 1.0), randf_range(0.6, 1.0))

	# Always generate unique_color from base_color and difficulty
	unique_color = generate_unique_color_from_difficulty(base_color, difficulty)

	generate_grid()

func generate_grid():
	for child in grid.get_children():
		child.queue_free()

	var grid_size = depth + 1
	grid.columns = grid_size

	var total_tiles = grid_size * grid_size
	var special_tile_index = randi() % total_tiles

	for i in range(total_tiles):
		var tile = tile_scene.instantiate() as ColorRect

		if i == special_tile_index:
			tile.color = unique_color
		else:
			tile.color = apply_shade_variance(base_color, color_variance)

		tile.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		tile.size_flags_vertical = Control.SIZE_EXPAND_FILL
		grid.add_child(tile)

func apply_shade_variance(base: Color, variance: float) -> Color:
	var min_offset = -min(variance, base.v)
	var max_offset = min(variance, 1.0 - base.v)
	var v = base.v + randf_range(min_offset, max_offset)
	return Color.from_hsv(base.h, base.s, v, base.a)

func generate_unique_color_from_difficulty(base: Color, _difficulty: int) -> Color:
	# Convert difficulty (1–95) to hue difference (180° → 0°)
	var max_hue_diff = 0.5 # 180 degrees on hue circle
	var min_hue_diff = 0.0 # nearly same
	var hue_diff = lerp(max_hue_diff, min_hue_diff, float(_difficulty - 1) / 94.0)

	var new_hue = fmod(base.h + hue_diff, 1.0)
	return Color.from_hsv(new_hue, base.s, base.v, base.a)
