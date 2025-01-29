@tool
extends Node2D
class_name MinimapVisual

const minimap_layer = 1 << 1

@export var make_all_parents_inherit_visibility_layer: bool = true:
	get():
		var parent = self.get_parent()
		while parent is CanvasItem:
			if ~parent.visibility_layer & minimap_layer != 0:
				return false
			parent = parent.get_parent()
		return true
	set(value):
		var parent = self.get_parent()
		while parent is CanvasItem:
			if value:
				parent.visibility_layer |= minimap_layer
			else:
				parent.visibility_layer &= ~minimap_layer
			parent = parent.get_parent()

func _ready() -> void:
	self.visibility_layer = minimap_layer
