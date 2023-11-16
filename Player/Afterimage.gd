extends Sprite2D

func _ready():	
	var alpha_tween = get_tree().create_tween()
	alpha_tween.set_trans(Tween.TRANS_SINE)
	alpha_tween.set_ease(Tween.EASE_OUT)
	alpha_tween.tween_property(self, "modulate", Color(1,1,1,0), 0.4)
	alpha_tween.connect("finished", on_alpha_tween_finished)

func on_alpha_tween_finished():                    
	queue_free()
