extends Control

signal play_button_pressed
signal move_left_updated(pressed:bool)
signal move_right_updated(pressed:bool)

var texture_move_left_depressed: Texture2D
var texture_move_left_pressed: Texture2D
var texture_move_right_depressed: Texture2D
var texture_move_right_pressed: Texture2D

func _ready() -> void:
	texture_move_left_depressed = $MoveLeft.texture_normal
	texture_move_left_pressed = $MoveLeft.texture_pressed
	texture_move_right_depressed = $MoveRight.texture_normal
	texture_move_right_pressed = $MoveRight.texture_pressed

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("left"):
		$MoveLeft.texture_normal = texture_move_left_pressed
	elif Input.is_action_just_released("left"):
		$MoveLeft.texture_normal = texture_move_left_depressed
	
	if Input.is_action_just_pressed("right"):
		$MoveRight.texture_normal = texture_move_right_pressed
	elif Input.is_action_just_released("right"):
		$MoveRight.texture_normal = texture_move_right_depressed
		
	if Input.is_action_just_pressed("enter") and $ButtonPlay.is_visible_in_tree():
		play_button_pressed.emit()
	

func hide_play_button():
	$ButtonPlay.hide()
	$ButtonPlayLabel.hide()
	

func show_play_button():
	$ButtonPlay.show()
	$ButtonPlayLabel.show()


func _on_button_play_pressed() -> void:
	play_button_pressed.emit()


func _on_move_left_button_down() -> void:
	move_left_updated.emit(true)


func _on_move_left_button_up() -> void:
	move_left_updated.emit(false)


func _on_move_right_button_down() -> void:
	move_right_updated.emit(true)


func _on_move_right_button_up() -> void:
	move_right_updated.emit(false)
