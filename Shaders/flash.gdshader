shader_type canvas_item;

uniform vec4 flash_color: source_color = vec4(1.0);
uniform float max_flash_intenxity = 0.8;
//uniform float flash_intensity: hint_range(0.0, 1.0) = 1.0;
uniform bool is_active = false;
uniform float flash_speed = 30;

void fragment() {
	float flash_intensity = 0.0;
	vec4 tex = texture(TEXTURE, UV);
	vec4 modulate = COLOR - tex;
	if(is_active){
		if(sin(TIME*flash_speed) > 0.0){
			flash_intensity = max_flash_intenxity;
		}
	}
	tex.rgb = mix(tex.rgb, flash_color.rgb, flash_intensity);
	COLOR = tex + modulate;
}
