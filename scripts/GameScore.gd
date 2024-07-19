extends Node
class_name GameManager

@onready var score_label = %CoinsCounter
@onready var health_label = %HealthCounter
@onready var player: Player = %Player
@onready var fade = $"../ColorRectFade"

@export var score = 0
@export var health = 2

func _ready():
	health_label.text = str(health)

func add_coin():
	score += 1
	score_label.text = str(score)

func take_damage():
	health -= 1
	if health < 0:
		health_label.text = '0'
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file("res://scenes/GameOver.tscn")
	else:
		health_label.text = str(health)
		

