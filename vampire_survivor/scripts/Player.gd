extends Node3D

@export var move_speed: float = 5.0
@export var camera_smoothness: float = 5.0

var velocity: Vector3 = Vector3.ZERO
var target_camera_position: Vector3 = Vector3.ZERO
var camera_node: Camera3D

func _ready():
	# Obtener referencia a la cámara
	camera_node = $Camera3D
	
	# Posicionar la cámara inicialmente sobre el jugador
	target_camera_position = global_position + Vector3(0, 10, -8)
	camera_node.global_position = target_camera_position
	
	# Configurar la cámara para vista desde arriba
	camera_node.rotation_degrees.x = -60  # Ángulo hacia abajo
	camera_node.rotation_degrees.y = 0
	camera_node.rotation_degrees.z = 0

func _physics_process(delta):
	# Obtener input de movimiento (WASD)
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if input_direction != Vector2.ZERO:
		# Mover en la dirección del input
		velocity = Vector3(input_direction.x, 0, input_direction.y).normalized() * move_speed
	else:
		velocity = Vector3.ZERO
	
	# Aplicar movimiento
	global_position += velocity * delta
	
	# Actualizar posición objetivo de la cámara
	target_camera_position = global_position + Vector3(0, 10, -8)
	
	# Suavizar movimiento de la cámara
	camera_node.global_position = camera_node.global_position.lerp(target_camera_position, camera_smoothness * delta)
