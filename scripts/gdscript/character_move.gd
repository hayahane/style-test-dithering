extends CharacterBody3D

@export var move_speed:float = 2.0
@export var move_accelerate:float = 5.0
@export var pitch_clamp:Vector2 = Vector2(-30.0, 45.0)
@export var mouse_input_scale = 100
@export var camera_rotate_speed = 20
@export var target_camera: Node3D

var mouse_position:Vector2
var camera_rotation:Vector3

# Node references
@onready var player_model:Node3D = get_node("TestBot")
@onready var animation_tree:AnimationTree = get_node("TestBot/AnimationTree")
@onready var camera_springarm:Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_position = get_viewport().get_mouse_position() / Vector2(get_viewport().size)
	camera_springarm = get_node("SpringArm3D")
	camera_rotation = camera_springarm.rotation_degrees
	print(mouse_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#region Get Input
	var move_input:Vector2 = Input.get_vector("move_left_axis",
			"move_right_axis", "move_down_axis", "move_up_axis")
			
	var camera_input:Vector2 = Input.get_vector("camera_left_axis",
			"camera_right_axis","camera_down_axis","camera_up_axis")
	if camera_input.is_equal_approx(Vector2.ZERO):
		var current_mouse_position:Vector2 = get_viewport().get_mouse_position()/Vector2(get_viewport().size)
		camera_input = current_mouse_position - mouse_position
		camera_input.x *= -1
		camera_input *= mouse_input_scale
		mouse_position = current_mouse_position
	#endregion
	
	#region Rotate Camera
	camera_rotation += Vector3(camera_input.y * camera_rotate_speed,camera_input.x * camera_rotate_speed,0.0)
	camera_rotation.x = clamp(camera_rotation.x, pitch_clamp.x, pitch_clamp.y)
	camera_springarm.rotation_degrees = camera_rotation
	#endregion
	
	#region Process Velocity
	var camera_basis:Basis = target_camera.global_basis
	var desired_velocity:Vector3 = (camera_basis.x.slide(up_direction).normalized()) * move_input.x + (-camera_basis.z.slide(up_direction).normalized()) * move_input.y
	desired_velocity -= velocity;
	velocity += desired_velocity.normalized() * clamp(move_accelerate * delta, 0, desired_velocity.length())
	move_and_slide()
		
	animation_tree.set("parameters/move_speed/blend_position", velocity.length())
	
	var direction:Vector3 = velocity.normalized();
	if velocity.is_equal_approx(Vector3.ZERO) :
		return;
	player_model.transform = Transform3D(Basis(Vector3.UP.cross(direction).normalized(), Vector3.UP, direction))
	#endregion
