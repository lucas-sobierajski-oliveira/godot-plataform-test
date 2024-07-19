extends Node2D

@onready var fade = $ColorRectFade
@onready var player: Player = %Player
@onready var options_packed: PackedScene = load("res://scenes/options_canvas_layer.tscn")

var tweem: Tween

func _process(delta):
	if Input.is_key_pressed(KEY_Q):
		var options = options_packed.instantiate()
		options.visible = true
		add_child(options)
		get_tree().paused = true

func _ready():
	fade.visible = true
	fade.z_index = 10
	await create_tween().tween_property(fade, 'modulate', Color.TRANSPARENT, 2).finished
	fade.z_index = 0

func _on_end_game_area_body_entered(_body):
	fade.visible = true
	fade.z_index = 10
	fade.color = Color.WHITE
	await create_tween().tween_property(fade, 'modulate', Color.WHITE, 3).finished
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://scenes/TitleScene.tscn")
	
