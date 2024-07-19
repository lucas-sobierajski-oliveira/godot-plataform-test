extends Node
class_name JumpWall

@onready var state_machine = get_parent() as StateMachine
@onready var wall_jump_timer = $WallJumpTimer
@onready var jump_sound = $AudioStreamPlayer2D

var last_left_side_collide = false
var can_move = true

func start(player: Player):
	print('start animation JumpWall')
	
	jump_sound.play()
	
	if not player.hit_box.area_entered.is_connected(hit_enemy):
		player.hit_box.area_entered.connect(hit_enemy)
	
	if player.raycast_air_left.is_colliding():
		player.set_velocity(Vector2(100, -300))
		last_left_side_collide = true
	else:
		player.set_velocity(Vector2(-100, -300))
		last_left_side_collide = false
	
	wall_jump_timer.start()
	can_move = false
	player.sprite.play('jump')

func update(delta, player: Player):
	print('JumpWall')
	
	var copySpriteframe: AnimatedSprite2D = player.sprite.duplicate()
	get_window().add_child(copySpriteframe)
	copySpriteframe.global_position = player.global_position
	var tween = create_tween()
	tween.tween_property(copySpriteframe, 'modulate', Color.TRANSPARENT, 0.1)
	tween.tween_callback(copySpriteframe.queue_free)
	
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
		
	if player.raycast_air_left.is_colliding() and not last_left_side_collide and direction < 0:
		last_left_side_collide = true
		state_machine.change_state('SlideWall')
		return
	if player.raycast_air_right.is_colliding() and last_left_side_collide and direction > 0:
		last_left_side_collide = false
		state_machine.change_state('SlideWall')
		return
		
	if can_move:
		player.velocity.x = direction * player.SPEED

func exit(player: Player):
	print('exit JumpWall')
	
	player.hit_box.set_deferred('monitoring', false)
	player.hit_box.set_deferred('monitorable', false)
	
func hit_enemy(_area):
	state_machine.change_state('Hit')

func _on_wall_jump_timer_timeout():
	can_move = true
