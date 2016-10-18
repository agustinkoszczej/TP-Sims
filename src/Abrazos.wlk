import Sim.*
import EstadosDeAnimo.*

object comun {

method abrazar(unSim, otroSim){
		unSim.darFelicidad(2)
		otroSim.darFelicidad(4)
}

}

object prolongado {

method abrazar(unSim, otroSim){
	if (otroSim.leAtrae(unSim))
			{
				otroSim.sentirse(soniador)
			}
		else {
			otroSim.sentirse(incomodo)
		}
}
}