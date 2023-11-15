extends Node2D

var arsenal_owner

func _ready():
	pass
	
func init(in_player):
	arsenal_owner = in_player
	arsenal_owner.connect("special_used", _on_player_special_used)

func _process(delta):
	#print(arsenal_owner)
	pass

func _on_grimoire_fired(bullet_scene, bullet_speed, bullet_damage):
	if $Grimoire.is_active  == true:
		var grimoire_fireball = bullet_scene.instantiate()
		add_child(grimoire_fireball)
		grimoire_fireball.name = "grimoire_fireball"
		grimoire_fireball.speed = bullet_speed
		grimoire_fireball.position = arsenal_owner.get_node("CollisionShape2D").global_position
		
func _on_player_special_used():
	if $FireBombs.is_active:
		$FireBombs.use_special()
