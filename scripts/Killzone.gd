extends Area2D

@onready var check_point: Node2D = %CheckPoint
@onready var player = %Player
@onready var game_manager: GameManager = %GameManager

func _on_body_entered(body: CharacterBody2D):
	if body.name == 'Player':
		game_manager.take_damage()
		player.state_machine.set_process(false)
		
		if game_manager.health >= 0:
			await get_tree().create_timer(2).timeout
			player.state_machine.set_process(true)
			player.global_position = check_point.global_position
			
