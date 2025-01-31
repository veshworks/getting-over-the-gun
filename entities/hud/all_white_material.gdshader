shader_type canvas_item;

void fragment() {
	COLOR = texture(TEXTURE, UV); //read from texture
	COLOR.r = 1.0;
	COLOR.g = 1.0;
	COLOR.b = 1.0;
}