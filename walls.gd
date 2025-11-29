extends StaticBody2D

signal bottom_edge_crossed


func _on_bottom_edge_body_entered(body: Node2D) -> void:
	bottom_edge_crossed.emit()
