vec4 position(mat4 transformation_projection, vec4 vertex_position) {
    return transformation_projection * vertex_position;
}

const vec3 yellow = vec3(255, 234, 0);

vec4 effect(vec4 color, Image texture, vec2 texcoord, vec2 pixcoord) {
    vec4 texcolor = Texel(texture, texcoord);
    texcolor.rgb = yellow;
    return texcolor;
}
