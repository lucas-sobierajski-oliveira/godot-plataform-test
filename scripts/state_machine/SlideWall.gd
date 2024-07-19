extends Node
class_name SlideWall

@onready var state_machine = get_parent() as StateMachine

func start(player: Player):
	print('start animation SlideWall')
	player.velocity.y = 0
	player.sprite.play('slide_wall')

func update(delta, player: Player):
	print('SlideWall')
	
	var direction = Input.get_axis("ui_left", "ui_right")

	if Input.is_action_just_pressed("ui_accept") and not player.is_on_floor():
		state_machine.change_state('JumpWall')
		return

	if direction:		
		if player.raycast_air_right.is_colliding():
			player.sprite.flip_h = false
		elif player.raycast_air_left.is_colliding():
			player.sprite.flip_h = true
	
	if not player.is_on_floor() and direction == 0:
		state_machine.change_state('Air')
	elif not player.is_on_floor() and direction != 0 and (player.raycast_air_left.is_colliding() or player.raycast_air_right.is_colliding()):
		player.velocity.y += player.wall_gravity * delta
	else:
		state_machine.change_state('Idle')
		return
		
	player.velocity.x = direction * player.SPEED

func exit(_player: Player):
	print('exit slideWall')
