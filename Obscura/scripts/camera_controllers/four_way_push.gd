class_name FourWayPush
extends CameraControllerBase


@export var push_ratio:float = 0.4
@export var pushbox_top_left := Vector2(-9.0, 6.0)
@export var pushbox_bottom_right := Vector2(9.0, -6.0)
@export var speedup_zone_top_left := Vector2(-5.0, 4.0)
@export var speedup_zone_bottom_right := Vector2(5.0, -4.0)

var _push_box_width : int
var _push_box_height : int
var _speed_box_width : int
var _speed_box_height : int


func _ready() -> void:
	super()
	position = target.position
	_push_box_width = abs(pushbox_top_left.x - pushbox_bottom_right.x)
	_push_box_height = abs(pushbox_top_left.y - pushbox_bottom_right.y)
	_speed_box_width = abs(speedup_zone_top_left.x - speedup_zone_bottom_right.x)
	_speed_box_height = abs(speedup_zone_top_left.y - speedup_zone_bottom_right.y)
	

func _process(delta: float) -> void:
	if !current:
		global_position = target.global_position
		return
		
	if draw_camera_logic:
		draw_logic()
		
	var tpos = target.global_position
	var cpos = global_position
	
	# boundary checks for speedzone
	var speed_left_edge = (tpos.x - target.WIDTH / 2.0) - (cpos.x - _speed_box_width / 2.0)
	var speed_right_edge = (tpos.x + target.WIDTH / 2.0) - (cpos.x + _speed_box_width / 2.0)
	var speed_top_edge = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - _speed_box_height / 2.0)
	var speed_bottom_edge = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + _speed_box_height / 2.0)
	# boundary checks for outer pushbox
	var push_left_edge = (tpos.x - target.WIDTH / 2.0) - (cpos.x - _push_box_width / 2.0)
	var push_right_edge = (tpos.x + target.WIDTH / 2.0) - (cpos.x + _push_box_width / 2.0)
	var push_top_edge = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - _push_box_height / 2.0)
	var push_bottom_edge = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + _push_box_height / 2.0)

	#left
	if speed_left_edge < 0:
		if push_left_edge < 0:
			global_position.x += push_left_edge
		else:
			global_position.x += speed_left_edge * target.velocity.x * push_ratio * delta
	#right
	if speed_right_edge > 0:
		if push_right_edge > 0:
			global_position.x += push_right_edge
		else:
			global_position.x -= speed_right_edge * target.velocity.x * push_ratio * delta
	#top
	if speed_top_edge < 0:
		if push_top_edge < 0:
			global_position.z += push_top_edge
		else:
			global_position.z += speed_top_edge * target.velocity.z * push_ratio * delta
	#bottom
	if speed_bottom_edge > 0:
		if push_bottom_edge > 0:
			global_position.z += push_bottom_edge
		else:
			global_position.z -= speed_bottom_edge * target.velocity.z * push_ratio * delta
	
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left:float = -_push_box_width / 2.0
	var right:float = _push_box_width / 2.0
	var top:float = -_push_box_height / 2.0
	var bottom:float = _push_box_height / 2.0
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_end()
	
	left = -_speed_box_width / 2.0
	right = _speed_box_width / 2.0
	top = -_speed_box_height / 2.0
	bottom = _speed_box_height / 2.0
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
