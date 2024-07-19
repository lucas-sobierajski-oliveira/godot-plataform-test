extends Node
class_name Jump

@onready var state_machine = get_parent() as StateMachine
@onready var jump_sound = $AudioStreamPlayer2D

func start(player: Player):
	print('start animation Jump')
	
	jump_sound.play()
	
	player.velocity.y = player.JUMP_VELOCITY
	player.sprite.play('jump')

func update(_delta, player: Player):
	print('Jump')
	
	if not player.is_on_floor():
		state_machine.change_state('Air')
		return
			
func exit(_player: Player):
	pass
