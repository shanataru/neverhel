extends Area2D

@export var speed = -1

var velocity = Vector2.ZERO

func _ready():
	$AnimatedSprite2D.play()

func _process(delta):
	pass

func _physics_process(delta):
	velocity = Vector2.UP * speed
	translate(velocity * delta)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	queue_free()
