extends StaticBody2D

@export var points: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var index = randi_range(0, $SpriteMiddle.sprite_frames.get_frame_count("default") - 1)	
	$SpriteMiddle.set_frame_and_progress(index, 0.0)
	$SpriteMiddle.pause()
	$SpriteLeft.set_frame_and_progress(index, 0.0)
	$SpriteLeft.pause()
	$SpriteRight.set_frame_and_progress(index, 0.0)
	$SpriteRight.pause()
	points = index + 1
	$PointsLabel.text = str(points)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func size() -> Vector2:
	var collision_rect = $CollisionShape2D.shape.get_rect()
	return abs(collision_rect.size.rotated($CollisionShape2D.rotation))
