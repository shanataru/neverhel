extends Node

var player_scene = preload("res://Player/player.tscn")
var boss_scene = preload("res://Enemies/necromancer_boss/necromancer.tscn")

var player


func _ready():
	new_game(player_scene)
	#spawn_boss(boss_scene)

func new_game(player_character):
	player = player_character.instantiate()
	add_child(player);
	player.name = "player_character"
	player.init($PlayerStart.position, 1000) #player spawns own arsenal

	
func spawn_boss(boss_character):
	var necromancer = boss_character.instantiate();
	add_child(necromancer);
	necromancer.name = "boss_character"
	necromancer.init($BossMainPosition.position, player)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
