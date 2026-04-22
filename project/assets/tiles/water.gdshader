shader_type canvas_item;

uniform float wave_speed = 2.0;       // faster animation
uniform float wave_amplitude = 0.15;  // stronger distortion
uniform float wave_frequency = 20.0;  // more ripples
uniform vec4 water_color = vec4(0.0, 0.3, 0.6, 0.7);

void fragment() {
    vec2 uv = UV;

    // Apply stronger sine/cosine distortion
    uv.y += sin(uv.x * wave_frequency + TIME * wave_speed) * wave_amplitude;
    uv.x += cos(uv.y * wave_frequency + TIME * wave_speed) * wave_amplitude;

    float gradient = uv.y;

    COLOR = water_color * vec4(1.0, 1.0, 1.0, 1.0 - gradient * 0.5);
}
