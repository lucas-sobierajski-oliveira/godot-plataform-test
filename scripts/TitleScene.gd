extends Control

@onready var start_ui: MarginContainer = $MarginContainer
@onready var image: TextureRect = $MarginContainer/VBoxContainer/TextureRect
@onready var fade = $ColorRect

# Called when the node enters the scene tree for the first time.
func _ready():
	start_ui.position.y = -500
	var tween = create_tween()
	tween.tween_property(start_ui, 'position', Vector2(start_ui.position.x, 0), 1).set_trans(Tween.TRANS_SPRING)

func _on_button_pressed():
	fade.set_as_top_level(true)

	await create_tween().tween_property(fade, 'modulate', Color.WHITE, 2).finished
	get_tree().change_scene_to_file('res://scenes/Main.tscn')
