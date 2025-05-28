shader_type canvas_item;

uniform float pixel_size : hint_range(1.0, 100.0, 1.0) = 1;
uniform float fade : hint_range(0.0, 1.0, 0.01) = 1.0;
uniform float alpha_fade : hint_range(0.0, 1.0, 0.01) = 1.0;
uniform int color_levels : hint_range(2, 256, 1) = 100;

vec3 quantize_color(vec3 color) {
    float levels = float(color_levels);
    return floor(color * levels) / (levels - 1.0);
}

void fragment() {
    vec2 texture_size = 1.0 / TEXTURE_PIXEL_SIZE;
    vec2 uv = UV;
    vec2 pixelated_uv = floor(uv * texture_size / pixel_size) * pixel_size / texture_size;
    vec4 color = texture(TEXTURE, pixelated_uv);
    vec3 quantized_color = quantize_color(color.rgb);
    COLOR = vec4(quantized_color * fade, color.a * alpha_fade);
}
