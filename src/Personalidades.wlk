import Sim.*
	
object interesado {
	method valorarPersonalidad (sim, simValorado){
		var amigosDelSim = simValorado.amigos()
		var dineroAmigos = amigosDelSim.sum({unSim => unSim.dinero()})
		return dineroAmigos * 0.1
	}
	
	method leAtraen(unSim, simDeInteres){
		return unSim.duplicaMiFortuna(simDeInteres)
	}
}

object superficial {
	method valorarPersonalidad  (sim, simValorado){
		return 20 * simValorado.nivelPopularidad()
	}
	
	method leAtrae(unSim, simDeInteres){
		return unSim.masPopularQueAmigo(simDeInteres) && simDeInteres.joven()
	}
}

object buenazo {
	method valorarPersonalidad (sim, simValorado){
		return 0.5 * sim.nivelFelicidad()
	}
	
	method leAtraen(unSim, simDeInteres){
		return true
	}
}

object peleadoConLaVida {
	method valorarPersonalidad (sim, simValorado){
		return 0
	}
	
	method leAtraen(unSim, simDeInteres){
		return simDeInteres.triste()
	}
}