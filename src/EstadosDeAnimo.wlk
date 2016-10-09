import Sim.*

object soniador {
	method efectuar(unSim){
		unSim.darFelicidad(1000)
		unSim.amnesia()
	}
}

object incomodo {
	method efectuar(unSim){
		unSim.darFelicidad(-200)
	}
}

object normal {
	method efectuar (unSim){ }
}