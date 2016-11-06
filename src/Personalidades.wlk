import Sim.*

class Personalidades {
	
	method maximoPrestamo(unSim, otroSim){
		return return unSim.valorarSim(otroSim) * 10
	}
	
	method trabajar(unSim){
	}
}
	
object interesado inherits Personalidades {
	method valorarPersonalidad (sim, simValorado){
		return 0.1 * simValorado.dineroDeAmigos()
	}
	
	method leAtrae(unSim, simDeInteres){
		return unSim.duplicaMiFortuna(simDeInteres)
	}
	
	override method maximoPrestamo(unSim, otroSim){
			return (otroSim.dinero()).min(super(unSim,otroSim))
	}
	
}

object superficial inherits Personalidades {
	method valorarPersonalidad  (sim, simValorado){
		return 20 * simValorado.nivelPopularidad()
	}
	
	method leAtrae(unSim, simDeInteres){
		return simDeInteres.esElMasPopular() && simDeInteres.joven()
	}
}

object buenazo inherits Personalidades {
	method valorarPersonalidad (sim, simValorado){
		return 0.5 * sim.nivelFelicidad()
	}
	
	method leAtrae(unSim, simDeInteres){
		return true
	}
	
	override method trabajar(unSim){
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
}