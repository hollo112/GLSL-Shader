#version 330

in vec3 a_Position;
const vec3 c_StartPos = vec3(-1, 0, 0);
const vec3 c_Velocity = vec3(2.0, 0, 0);
const vec3 c_ParaVelocity = vec3(2.0, 2.0, 0);
const vec2 c_2DGravity = vec2(0.0, -4.9);
const float c_PI = 3.141592;

const vec3 Left = vec3(-0.5, -0.5, 0.0);
const vec3 Right = vec3(0.5, -0.5, 0.0);
const vec3 Top = vec3(0.0, 0.5, 0.0);

uniform float u_Time = 0;
uniform	float u_Period = 2.0;

void Basic()
{
	vec4 newPosition = vec4(a_Position, 1);
	gl_Position = newPosition;
}

void Line()
{
	float newTime = fract((u_Time / u_Period) - 0.5) * 2.0;
	vec4 newPosition;
	newPosition.xyz = (a_Position + c_StartPos) + c_Velocity * newTime;
	newPosition.w = 1;
	gl_Position = newPosition;
}

void Circle()
{
	float newTime = fract(u_Time /  u_Period) * c_PI * 2.0;
	vec2 trans = vec2(cos(newTime), sin(newTime));
	vec4 newPosition;
	newPosition.xy = a_Position.xy + trans;
	newPosition.zw = vec2( 0, 1 );
	gl_Position = newPosition;
}

void Parablola()
{
	float newTime = fract(u_Time /  u_Period);
	float t = newTime;
	float tt = t*t;
	vec4 newPosition;
	float transX = (a_Position.x + c_StartPos.x) + c_ParaVelocity.x * newTime + 0.5 * c_2DGravity.x * tt;
	float transY = (a_Position.y + c_StartPos.y) + c_ParaVelocity.y * newTime + 0.5 * c_2DGravity.y * tt;
	newPosition.xy = vec2(transX, transY);
	newPosition.zw = vec2( 0, 1 );
	gl_Position = newPosition;
}

void Triangle()
{
	float newTime = fract(u_Time * 3);
    vec3 LtoR = (Right - Left) * newTime;
	vec3 RToT = (Top - Right) * newTime;
    vec3 TToL = (Left - Top) * newTime;

	vec4 newPosition;
	newPosition.xyz = (a_Position.xyz + Left) +  LtoR;
	newPosition.w = 1;

	gl_Position = newPosition;
}


void main()
{
	//Line();
	//Circle();
	//Parablola();
	//Basic();
	Triangle();
}
