tool
extends StaticBody2D

var textures = [
	"res://sprites/Environment/ground_cake.png",
	"res://sprites/Environment/ground_grass.png",
	"res://sprites/Environment/ground_sand.png",
	"res://sprites/Environment/ground_snow.png",
	"res://sprites/Environment/ground_stone.png",
	"res://sprites/Environment/ground_wood.png"
]

export(int, "CAKE", "GRASS", "SAND", "SNOW", "STONE", "WOOD") var texture = 0 setget set_texture

func _ready():
	pass

func _draw():
	$sprite.texture = load(textures[texture])

func set_texture(val):
	texture = val
	if is_inside_tree() && Engine.editor_hint:
		update()