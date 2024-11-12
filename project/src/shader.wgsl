struct VertexOutput {
    @builtin(position) clip_position: vec4<f32>,
    @location(0) uv: vec2<f32>,          // UV coordinates for gradient
};

@vertex
fn vs_main(@builtin(vertex_index) in_vertex_index: u32) -> VertexOutput {
    // Define vertices for a full-screen quad
    var pos = array<vec2<f32>, 6>(
        // First triangle
        vec2<f32>(-1.0, -1.0),  // Bottom-left
        vec2<f32>(1.0, -1.0),   // Bottom-right
        vec2<f32>(-1.0, 1.0),   // Top-left
        // Second triangle
        vec2<f32>(-1.0, 1.0),   // Top-left
        vec2<f32>(1.0, -1.0),   // Bottom-right
        vec2<f32>(1.0, 1.0)     // Top-right
    );

    var uv = array<vec2<f32>, 6>(
        // UV coordinates matching the vertices
        vec2<f32>(0.0, 0.0),
        vec2<f32>(1.0, 0.0),
        vec2<f32>(0.0, 1.0),
        vec2<f32>(0.0, 1.0),
        vec2<f32>(1.0, 0.0),
        vec2<f32>(1.0, 1.0)
    );

    var output: VertexOutput;
    output.clip_position = vec4<f32>(pos[in_vertex_index], 0.0, 1.0);
    output.uv = uv[in_vertex_index];
    return output;
}

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    // Create a smooth gradient using UV coordinates
    let color1 = vec3<f32>(0.88, 0.1, 0.96);  
    let color2 = vec3<f32>(0.04, 0.96, 0.94); 

    // Diagonal gradient
    let t = (in.uv.x + in.uv.y) * 0.5;

    // // Horizontal gradient
    // let t = in.uv.x;

    // // Vertical gradient
    // let t = in.uv.y;

    // Radial gradient
    // let t = length(in.uv - vec2<f32>(0.5, 0.5)) * 2.0;

    let final_color = mix(color1, color2, t);
    
    return vec4<f32>(final_color, 1.0);
}