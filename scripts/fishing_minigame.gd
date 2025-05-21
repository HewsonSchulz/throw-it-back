extends Control

@export var difficulty: int = 1
@export var base_color: Color = Color(1, 1, 1)
@export var unique_color: Color = Color(1, 0, 0)
@export_range(0.2, 0.8, 0.1) var color_variance: float = 0.1

@onready var grid: GridContainer = $Grid
var tile_scene: PackedScene = preload("res://scenes/tile.tscn")

const GRID_SIZE_PX = Vector2(400, 400)

func _ready():
	randomize()
	grid.custom_minimum_size = GRID_SIZE_PX
	grid.add_theme_constant_override("h_separation", 0)
	grid.add_theme_constant_override("v_separation", 0)
	generate_grid()

func generate_grid():
	randomize()
	for child in grid.get_children():
		child.queue_free()

	var grid_size = difficulty + 1
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
