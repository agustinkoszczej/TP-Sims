import Sim.*

object celosPorPlata {
	method ataque(unSim){
		unSim.filtrarAmigos({amigo => amigo.dinero() <= unSim.dinero()})
	}
}

object celosPorPopularidad {
	method ataque(unSim){
		unSim.filtrarAmigos({amigo => amigo.nivelPopularidad() <= unSim.nivelPopularidad()})
	}
}

object celosPorPareja {
	method ataque(unSim){
		unSim.filtrarAmigos({amigo => not unSim.pareja().esAmigoDe(amigo)})
	}
}
