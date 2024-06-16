shader_type canvas_item;
uniform float blue = 1.0;



float rand(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float color = 0.0;
	// Called for every pixel the material is visible on.
	//COLOR = vec4(0.5*cos(30.0*UV.x+TIME)+0.5, 0.5*cos(30.0*UV.y+TIME)+0.5, blue, 1.0);

	if (rand(SCREEN_UV.xy / 20.0) > 0.996) 
	{
		float r = rand(SCREEN_UV.xy);
		color = r*(0.85*sin(0.3*TIME*(r*5.0)+720.0*r)+0.95);
	}
	
	COLOR = vec4(vec3(color), 1.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
