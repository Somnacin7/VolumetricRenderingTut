// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unlit/Shader01"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Center ("Center", Vector) = (0.0, 0.0, 0.0, 0.0)
		_Radius ("Radius", Float) = 1.0f
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			float3 _Center;
			float _Radius;

			struct v2f {
				float4 pos: SV_POSITION; // Clip space
				float3 wPos : TEXCOORD1; // World Position
			};

			v2f vert(appdata_full v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.wPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				return o;
			}

			fixed4 frag (v2f i): SV_TARGET
			{
				float3 worldPos = i.wPos;
				float3 viewDir = normalize(i.wPos - _WorldSpaceCameraPos);
				if (raycastHit(worldPos, viewDir))
			}

			#define STEPS 64
			#define STEP_SIZE 0.01

			bool raymarchHit(float3 pos, float3 dir)
			{
				for (int i = 0; i < STEPS; i++)
				{
					if (sphereHit(pos))
						return true;

					pos += direction * STEP_SIZE;
				}

				return false;
			}

			bool sphereHit(float3 p)

			ENDCG
		}
	}
}
