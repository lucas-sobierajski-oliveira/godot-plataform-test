extends CharacterBody2D
class_name Player

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var state_machine: StateMachine = $StateMachine
@onready var game_manager: GameManager = %GameManager
@onready var hit_box: Area2D = $HitBox
@onready var hurt_box: Area2D = $HurtBox
@onready var raycast_air_left: RayCast2D = $RayCastLeft
@onready var raycast_air_right: RayCast2D = $RayCastRigth
@onready var invunerability_timer: Timer = $InvunerabilityTimer

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var wall_gravity = 250

const SPEED = 100.0
const JUMP_VELOCITY = -300.0
const HIT_JUMP_VELOCITY = -200.0

var invunerabilty = false
var tween: Tween
var is_die = false

func _ready():
	hit_box.set_deferred('monitoring', false)
	hit_box.set_deferred('monitorable', false)

func _process(_delta):
	if invunerabilty or is_die:
		hurt_box.set_deferred('monitoring', false)
		hurt_box.set_deferred('monitorable', false)
	else:
		hurt_box.set_deferred('monitoring', true)

func _on_hurt_box_area_entered(_area):
	print('entrou no on_hurt')
	game_manager.take_damage()
	
	is_die = game_manager.health < 0
	
	if not is_die:
		tween = create_tween().set_loops()
		tween.tween_property(sprite, 'modulate', Color.WHITE, 0.1)
		tween.tween_property(sprite, 'modulate', Color.TRANSPARENT, 0.1)
		state_machine.change_state('Hurt')
	else:
		state_machine.change_state('Die')
	
func _on_invunerability_timer_timeout():
	tween.kill()
	tween = create_tween()
	tween.tween_property(sprite, 'modulate', Color.WHITE, 0.1)
	invunerabilty = false
