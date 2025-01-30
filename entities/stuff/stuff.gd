@tool
extends StaticBody2D

@export var texture: Texture2D:
	set(value):
		texture = value
		call_deferred("update_sprite_texture", texture)
		var bm = BitMap.new()
		bm.create_from_image_alpha(texture.get_image())
		var rect = Rect2(position.x, position.y, texture.get_width(), texture.get_height())
		var my_array = bm.opaque_to_polygons(rect, 0.0001)
		var my_polygon = Polygon2D.new()
		my_polygon.set_polygons(my_array)
		var offsetX = 0
		var offsetY = 0
		if (texture.get_width() % 2 != 0):
			offsetX = 1
		if (texture.get_height() % 2 != 0):
			offsetY = 1
		for child in get_children():
			if not child is Sprite2D:
				remove_child(child)
		for i in range(my_polygon.polygons.size()):
			var my_collision = CollisionPolygon2D.new()
			self.add_child(my_collision, false, Node.INTERNAL_MODE_DISABLED)
			my_collision.set_polygon(my_polygon.polygons[i])
			my_collision.position -= Vector2((texture.get_width() / 2.0) + offsetX, texture.get_height() + offsetY) * scale.x
			my_collision.scale = scale
			my_collision.owner = self

func update_sprite_texture(tex: Texture2D) -> void:
	$Sprite2D.set_deferred("texture", tex)
	if $minimap:
		$minimap.set_deferred("texture", tex)
