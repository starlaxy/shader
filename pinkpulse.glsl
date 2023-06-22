vec3 palette(float t){
    vec3 a = vec3(0.576, 0.106, 0.358);
    vec3 b = vec3(0.543,0.339, 0.381);
    vec3 c = vec3(1.456,0.647, 0.736);
    vec3 d = vec3(5.355, 5.707, 2.626);
    
    return a + b*cos(6.28318*(c*t+d));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord / iResolution.xy;
    uv = uv - 0.5;
    uv = uv * 2.0;
    
    uv*= 2.0;
    uv.x *= iResolution.x / iResolution.y;
    //vec2 uv = fragCoord / iResolution.xy * 2.0 -1.0;
    
    vec2 uv0 = uv;
    vec3 finalColor = vec3(0.0);
    
    for (float i = 0.; i < 3.; i++){
    
    uv = fract(uv*1.2);
    uv -=0.5;
    float d = length(uv) * exp(-length(uv0));
   
    vec3 col = palette(length(uv0)+i*.4+iTime*.4);
   
    d = sin(d*8. + iTime)/8.;
    d=abs(d);
    //d = smoothstep(0.0, 0.1,d);
    //d = 0.01/d;
    d = pow (0.01/d,1.2);
    //col *= d;
    finalColor += col * d;
    }
    
    fragColor = vec4(finalColor,1);
}