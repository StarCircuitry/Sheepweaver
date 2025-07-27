shader_type canvas_item;

uniform vec3 fabricColor1: source_color = vec3(0.875, 0.835, 0.812);
uniform vec3 fabricColor2: source_color = vec3(0.843, 0.8, 0.773);
uniform vec3 fabricColor3: source_color = vec3(0.804, 0.765, 0.733);
uniform float tolerance: hint_range(0.0, 1.0, 0.01) = 0.2;

void fragment() {
	if (distance(COLOR, vec4(0.875, 0.835, 0.812, 1.)) <= tolerance) {
		COLOR = vec4(fabricColor1, 1.);
	}
	else if (distance(COLOR, vec4(0.553, 0.553, 0.553, 1.)) <= tolerance) {
		COLOR = vec4(fabricColor2, 1.);
	}
	else if (distance(COLOR, vec4(0.247, 0.247, 0.247, 1.)) <= tolerance) {
		COLOR = vec4(fabricColor3, 1.);
	}
	//else {
	//	COLOR = COLOR * fabricColor1, 1.);
	//}

}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
