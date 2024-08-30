shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float pixel_size : hint_range(1.0, 100.0, 1.0) = 10;
uniform float fade : hint_range(0.0, 1.0, 0.01) = 1.0;
uniform int color_levels : hint_range(2, 256, 1) = 16;

vec3 quantize_color(vec3 color) {
    float levels = float(color_levels);
    return floor(color * levels) / (levels - 1.0);
}

void fragment() {
    vec2 uv = SCREEN_UV;
    vec2 pixelated_uv = floor(uv * (1.0 / SCREEN_PIXEL_SIZE) / pixel_size) * pixel_size * SCREEN_PIXEL_SIZE;
    vec3 color = textureLod(SCREEN_TEXTURE, pixelated_uv, 0.0).rgb;
    vec3 quantized_color = quantize_color(color);
    COLOR = vec4(quantized_color * fade, 1.0);
}
