import Sim.*

class Trabajo {
	var sueldo
	var felicidad
	
	constructor (unSueldo, unaFelicidad){
		sueldo = unSueldo
		felicidad = unaFelicidad
	}
	
	method trabajar(unSim){
		unSim.darFelicidad(felicidad)
		unSim.darDinero(sueldo)
		unSim.personalidad().trabajar(self)
		unSim.volverALaNormalidad()
	}
}

class Copado inherits Trabajo {
	
	constructor (unSueldo, unaFelicidad) = super(unSueldo, unaFelicidad){
		sueldo = unSueldo
		felicidad = unaFelicidad
	}
}

class Mercenario inherits Trabajo{
	
	constructor (unSueldo, unaFelicidad) = super(unSueldo, unaFelicidad){
		sueldo = unSueldo
		felicidad = unaFelicidad
	}
	override method trabajar(unSim){
		unSim.darDinero(100 + 0.02 * unSim.dinero())
	}
}

class Aburrido inherits Trabajo{
	
	constructor (unSueldo, unaFelicidad) = super(unSueldo, unaFelicidad){
		sueldo = unSueldo
		felicidad = -unaFelicidad
	}	
}

class AburridoHastaLaMuerte inherits Aburrido{
	var multiplicadorTrizteza = 4 //Numero constante
	
	constructor(unSueldo,unaFelicidad) = super(unSueldo,unaFelicidad) 
	
	override method trabajar(unSim){
		unSim.darFelicidad(felicidad * multiplicadorTrizteza)
		unSim.darDinero(sueldo)
		unSim.personalidad().trabajar(self)
		
	}
}

class MercenarioSocial inherits Mercenario{
	
	constructor(unSueldo,unaFelicidad) = super(unSueldo,unaFelicidad)
	
	override method trabajar(unSim){
		super(unSim)
		unSim.darDinero(unSim.cantidadDeAmigos())
	}
}

object desocupado inherits Trabajo (0,0){
	
	override method trabajar(unSim){
		unSim.darFelicidad(felicidad)
		unSim.darDinero(sueldo)
		unSim.personalidad().trabajar(self)
	} //preguntar si es mejor hacerlo asi o hacer un override en cada trabajo que solo agregue volverALaNormalidad
}