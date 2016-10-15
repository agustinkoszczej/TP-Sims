import Sim.*

class Celo{
	var criterio
	
	method definirCriterio(unCriterio){
		criterio = unCriterio
	}
	 
	method ataque(unSim){
		unSim.filtrarAmigos(criterio)
	}
	
}

object celosPorPlata inherits Celo {
	
	override method ataque(unSim){
		self.definirCriterio({amigo => amigo.dinero() <= unSim.dinero()})
		super(unSim)
	}

}

object celosPorPopularidad inherits Celo{
	
	override method ataque(unSim){
		self.definirCriterio({amigo => amigo.nivelPopularidad() <= unSim.nivelPopularidad()})
		super(unSim)
	}
}

object celosPorPareja inherits Celo{
	override method ataque(unSim){
		self.definirCriterio({amigo => not unSim.pareja().esAmigoDe(amigo)})
		super(unSim)
	}
}
