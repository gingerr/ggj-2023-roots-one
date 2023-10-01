shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform vec3 overlay;

// https://godotshaders.com/snippet/blending-modes/
vec3 blend_overlay(vec3 base, vec3 blend){ 	
	vec3 limit = step(0.5, base);
	return mix(2.0 * base * blend, 1.0 - 2.0 * (1.0 - base) * (1.0 - blend), limit);
}

void fragment() {
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV);
	COLOR.rgb = blend_overlay(COLOR.rgb, overlay.rgb);
}
