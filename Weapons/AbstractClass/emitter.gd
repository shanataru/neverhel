extends Area2D

signal main_animation_finished

@export var angular_speed = 1.0
@export var speed = 300.0
@export var scale_rate = 0.05
@export var spawn_center = Vector2.ZERO

var velocity = Vector2.UP
var scale_x = 1.0
var scale_y = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$MainAnimatedSprite2D.connect("animation_finished", self.on_main_animation_finished)
	$MainAnimatedSprite2D.play()
	$SecondaryAnimatedSprite2D.play()
	velocity = (position - spawn_center).normalized() * speed

func _process(delta):
	rotation += angular_speed * delta
	scale_x += scale_rate
	scale_y += scale_rate
	scale = Vector2(scale_x, scale_y)
	position += velocity * delta

func on_main_animation_finished():
	queue_free()
