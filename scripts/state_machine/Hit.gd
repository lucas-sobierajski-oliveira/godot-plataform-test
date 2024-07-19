extends Node
class_name Hit

@onready var state_machine = get_parent() as StateMachine
@onready var jump_sound = $AudioStreamPlayer2D

func start(player: Player):
	print('start animation Hit')
	player.velocity.y = player.HIT_JUMP_VELOCITY
	player.sprite.play('jump')
	jump_sound.play()

func update(_delta, player: Player):
	print('Hit')

	if not player.is_on_floor():
		state_machine.change_state('Air')
		return

func exit(_player: Player):
	pass
