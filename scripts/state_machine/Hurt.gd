extends Node
class_name Hurt

@onready var state_machine = get_parent() as StateMachine
@onready var hurt_sound = $AudioStreamPlayer2D
@onready var hurt_timer := $HurtTimer

func start(player: Player):
	print('start animation Hurt')

	player.invunerability_timer.start()
	player.invunerabilty = true
		
	player.hurt_box.set_deferred('monitoring', false)

	player.sprite.play('hurt')
	hurt_sound.play()
	
	player.velocity.x = 0
	player.velocity.y = -100
	
	hurt_timer.start()

func update(delta, player: Player):
	print('hurt')
	if not player.is_on_floor():
		player.velocity.y += player.gravity * delta
	
func exit(_player: Player):
	pass

func _on_hurt_timer_timeout():
	state_machine.change_state('Idle')
