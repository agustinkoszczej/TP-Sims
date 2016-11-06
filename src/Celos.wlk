import Sim.*

class Celo{
	 
	method atacar(unSim){
		unSim.filtrarAmigos({amigo => self.filtrar(unSim, amigo)})
	}
	
	method filtrar(unSim, amigo){
		return false
	}
}

object celosPorPlata inherits Celo {
	
	override method filtrar(unSim, amigo){
		return amigo.dinero() <= unSim.dinero()
	}

}

object celosPorPopularidad inherits Celo{
	
	override method filtrar(unSim, amigo){
		return amigo.nivelPopularidad() <= unSim.nivelPopularidad()
	}
}

object celosPorPareja inherits Celo{
		
		override method filtrar(unSim, amigo){
		return  not unSim.pareja().esAmigoDe(amigo)
	}
}
