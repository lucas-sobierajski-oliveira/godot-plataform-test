extends Node
class_name Air

@onready var state_machine = get_parent() as StateMachine

func start(player: Player):
	print('start animation Air')
	player.sprite.play('jump')
	if not player.hit_box.area_entered.is_connected(hit_enemy):
		player.hit_box.area_entered.connect(hit_enemy)

func update(delta, player: Player):
	print('Air')
	
	if player.velocity.y <= 0:
		player.hit_box.set_deferred('monitoring', false)
		player.hit_box.set_deferred('monitorable', false)
	else:
		player.hit_box.set_deferred('monitoring', true)
		player.hit_box.set_deferred('monitorable', true)
	
	if not player.is_on_floor():
		player.velocity.y += player.gravity * delta
	else:
		state_machine.change_state('Idle')
		return
	
	var direction = Input.get_axis("ui_left", "ui_right")

	if direction:		
		if direction > 0:
			player.sprite.flip_h = false
		elif direction < 0:
			player.sprite.flip_h = true

	if direction < 0 and player.raycast_air_left.is_colliding():
		state_machine.change_state('SlideWall')
		return
	if direction > 0 and player.raycast_air_right.is_colliding():
		state_machine.change_state('SlideWall')
		return
		
	player.velocity.x = direction * player.SPEED

func hit_enemy(_area):
	state_machine.change_state('Hit')

func exit(player: Player):
	player.hit_box.set_deferred('monitoring', false)
	player.hit_box.set_deferred('monitorable', false)
