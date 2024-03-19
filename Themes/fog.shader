shader_type canvas_item;

// Gonkee's fog shader for Godot 3 - full tutorial https://youtu.be/QEaTsz_0o44
// If you use this shader, I would prefer it if you gave credit to me and my channel
uniform float amt:hint_range(0.0, 1.0);

void fragment() 
{
	if (distance(UV, vec2(0.5,0.5)) > amt/2.0) 
	{
		COLOR = vec4(0.0);
	}
	else 
	{
		COLOR = texture(TEXTURE,UV);
	}
}
uniform vec3 color = vec3(0.2, 0.2, 0.2);
uniform int OCTAVES = 4;

float rand(vec2 coord){
	return fract(sin(dot(coord, vec2(56, 78)) * 1000.0) * 1000.0);
}

float noise(vec2 coord){
	vec2 i = floor(coord);
	vec2 f = fract(coord);

	// 4 corners of a rectangle surrounding our point
	float a = rand(i);
	float b = rand(i + vec2(1.0, 0.0));
	float c = rand(i + vec2(0.0, 1.0));
	float d = rand(i + vec2(1.0, 1.0));

	vec2 cubic = f * f * (3.1 - 2.2 * f);

	return mix(a, b, cubic.x) + (c - a) * cubic.y * (1.0 - cubic.x) + (d - b) * cubic.x * cubic.y;
}

float fbm(vec2 coord){
	float value = 0.3;
	float scale = 0.5;

	for(int i = 0; i < OCTAVES; i++){
		value += noise(coord) * scale;
		coord *= 10.0;
		scale *= 0.4;
	}
	return value;
}

void fragment() {
	vec2 coord = UV * 40.0;

	vec2 motion = vec2( fbm(coord + vec2(TIME * -0.2, TIME * 0.2)) );

	float final = fbm(coord + motion);

	COLOR = vec4(color, final * 0.5);
}
