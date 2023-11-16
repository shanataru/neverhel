extends Area2D

enum State {IDLE, MOVING, SHOOTING}

signal use_skill(skill:Callable)

var updated_player_position_x
var velocity
var player

var current_state = State.IDLE
var rng

var selected_skill

const bullet_scene = preload("res://Weapons/Bullets/basic_bullet.tscn")

const rotate_speed = 100
const shooter_timer_wait_time = 0.15
const bh_rotated_spawn_point_count = 10
const radius = 100
var is_chasing_player = false



@onready var bullet_rotator = $BulletRotator
@onready var bullet_shoot_timer = $BulletShootTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	$AnimatedSprite2D.play("idle")
	prepare_skills()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(is_chasing_player):
		if(lock_on_player(updated_player_position_x, 1, delta)): #move to player, nutil locked in to last known position
			is_chasing_player = false
			use_skill.emit(selected_skill)
			current_state = State.SHOOTING

	#rotate bullet rotator
	var new_rotation = bullet_rotator.rotation_degrees + rotate_speed * delta
	bullet_rotator.rotation_degrees = fmod(new_rotation, 360)
	
func init(start_position, player_char):
	position = start_position
	player = player_char
	updated_player_position_x = player.position.x
	
func lock_on_player(destination, speed, delta):
	velocity = destination - position.x
	position += Vector2(velocity * speed * delta, 0)
	if (abs(position.x - destination) < 50): #is withing 50 unit from player, locked on
		return true
	return false
	
func _on_locating_player_timer_timeout():
	updated_player_position_x = player.position.x
	
func prepare_skills():
	#skill_bh_rotated
	var step = 2 * PI / bh_rotated_spawn_point_count
	
	for i in range(bh_rotated_spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		bullet_rotator.add_child(spawn_point)
	
	bullet_shoot_timer.wait_time = shooter_timer_wait_time

func skill_bh_rotated(shoot_duration):
	bullet_shoot_timer.start()
	$SkillDuration_bh_rotated.wait_time = shoot_duration
	$SkillDuration_bh_rotated.start()
	
func _on_bullet_shoot_timer_timeout():
	for s in bullet_rotator.get_children():
		var bullet = bullet_scene.instantiate()
		get_tree().root.add_child(bullet)
		bullet.name = "bullet"
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation

func _on_skill_duration_bh_rotated_timeout():
	bullet_shoot_timer.stop()
	$SkillDuration_bh_rotated.stop()
	current_state = State.IDLE

func _on_action_timer_timeout():
	if(current_state == State.IDLE):
		var roll = rng.randi_range(1,6)
		if roll > 4:
			is_chasing_player = true
			selected_skill = Callable(self, "skill_bh_rotated").bind(3.0)

func _on_use_skill(skill):
	skill.call()

