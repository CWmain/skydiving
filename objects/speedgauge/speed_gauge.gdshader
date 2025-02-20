shader_type canvas_item;

void fragment() {
	// Called for every pixel the material is visible on.
	if (COLOR == vec4(1,1,1,1)){
		// The green section
		if ((1.0-UV.y) <= (1.0-UV.x)*0.5){
			COLOR = vec4(0,1,0,1);
		}
		// The yellow section
		else if ((1.0-UV.y) <= (1.0-UV.x)*2.0){
			COLOR = vec4(1,1,0,1);
		}
		// The red section
		else{
			COLOR = vec4(1,0,0,1);
		}
	}
		
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
