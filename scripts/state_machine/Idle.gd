extends Node
class_name Idle

@onready var state_machine = get_parent() as StateMachine

func start(player: Player):
	print('start animation Idle')
	player.sprite.play('idle')

func update(_delta, player: Player):
	print('idle')
	
	if not player.is_on_floor():
		state_machine.change_state('Air')
		return
		
	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		state_machine.change_state('Jump')
		return

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction and player.is_on_floor():
		state_machine.change_state('Walk')
		return
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)

func exit(_player: Player):
	print('exit idle')
