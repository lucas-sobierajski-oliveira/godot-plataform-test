extends Node
class_name StateMachine

@export var player: Player
@onready var current_state = $Idle

var all_state_node: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	for node in get_children():
		var state_name = str(node.get_path()).split("/")[-1]
		var state_node = node
		all_state_node.append({ "state_name": state_name, "state_node": state_node })

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	current_state.update(_delta, player)
	player.move_and_slide()
	
func change_state(new_state: String):
	print('chamou o state: ' + new_state)
	for item_node in all_state_node:
		if (item_node.state_name == new_state):
			current_state.exit(player)
			current_state = item_node.state_node
			current_state.start(player)	
			break

