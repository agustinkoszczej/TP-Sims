import Sim.*

class Trabajo {
	var sueldo
	var felicidad
	
	constructor (unSueldo, unaFelicidad){
		sueldo = unSueldo
		felicidad = unaFelicidad
	}
	
	method sueldo(unSim){
		return sueldo
	}
	
	method felicidad(unSim){
		return felicidad
	}
	
	
	method trabajar(unSim){
		unSim.darFelicidad(self.felicidad(unSim))
		unSim.darDinero(self.sueldo(unSim))
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
	
	method fijoMercenario(unSim){
		return 100 + unSim.dinero() / 50
	}
	
	override method sueldo(unSim){
		return self.fijoMercenario(unSim)
	}
}

class Aburrido inherits Trabajo{
	
	constructor (unSueldo, unaFelicidad) = super(unSueldo, unaFelicidad){
		sueldo = unSueldo
		felicidad = -unaFelicidad
	}	
}

class AburridoHastaLaMuerte inherits Aburrido{
	var factorTristeza = 4 //Numero constante
	
	constructor(unSueldo,unaFelicidad) = super(unSueldo,unaFelicidad){
		sueldo = unSueldo
		felicidad = -unaFelicidad
	}
	
	override method felicidad(unSim){
		return factorTristeza * felicidad 
	}
	
	
}

class MercenarioSocial inherits Mercenario{
	
	constructor (unSueldo, unaFelicidad) = super(unSueldo, unaFelicidad){
		sueldo = unSueldo
		felicidad = unaFelicidad
	}
	
	override method sueldo(unSim){
		return self.fijoMercenario(unSim) + (unSim.amigos()).size()
	}
}

object desocupado {
	
	method trabajar(unSim){
		/*unSim.darFelicidad(felicidad)
		unSim.darDinero(sueldo)*/
	} //preguntar si es mejor hacerlo asi o hacer un override en cada trabajo que solo agregue volverALaNormalidad
}