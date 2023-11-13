shader_type canvas_item;

uniform vec4 flash_color: source_color = vec4(1.0);
uniform float flash_intensity: hint_range(0.0, 1.0) = 1;

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	vec4 modulate = COLOR - tex;
	tex.rgb = mix(tex.rgb, flash_color.rgb, flash_intensity);
	COLOR = tex + modulate;
}
