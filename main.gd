extends Node

var score: int = 0
var high_score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioBackground.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func restart_ball():
	$Ball.prepare()
	await get_tree().create_timer(2.0).timeout
	$Ball.start()

func restart_score():
	score = 0
	$HUD/CurrentScore.text = str(score)
	
	
func start_new_game():
	if not $AudioBackground.playing:
		$AudioGameStart.play()
	$HUD.hide_play_button()
	$HUD/HighScoreMessage.hide()
	$HUD/ScoreMessage.hide()
	$HUD/WinnerMessage.hide()
	restart_score()
	restart_ball()
	$Player.reset_position()
	$TileArray.reset_tiles()
	await get_tree().create_timer(1.0).timeout
	if not $AudioBackground.playing:
		$AudioBackground.play()

func stop_game(is_winner: bool) -> void:
	$Ball.stop()
	$AudioBackground.stop()
	
	$HUD/ScoreMessage.text = " ".join(["Your score:", str(score)])
	$HUD/ScoreMessage.show()
	
	var is_high_score = score > high_score
	if is_high_score or is_winner:
		$AudioSuccess.play()
	else:
		$AudioFailure.play()
	
	if is_high_score:
		high_score = score
		$HUD/HighScore.text = str(score)
		$HUD/HighScoreMessage.show()
	
	if is_winner:
		$HUD/WinnerMessage.show()
	
	await get_tree().create_timer(3.0).timeout
	$HUD.show_play_button()
	
	
func _on_walls_bottom_edge_crossed() -> void:
	stop_game(false)


func _on_hud_play_button_pressed() -> void:
	start_new_game()


func _on_hud_move_left_updated(pressed: bool) -> void:
	$Player.move_left_pressed = pressed


func _on_hud_move_right_updated(pressed: bool) -> void:
	$Player.move_right_pressed = pressed


func _on_tile_array_points_scored(points: int) -> void:
	score += points
	$HUD/CurrentScore.text = str(score)


func _on_tile_array_tiles_cleared() -> void:
	stop_game(true)
