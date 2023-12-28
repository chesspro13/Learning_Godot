extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	apply_central_force( Vector3.UP * 1200.0 * delta )
		
	DrawLine3D.DrawRay(global_position, Vector3.UP, Color(0,1,0) )
	DrawLine3D.DrawRay(global_position, Vector3.FORWARD, Color(0,0,1) )
	DrawLine3D.DrawRay(global_position, Vector3.RIGHT, Color(1,0,0) )
	#print( "Global Basis: " , str( typeof(global_basis)) , " containing: " , global_basis	 )
