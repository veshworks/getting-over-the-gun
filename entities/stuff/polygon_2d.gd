@tool
extends Polygon2D

func _set(property: StringName, value: Variant) -> bool:
	if property == 'polygon':
		%Collider.polygon = value
	return false
