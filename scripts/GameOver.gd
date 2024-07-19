extends Control

@onready var image: TextureRect = $TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	image.modulate = Color.TRANSPARENT
	create_tween().tween_property(image, 'modulate', Color.WHITE, 2)
	await get_tree().create_timer(4).timeout
	get_tree().change_scene_to_file("res://scenes/TitleScene.tscn")
