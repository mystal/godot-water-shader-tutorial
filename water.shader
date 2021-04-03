shader_type canvas_item;

uniform vec4 blue_tint : hint_color;

void fragment() {
	ivec2 texture_size = textureSize(TEXTURE, 0);
	
	// TODO: Multiply UV times the scale of the texture. Which we can derive somehow...
	vec2 noisecoord1 = UV;
	vec2 noisecoord2 = UV + 4.0;
	
	vec2 motion1 = vec2(TIME * 0.1, TIME * -0.2);
	vec2 motion2 = vec2(TIME * 0.03, TIME * 0.3);
	
	vec2 distort1 = vec2(textureLod(TEXTURE, noisecoord1 + motion1, 0.0).r, textureLod(TEXTURE, noisecoord2 + motion1, 0.0).r) - vec2(0.5);
	vec2 distort2 = vec2(textureLod(TEXTURE, noisecoord1 + motion2, 0.0).r, textureLod(TEXTURE, noisecoord2 + motion2, 0.0).r) - vec2(0.5);
	
	vec2 distort_sum = (distort1 + distort2) / 60.0;
	
	vec4 color = textureLod(SCREEN_TEXTURE, SCREEN_UV + distort_sum, 0.0);

	color = mix(color, blue_tint, 0.3);
	color.rgb = mix(vec3(0.5), color.rgb, 1.4);

	COLOR = color;
}