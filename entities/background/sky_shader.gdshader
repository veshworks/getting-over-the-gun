shader_type canvas_item;

uniform float height: hint_range(0, 1);
uniform float variation = 4.0;
uniform vec4 floor_color: source_color;
uniform vec4 sky_color: source_color;

void fragment() {
	COLOR.r = mix(floor_color.r, sky_color.r, height - UV.y/variation);
	COLOR.g = mix(floor_color.g, sky_color.g, height - UV.y/variation);
	COLOR.b = mix(floor_color.b, sky_color.b, height - UV.y/variation);
}