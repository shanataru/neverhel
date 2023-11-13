extends Node2D

signal fired(bullet_scene, speed, damage)

@export var bullet_scene: PackedScene
@export var bullet_speed = 400
@export var bullet_damage = 20

@export var is_active = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	fired.emit(bullet_scene, bullet_speed, bullet_damage)
