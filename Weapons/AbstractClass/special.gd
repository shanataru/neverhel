extends Node2D

@export var skill_meter = 0.0
@export var usage_cost = 100.0
@export var max_meter = 100.0
@export var damage = 100
@export var is_active = true

@export var particle_scene: PackedScene

var particle_amount = 5
var particle_center_offset = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func fill_meter(amount):
	skill_meter += amount
	clampf(skill_meter, 0.0, max_meter)
	
func use_special():
	if skill_meter >= usage_cost:
		skill_meter -= usage_cost
		print(skill_meter)
		var center_pos = get_parent().arsenal_owner.get_node("CollisionShape2D").global_position
		for i in range(particle_amount):
			var b = particle_scene.instantiate()
			var angle = -60 + (30 * i) 
			b.position = center_pos + Vector2.UP.rotated(deg_to_rad(angle)) * particle_center_offset
			b.angular_speed = 1.0
			b.scale_rate = 0.08
			b.spawn_center = center_pos
			get_parent().add_child(b)
			b.name = "special_firebomb"
