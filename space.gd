extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Background.scroll_offset += Vector2.LEFT * $Background.scroll_scale.x
	$Stars.scroll_offset += Vector2.LEFT * $Stars.scroll_scale.x
	$FarPlanets.scroll_offset += Vector2.LEFT * $FarPlanets.scroll_scale.x
	$RingPlanet.scroll_offset += Vector2.LEFT * $RingPlanet.scroll_scale.x
	$BigPlanet.scroll_offset += Vector2.LEFT * $BigPlanet.scroll_scale.x
