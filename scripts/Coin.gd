extends Node2D

@onready var game_manager = %GameManager
@onready var anim = $AnimationPlayer

func _on_area_2d_body_entered(_body):
	game_manager.add_coin()
	anim.play("collect_coin")


func _on_animation_player_animation_finished(_anim_name):
	queue_free()
