shader_type canvas_item;

uniform float Progress = 1.0;
uniform float isDisabled = 0.0;
uniform float isHovered = 0.0;
uniform sampler2D Texture;
uniform sampler2D HoverTexture;

void fragment() {
	vec4 color = texture(Texture, UV);
	vec4 hover = texture(HoverTexture, UV);
	vec4 shadow = color * 0.5;
	shadow.a = color.a;
	float lum = color.r * 0.299 + color.g * 0.587 + color.b * 0.114;
	vec4 disabled = vec4(lum, lum, lum, color.a);
	float hoverAlpha = hover.a * isHovered * (1.0 - isDisabled);
	
	vec2 pos = UV - vec2(0.5, 0.5);
	float angle = mod(
		radians(450) + atan(pos.y, pos.x), 
		radians(360)
		);
	float value = angle / radians(360);
	float alpha = step(value, Progress);
	
	vec4 withProgress = mix(shadow, color, alpha);
	vec4 withDisabled = mix(withProgress, disabled, isDisabled);
	vec4 withHover = withDisabled * (1.0 - hoverAlpha) + hover * hoverAlpha;
	
	COLOR = withHover;
}