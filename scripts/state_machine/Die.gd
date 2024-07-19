extends Node
class_name Die

@onready var state_machine = get_parent() as StateMachine
@onready var hurt_sound = $AudioStreamPlayer2D

func start(player: Player):
	print('start animation die')
	player.sprite.play('die', 1, true)
	player.hit_box.set_deferred('monitoring', false)
	player.hit_box.set_deferred('monitorable', false)
	player.hurt_box.set_deferred('monitoring', false)
	player.hurt_box.set_deferred('monitorable', false)
	
	hurt_sound.play()
	
	var tween = create_tween()
	
	player.velocity.x = 0
	player.velocity.y = -100
	
	tween.tween_property(player.sprite, 'modulate', Color.BLACK, 1)

func update(delta, player: Player):
	print('die')
	
	if not player.is_on_floor():
		player.velocity.y += player.gravity * delta
	

func exit(_player: Player):
	print('exit die')
