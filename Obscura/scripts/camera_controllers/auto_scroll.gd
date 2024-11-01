class_name AutoScroll
extends CameraControllerBase


@export var top_left := Vector2(-7.0, 7.0)
@export var bottom_right := Vector2(7.0, -7.0)
@export var autoscroll_speed := Vector3(0.2, 0.0, 0.0)

var _box_width : int
var _box_height : int


func _ready() -> void:
	super()
	position = target.position
	_box_width = abs(top_left.x - bottom_right.x)
	_box_height = abs(top_left.y - bottom_right.y)


func _process(delta: float) -> void:
	if !current:
		# makes sure the autoscroller doesnt keep going on its own lol
		# will prolly be removed once i get the boundaries working
		global_position = target.global_position
		return
		
	if draw_camera_logic:
		draw_logic()
		
	var tpos = target.global_position
	var cpos = global_position
	
	# camera position automatically keeps moving!
	global_position.x += autoscroll_speed.x
	global_position.z += autoscroll_speed.z
	
	# player position also moves with autoscroll
	target.global_position.x += autoscroll_speed.x
	target.global_position.z += autoscroll_speed.z
	
	# boundary checks!!! pushes player along on autoscroll
	var diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x - _box_width / 2.0)
	if diff_between_left_edges < 0:
		target.global_position.x -= diff_between_left_edges
	#right
	var diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x + _box_width / 2.0)
	if diff_between_right_edges > 0:
		target.global_position.x -= diff_between_right_edges
	#top
	var diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - _box_height / 2.0)
	if diff_between_top_edges < 0:
		target.global_position.z -= diff_between_top_edges
	#bottom
	var diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + _box_height / 2.0)
	if diff_between_bottom_edges > 0:
		target.global_position.z -= diff_between_bottom_edges
	
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left:float = -_box_width / 2.0
	var right:float = _box_width / 2.0
	var top:float = -_box_height / 2.0
	var bottom:float = _box_height / 2.0
	
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
