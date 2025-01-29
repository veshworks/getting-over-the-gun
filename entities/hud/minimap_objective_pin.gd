@tool
extends MinimapVisual
class_name MinimapObjectivePin



func _process(delta: float) -> void:
	if !HUD.singleton: return
	var parent = get_parent()
	var camera = HUD.camera
	var projection_halfsize = camera.get_viewport_rect().size / camera.zoom / 2
	var min_bound = camera.global_position - projection_halfsize + camera.offset
	var max_bound = camera.global_position + projection_halfsize + camera.offset
	
	var center_on = parent.global_position
	
	global_position.x = clamp(center_on.x, min_bound.x, max_bound.x)
	global_position.y = clamp(center_on.y, min_bound.y, max_bound.y)
