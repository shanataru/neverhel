extends Area2D

signal player_hit
signal special_used

enum State {IDLE, MOVING}
var current_state = State.IDLE

var player_arsenal_scene = preload("res://Weapons/arsenal.tscn")

@export var movement_speed = 300
var screen_size
var arsenal

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_player(delta)
	
func _input(event):
	if event.is_action_pressed("special"):
		special_used.emit()
		print("Q")

func move_player(delta):
	var velocity = Vector2.ZERO
	current_state = State.IDLE
	if Input.is_action_pressed("right"):
		velocity.x += 1
		current_state = State.MOVING
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		current_state = State.MOVING
	if Input.is_action_pressed("down"):
		velocity.y += 1
		current_state = State.MOVING
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		current_state = State.MOVING
		
	if velocity.x != 0:
		if velocity.x < 0:
			scale.x = -1 * abs(scale.x)
		else:
			scale.x = abs(scale.x)
			
	velocity = velocity.normalized() * movement_speed
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func _draw():
	var from = $CollisionShape2D.position
	draw_line(from, from + Vector2.UP * 100, Color(0.0, 1.0, 0.0, 1.0), 2)
	draw_line(from, from + Vector2.UP * 2, Color(1.0, 0.0, 0.0, 1.0), 10)
	
func init(start_position, special_skill_meter):
	position = start_position
	
	#spawn arsenal to fire bullets
	arsenal = player_arsenal_scene.instantiate()
	get_parent().add_child(arsenal)
	arsenal.init(self)
	arsenal.get_node("FireBombs").skill_meter = special_skill_meter
	
func start_invincible_frames(duration):
	$AnimatedSprite2D.material.set_shader_parameter("flash_intensity", 1.0)
	$CollisionShape2D.disabled = true
	$InvincibilityTimer.start()
	
func _on_afterimage_timer_timeout():
	#$AnimatedSprite2D.material.set_shader_parameter("flash_intensity", 0.0)
	if (current_state == State.MOVING):
		var afterimage = preload("res://Player/afterimage.tscn").instantiate()
		get_parent().add_child(afterimage)
		afterimage.name = "afterimage"
		afterimage.position = position
		afterimage.texture = $AnimatedSprite2D.sprite_frames.get_frame_texture($AnimatedSprite2D.animation, $AnimatedSprite2D.frame)
		afterimage.scale = $".".get_node("AnimatedSprite2D").scale


func _on_invincibility_timer_timeout():
	$AnimatedSprite2D.material.set_shader_parameter("flash_intensity", 0.0)
	$CollisionShape2D.disabled = false
