import Sim.*

class Personalidades {
	method presta(unSim, otroSim)
	{
		return unSim.valorarSim(otroSim) * 10
	}
	
	method cuantoPrestar(unSim, otroSim){
		return self.presta(unSim, otroSim)
	}
}
	
object interesado inherits Personalidades {
	method valorarPersonalidad (sim, simValorado){
		return 0.1 * (simValorado.amigos()).sum({unSim => unSim.dinero()})
	}
	
	method leAtrae(unSim, simDeInteres){
		return unSim.duplicaMiFortuna(simDeInteres)
	}
	
	method trabajar(unSim){
	}
	
	override method cuantoPrestar(unSim, otroSim){
			return (otroSim.dinero()).min(self.presta(unSim, otroSim))
	}
	
}

object superficial inherits Personalidades {
	method valorarPersonalidad  (sim, simValorado){
		return 20 * simValorado.nivelPopularidad()
	}
	
	method leAtrae(unSim, simDeInteres){
		return simDeInteres.masPopularQueAmigos() && simDeInteres.joven()
	}
	
	method trabajar(unSim){
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
}