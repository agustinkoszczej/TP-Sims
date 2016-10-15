import Sim.*

class Personalidades {
	method presta(unSim, otroSim)
	{
		return unSim.valorarSim(otroSim) * 10
	}
}
	
object interesado inherits Personalidades {
	method valorarPersonalidad (sim, simValorado){
		var amigosDelSim = simValorado.amigos()
		var dineroAmigos = amigosDelSim.sum({unSim => unSim.dinero()})
		return dineroAmigos * 0.1
	}
	
	method leAtrae(unSim, simDeInteres){
		return unSim.duplicaMiFortuna(simDeInteres)
	}
	
	method trabajar(unSim){
	}
	
	method cuantoPrestar(unSim, otroSim){
			return (otroSim.dinero()).min(self.presta(unSim, otroSim))
	}
	
}

object superficial inherits Personalidades {
	method valorarPersonalidad  (sim, simValorado){
		return 20 * simValorado.nivelPopularidad()
	}
	
	method leAtrae(unSim, simDeInteres){
		return unSim.masPopularQueAmigo(simDeInteres) && simDeInteres.joven()
	}
	
	method trabajar(unSim){
	}
	
	method cuantoPrestar(unSim, otroSim){
		return self.presta(unSim, otroSim)
	}
}

object buenazo inherits Personalidades {
	method valorarPersonalidad (sim, simValorado){
		return 0.5 * sim.nivelFelicidad()
	}
	
	method leAtrae(unSim, simDeInteres){
		return true
	}
	
	method trabajar(unSim){
		if(unSim.trabajaConTodosSusAmigos()){
			unSim.darFelicidad(unSim.nivelFelicidad() * 0.1)
		}
	}
	
	method cuantoPrestar(unSim, otroSim){
		return self.presta(unSim, otroSim)
	}
}

object peleadoConLaVida inherits Personalidades {
	method valorarPersonalidad (sim, simValorado){
		return 0
	}
	
	method leAtrae(unSim, simDeInteres){
		return simDeInteres.triste()
	}
	
	method trabajar(unSim){
	}
	
	method cuantoPrestar(unSim, otroSim){
		return self.presta(unSim, otroSim)
	}
}