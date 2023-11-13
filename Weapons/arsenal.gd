extends Node2D

@export var player: Area2D

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_grimoire_fired(bullet_scene, bullet_speed, bullet_damage):
	if $Grimoire.is_active  == true:
		var grimoire_fireball = bullet_scene.instantiate()
		grimoire_fireball.speed = bullet_speed
		grimoire_fireball.position = player.get_node("CollisionShape2D").global_position
		add_child(grimoire_fireball)

func _on_player_special_used():
	$FireBombs.use_special()
