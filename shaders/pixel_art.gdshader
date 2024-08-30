shader_type canvas_item;

uniform float pixel_size : hint_range(1.0, 100.0, 1.0) = 4.0;
uniform float fade : hint_range(0.0, 1.0, 0.01) = 1.0;

void fragment() {
    vec2 texture_size = 1.0 / TEXTURE_PIXEL_SIZE;
    vec2 uv = UV;
    vec2 pixelated_uv = floor(uv * texture_size / pixel_size) * pixel_size / texture_size;
    vec4 color = texture(TEXTURE, pixelated_uv);
    COLOR = vec4(color.rgb * fade, color.a);
}
