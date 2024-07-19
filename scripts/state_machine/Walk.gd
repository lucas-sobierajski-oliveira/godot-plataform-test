extends Node
class_name Walk

@onready var state_machine = get_parent() as StateMachine

func start(player: Player):
	print('start animation Walk')
	player.sprite.play('walk')

func update(_delta, player: Player):
	print('Walk')
	
	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		state_machine.change_state('Jump')
		return
	
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction and player.is_on_floor():		
		if direction > 0:
			player.sprite.flip_h = false
		elif direction < 0:
			player.sprite.flip_h = true
	else:
		state_machine.change_state('Idle')
		return

	player.velocity.x = direction * player.SPEED

func exit(_player: Player):
	pass
	# check pressed jump
		#change to jump State
