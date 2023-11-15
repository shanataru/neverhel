shader_type canvas_item;

uniform vec4 new_color: source_color = vec4(1.0);

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	//tex.rgb = mix(tex.rgb, blend_color.rgb, blend_alpha);
	float g = (tex.r + tex.g + tex.b) / 3.0;
	vec4 greyscale = vec4(g, g, g, tex.a);
	COLOR = greyscale * new_color;
}
