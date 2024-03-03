shader_type canvas_item;

uniform vec4 line_color  = vec4(1.0);
uniform float line_thickness : hint_range(0, 10) = 1.0;
uniform float fade : hint_range(0, 1) = 1;

const vec2 OFFSETS[8] = {
	vec2(-1, -1), vec2(-1, 0), vec2(-1, 1), vec2(0, -1), vec2(0, 1), 
	vec2(1, -1), vec2(1, 0), vec2(1, 1)
};

void fragment() {
	vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;
	float outline = 0.0;
	float n_outfade = fade;
	
	for (int i = 0; i < OFFSETS.length(); i++) {
		outline += texture(TEXTURE, UV + size * OFFSETS[i]).a;
	}
	outline = min(outline, 1.0);
	
	vec4 color = texture(TEXTURE, UV);
	
	outline = outline - color.a;
	
	float n_step = step(outline, fade);
	
	float n_test = n_step * outline;
		
	COLOR = mix(color, line_color, n_test);
}

//shader_type canvas_item;
//render_mode blend_mix;
//
//uniform sampler2D tex_frg_4;
//uniform float fade : hint_range(0, 1) = 1;
//
//
//
//void fragment() {
//// Input:2
	//vec2 n_out2p0 = UV;
//
//
	//vec4 n_out3p0;
//// Texture2D:3
	//n_out3p0 = texture(TEXTURE, n_out2p0);
	//float n_out3p4 = n_out3p0.a;
//
//
//// Texture2D:4
	//vec4 n_out4p0 = texture(tex_frg_4, n_out2p0);
//
//
//// FloatParameter:7
	//float n_out7p0 = fade;
//
//
//// Step:6
	//float n_out6p0 = step(n_out4p0.x, n_out7p0);
//
//
//// VectorOp:5
	//vec2 n_out5p0 = vec2(n_out3p4) * vec2(n_out6p0);
//
//
//// Output:0
	//COLOR.rgb = vec3(n_out3p0.xyz);
	//COLOR.a = n_out5p0.x;
//
//
//}
