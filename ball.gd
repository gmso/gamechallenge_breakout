extends CharacterBody2D

signal collided_with_object(collider_id: int)

var direction: Vector2 = Vector2.ZERO
var ball_speed = 400 # in pixels/sec

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	prepare()


func _physics_process(_delta: float) -> void:
	velocity = direction * ball_speed
	var collision = move_and_slide()
	if collision:
		direction = direction.bounce(get_last_slide_collision().get_normal())
		$AudioBallHit.play()
		collided_with_object.emit(get_last_slide_collision().get_collider_id())


func stop():
	direction = Vector2.ZERO


func prepare():
	hide()
	var center = get_viewport_rect().get_center()
	position = Vector2(center.x, center.y + 400)
	velocity = Vector2.ZERO
	direction = Vector2.ZERO
	ball_speed = 400


func start():
	show()
	randomize_direction()


func randomize_direction():
	var x = randi_range(0,1)
	if x == 0:
		x = -1
	direction = Vector2(x,-1)


func _on_timer_accelerate_ball_timeout() -> void:
	ball_speed += 10
