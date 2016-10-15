import Sim.*

object celos {
	
	method atacado(unSim, valor){
		unSim.filtrarAmigos({amigo => amigo.dinero() <= valor})
	}
	
}

object celosPorPlata {
	method ataque(unSim){
		celos.atacado(unSim, unSim.dinero())
	}
}

object celosPorPopularidad {
	method ataque(unSim){
		celos.atacado(unSim, unSim.nivelPopularidad())
	}
	
}

object celosPorPareja {
	method ataque(unSim){
		unSim.filtrarAmigos({amigo => not unSim.pareja().esAmigoDe(amigo)})
	}
}
