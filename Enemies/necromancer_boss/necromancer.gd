extends Area2D

var updated_player_position_x
var velocity
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	chase_player(delta, 5)
	
func init(start_position, player_char):
	position = start_position
	player = player_char
	updated_player_position_x = player.position.x
	
func chase_player(delta, speed):
	velocity = updated_player_position_x - position.x
	position += Vector2(velocity * speed * delta, 0)
	
func _on_locating_player_timer_timeout():
	updated_player_position_x = player.position.x

func bullet_hell_type_a():
	pass
