extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var hit_hurt_area = $HitHurtArea
@onready var right_detecter = $RightDetecter
@onready var left_detecter = $LeftDetecter
@onready var right_ground_detecter = $RigthtGroundDetecter
@onready var left_ground_detecter = $LeftGroundDetecter
@onready var collision_shape = $CollisionShape2D

const vel = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	sprite.play('default')

func _process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if right_detecter.is_colliding() or not right_ground_detecter.is_colliding():
		sprite.flip_h = true
		velocity.x = -10
	elif left_detecter.is_colliding() or not left_ground_detecter.is_colliding():
		sprite.flip_h = false
		velocity.x = 10
	
	move_and_slide()

func _on_hit_hurt_area_area_entered(_area):
	hit_hurt_area.queue_free()
	collision_shape.queue_free()
	set_process(false)
	sprite.play('hurt')
