extends Area2D

@export var speed = 200
@export var color = Vector4(1.0, 1.0, 1.0, 1.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("fireball")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.x * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	queue_free()
	print("bullet: player hit!")
