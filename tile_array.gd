extends Node2D

@export var tile_scene: PackedScene

signal points_scored(points: int)
signal tiles_cleared()

var tile_ids: Dictionary

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	create_tiles()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
	#print(get_child_count())


func create_tiles() -> void:
	var cells_start_min = Vector2(32, 128)
	
	var tile = tile_scene.instantiate()
	var tile_size = tile.size()
	var cell_size = Vector2(tile_size.x * 1.5, tile_size.y * 1.5)
	tile.queue_free()
	
	var center = get_viewport_rect().get_center()
	var rows = floor((center.y - cells_start_min.y) / cell_size.y)
	var cols = floor((get_viewport_rect().end.x - cells_start_min.x) / cell_size.x)
	var offset_x = center.x - (cols * cell_size.x / 2)
	for col in range(cols):
		for row in range(rows):
			var t = tile_scene.instantiate()
			t.position.x = col * cell_size.x + cells_start_min.x * 1.5 + offset_x
			t.position.y = row * cell_size.y + cells_start_min.y
			tile_ids.set(t.get_instance_id(), 0)
			add_child(t)


func _on_ball_collided_with_object(collider_id: int) -> void:
	if not tile_ids.has(collider_id):
		return
	
	var tile = instance_from_id(collider_id)
	if not tile:
		return
	
	points_scored.emit(tile.points)
	remove_child(tile)
	tile.queue_free()
	
	if get_child_count() == 0:
		tiles_cleared.emit()


func reset_tiles() -> void:
	for tile in get_children():
		remove_child(tile)
		tile.queue_free()
	create_tiles()
