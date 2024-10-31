class_name PosLockLerp
extends CameraControllerBase


@export var cross_width:float = 7.0
@export var cross_height:float = 7.0

@export var follow_speed:float = 10.0
@export var catchup_speed:float = 5.0
@export var leash_distance:float = 30.0


func _ready() -> void:
	super()
	position = target.position
	

func _process(delta: float) -> void:
	if !current:
		return
		
	if draw_camera_logic:
		draw_logic()
		
	var tpos = target.global_position
	var cpos = global_position
	var x_distance = tpos.x - cpos.x
	var z_distance = tpos.z - cpos.z
	
	# check leash distance x
	if abs(x_distance) > leash_distance:
		global_position.x += x_distance / follow_speed
	elif x_distance != 0:
		global_position.x += x_distance / catchup_speed
	#check leash distance z
	if abs(z_distance) > leash_distance:
		global_position.z += z_distance / follow_speed
	elif z_distance != 0:
		global_position.z += z_distance / catchup_speed
		
	
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left:float = -cross_width / 2
	var right:float = cross_width / 2
	var top:float = -cross_height / 2
	var bottom:float = cross_height / 2
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	
	# vertical line in cross!
	immediate_mesh.surface_add_vertex(Vector3(0, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, bottom))
	
	# horizontal line in cross!
	immediate_mesh.surface_add_vertex(Vector3(left, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, 0))
	
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
