class_name NetworkObject
extends Node
const PORT: int = 3304
var _gameNode: Node

func _init(gameNode: Node):
	_gameNode = gameNode

func _setup():
	_gameNode.get_tree().connect("network_peer_connected", self, "_player_connected")
	_gameNode.get_tree().connect("network_peer_disconnected", self, "_player_disconnected");
	_gameNode.get_tree().connect("connected_to_server", self, "_connected_ok");
	_gameNode.get_tree().connect("connection_failed", self, "_connected_fail");
	_gameNode.get_tree().connect("server_disconnected", self, "_server_disconnected");

func _player_connected(id):
	print("_player_connected")

func _player_disconnected(id):
	print("_player_disconnected")

func _connected_ok():
	print("_connected_ok")
	
func _connected_fail():
	print("_connected_fail")
	
func _server_disconnected():
	print("_server_disconnected")

func host_game(name):
	var host: NetworkedMultiplayerENet = NetworkedMultiplayerENet.new();
	host.create_server(PORT);
	_gameNode.get_tree().set_network_peer(host);
	print("host_game")

func join_game(ip):
	var host: NetworkedMultiplayerENet = NetworkedMultiplayerENet.new();
	host.create_client(ip, PORT);
	_gameNode.get_tree().set_network_peer(host);
	print("join_game")
	
func is_singleplayer_game():
	return !_gameNode.get_tree().has_network_peer()
	
# Adjust some netcode functions to work smoothly in SP and Multiplayer
func rpc_sp(caller: Node, method: String, args: Array = []):
	if !is_instance_valid(caller):
		return;
	if is_singleplayer_game():
		caller.callv(method, args)
	else:
		caller.callv("rpc", [method] + args)

func rpc_unreliable_sp(caller: Node, method: String, args: Array = []):
	if !is_instance_valid(caller):
		return;
	if is_singleplayer_game():
		caller.callv(method, args)
	else:
		caller.callv("rpc_unreliable", [method] + args)

func is_network_master_or_sp(caller: Node):
	return is_singleplayer_game() or caller.is_network_master()

func is_client() -> bool:
	return _gameNode.get_tree().has_network_peer() and !_gameNode.get_tree().is_network_server()

func is_client_connected() -> bool:
	if !_gameNode.get_tree().has_network_peer() or _gameNode.get_tree().is_network_server():
		return false;
	return _gameNode.get_tree().get_network_peer().get_connection_status() == _gameNode.get_tree().get_network_peer().CONNECTION_CONNECTED
