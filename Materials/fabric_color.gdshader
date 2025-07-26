shader_type canvas_item;

uniform vec3 fabricColor1: source_color = vec3(1.);
uniform vec3 fabricColor2: source_color = vec3(.5);

void fragment() {
	
	COLOR = vec4(fabricColor1, 1.) * COLOR;

}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
