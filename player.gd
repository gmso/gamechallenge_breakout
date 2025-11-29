extends CharacterBody2D

var speed = 400 # pixels/sec
var move_left_pressed: bool = false
var move_right_pressed: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var center = get_viewport_rect().get_center()
	$CollisionBar.position = Vector2(center.x, 1100)
	$Sprite.position = Vector2(center.x, 1100)
	#$Sprite.position.x = dist_to_vp - ($Sprite.size.x / 2)

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	var direction = Vector2.ZERO
	if Input.is_action_pressed("left") or move_left_pressed:
		direction = Vector2.LEFT
	elif Input.is_action_pressed("right") or move_right_pressed:
		direction = Vector2.RIGHT
		
	velocity = direction * speed
	move_and_slide()
	if position.y > 0:
		print(position.y)
	#if position.y > 0:
	#	position.y = 0


func reset_position():
	position = Vector2.ZERO
