﻿Shader "Custom/Unlit-Color" {
// Unlit shader. Simplest possible colored shader.
// - no lighting
// - no lightmap support
// - no texture

Properties {
    _Color ("Main Color", Color) = (1,1,1,1)
    [Enum(UnityEngine.Rendering.BlendMode)] _Blend ("Blend mode", Float) = 1
    [Enum(UnityEngine.Rendering.BlendMode)] _Blend2 ("Blend mode 2", Float) = 1
    [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull mode", Float) = 1
}

SubShader {
    Tags { "RenderType"="Opaque" }
    ZWrite On
    LOD 100
    Blend [_Blend] [_Blend2]
    Cull [_Cull]
    
    Pass {  
        CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog
            
            #include "UnityCG.cginc"

            struct appdata_t {
                float4 vertex : POSITION;
            };

            struct v2f {
                float4 vertex : SV_POSITION;
                UNITY_FOG_COORDS(0)
            };

            fixed4 _Color;
            
            v2f vert (appdata_t v)
            {
                v2f o;
                o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }
            
            fixed4 frag (v2f i) : COLOR
            {
                fixed4 col = _Color;
                UNITY_APPLY_FOG(i.fogCoord, col);
                UNITY_OPAQUE_ALPHA(col.a);
                return col;
            }
        ENDCG
    }
}
CustomEditor "RenderQueueMaterialInspector"

}
