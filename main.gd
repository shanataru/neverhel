extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()

func new_game():
	$Player.position = $PlayerStart.position
	$Arsenal.get_node("FireBombs").fill_meter(1000)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
