import Sim.*
	
	//+--------------------+
	//| Inicio Interesados |
	//+--------------------+
	
object interesado {
	method valorarPersonalidad (sim, simValorado){
		var amigosDelSim = simValorado.amigos()
		var dineroAmigos = amigosDelSim.sum({unSim => unSim.dinero()})
		return dineroAmigos * 0.1
	}
	
	method leAtraen(unSim, simDeInteres){
		return (simDeInteres.dinero() >= unSim.dinero()*2)
	}
}


	//+-----------------+
	//| Fin Interesados |
	//+-----------------+
	
	//---------------------------------------------------------------
	
	//+----------------------+
	//| Inicio Superficiales |
	//+----------------------+


object superficial {
	method valorarPersonalidad  (sim, simValorado){
		return 20 * simValorado.nivelPopularidad()
	}
	
	method leAtraen(unSim, simDeInteres){
		return ((simDeInteres.nivelPopularidad() >= unSim.amigoMasPopular().nivelPopularidad()) && simDeInteres.joven())
	}
}


	//+-------------------+
	//| Fin Superficiales |
	//+-------------------+
	
	//---------------------------------------------------------------
	
	//+-----------------+
	//| Inicio Buenazos |
	//+-----------------+

object buenazo {
	method valorarPersonalidad (sim, simValorado){
		return 0.5 * sim.nivelFelicidad()
	}
	
	method leAtraen(unSim, simDeInteres){
		return true
	}
}

	//+--------------+
	//| Fin Buenazos |
	//+--------------+
	
	//---------------------------------------------------------------

	//+----------------------------+
	//| Inicio Peleados con la Vida|
	//+----------------------------+
	
object peleadoConLaVida {
	method valorarPersonalidad (sim, simValorado){
		return 0
	}
	
	method leAtraen(unSim, simDeInteres){
		return (simDeInteres.triste())
	}
}

	//+-------------------------+
	//| Fin Peleados con la Vida|
	//+-------------------------+
