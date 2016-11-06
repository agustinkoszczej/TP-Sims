import Personalidades.*
import Relaciones.*
import Trabajos.*
import EstadosDeAnimo.*
import Celos.*
import FuentesDeInformacion.*

class Sim {
	var sexo
	var edad
	var nivelFelicidad
	var amigos = []
	var dinero
	var personalidad
	var trabajo = desocupado
	var preferencia
	var conocimientos = #{}
	var estadoDeAnimo = normal
	var relacion = soltero
	var fuentesDeInformacion = []
	
	constructor (unSexo, unaEdad, unNivelDeFelicidad, unosAmigos, unaPersonalidad, unDinero, unaPreferencia){
		sexo = unSexo
		edad = unaEdad
		nivelFelicidad = unNivelDeFelicidad
		amigos = unosAmigos
		personalidad = unaPersonalidad
		dinero = unDinero
		preferencia = unaPreferencia
	}
	
	
	//GETTERS 
	
	method sexo (){
		return sexo
	}
	method edad (){
		return edad
	}
	method nivelFelicidad(){
		return nivelFelicidad
	}
	method amigos (){
		return amigos
	}
	method dinero (){
		return dinero
	}
	method personalidad (){
		return personalidad
	}
	method trabajo(){
		return trabajo
	}
	method preferencia(){
		return preferencia
	}
	method conocimientos(){
		return conocimientos
	}
	method estadoDeAnimo(){
		return estadoDeAnimo
	}
	method relacion(){
		return relacion.mismo()
	}
	
	method soltero(){
		return relacion === soltero
	}
	
	method edad(nvaEdad){
		edad = nvaEdad
	}
	
	// AMISTADES
	
	
	method hacerseAmigoDe (unSim){
		if(not self.esAmigoDe(unSim)){
			amigos.add(unSim)
			nivelFelicidad += self.valorarSim(unSim)
		}
	}
	
	method hacerseAmigosMutuamente(unSim){
		self.hacerseAmigoDe(unSim)
		unSim.hacerseAmigoDe(self)
	}
	
	// POPULARIDAD 
	
	method nivelPopularidad (){
		return amigos.sum({unSim => unSim.nivelFelicidad()})
	}
	
	// VALORACION
	
	method valorarSim(simValorado){
		return personalidad.valorarPersonalidad(self, simValorado)
	}
	
	// ABRAZOS
	
	method abrazar(unSim, tipo) {	
	tipo.abrazar(self, unSim)
	}
	
	// RELACIONES (PAREJAS)
	
	
	method empezarRelacionCon(unSim){
		var posibleRelacion =  new Relacion(self, unSim) //hecho asi para que el constructor de Relacion vea si es posible crearla
		relacion = posibleRelacion
		unSim.relacion(relacion)
	}
	
	method terminarRelacion(){
		relacion = soltero
	}
	
	method relacion(unaRelacion){
		relacion = unaRelacion
	}
	
	method pareja(){
		
		if(relacion.unSim() == self){
			return relacion.otroSim()
		}
		else
		{
			return relacion.unSim()
		}
	}
	
	// DINERO Y TRABAJO
	
	method asignarTrabajoCopado(sueldo, felicidad){
		trabajo = new Copado (sueldo, felicidad)
	}
	
	method asignarTrabajoMercenario (){
		trabajo = new Mercenario()
	}
	
	method asignarTrabajoAburrido (sueldo, felicidad){
		trabajo = new Aburrido (sueldo, felicidad)
	}
	
	method asignarTrabajoAburridoHastaLaMuerte (sueldo, felicidad){
		trabajo = new AburridoHastaLaMuerte (sueldo, felicidad)
	}
	
	method asignarTrabajoMercenarioSocial(){
		trabajo = new MercenarioSocial()
	}
	
	method quedarDesempleado (){
		trabajo = desocupado
	}
	
	method trabajaConTodosSusAmigos (){
		return amigos.all({unSim => unSim.trabajo() === self.trabajo()})
	}
	
	method trabajar(){
		trabajo.trabajar(self)
	}
	
	// ATRACCIONES
	
	method joven(){
		return (edad >= 18 && edad <= 29)
	}
	
	method triste(){
		return (nivelFelicidad < 200)
	}
	
	method leAtrae(otroSim){ 
		return otroSim.sexo() == preferencia && personalidad.leAtrae(self, otroSim)
	}
	
	method duplicaMiFortuna(unSim)
	{
		return unSim.dinero() >= (dinero*2)
	}
	
	// INFORMACION Y CONOCIMIENTOS
	
	method contarInformacionA(unSim, info){
		unSim.aprender(info)
	}
	
	method conocimientos(nvosConocimientos){ // Setter Conocimientos
		conocimientos = nvosConocimientos
	}
	
	method aprender(info){ 
			conocimientos.add(info)
	}
	
	method conoce(info)
	{
		return conocimientos.contains(info)
	}
	
	method nivelDeConocimiento()
	{
		return self.conocimientos().sum({saber => saber.length()})
	}
	
	method amnesia(){
		conocimientos.clear()
	}
	
	// ESTADOS DE ANIMO
	
	method sentirse(estado){
			estadoDeAnimo = estado
			estado.efectuar(self)		
	}
	method volverALaNormalidad(){
		estadoDeAnimo = normal
	} 
	
	// atacarS DE CELOS
	
	method filtrarAmigos(criterio){
		amigos = amigos.filter(criterio)
	}
	
	method ponerseCeloso(tipoDeCelos)
	{
		self.darFelicidad(-10)
		tipoDeCelos.atacar(self)
	}
	
	//PRESTAMOS
	
	method prestarDinero(unSim, cantidadDinero){
		if (not self.puedePrestar(unSim, cantidadDinero)){
			self.error("Este sim no puede prestar esa cantidad")
		}		
		unSim.recibirDinero(cantidadDinero)
		self.gastarDinero(cantidadDinero)
	}

	method puedePrestar(otroSim, unaCantidadDeDinero){
		return ((unaCantidadDeDinero <= dinero) && (unaCantidadDeDinero <= self.dineroQueQuierePrestar(otroSim)))
	}
	
	method dineroQueQuierePrestar(otroSim){
		return personalidad.maximoPrestamo(self, otroSim)
	}
	
	method gastarDinero(cantidad){
		dinero -= cantidad
	}
	
	//DIFUSION, PRIVACIDAD Y CHISMES
	
	method difundirInformacion(info){
		if (not self.conoce(info)){
			amigos.forEach({amigo => self.contarInformacionA(amigo, info)})
		}
		self.aprender(info)
	}

	method esConocimientoSecreto(info){
		return not (amigos.any({amigo => amigo.conoce(info)}))
	}

	method desparramarChisme(unSim){
		self.difundirInformacion(self.unChismeDe(unSim))
	}
	method unChismeDe(unSim){
		return (unSim.conocimientos().filter({info => unSim.esConocimientoSecreto(info)}).anyOne())
	}
	
	//FUENTES DE INFORMACION
	
	method brindarInformacion(){
		return self.unChismeDe(amigos.anyOne())
	}
	
	method informarse(){  
		conocimientos.addAll(fuentesDeInformacion.map({fuente => fuente.brindarInformacion()}))
	}
	
	method fuentesDeInformacion(unasFuentes){ //setter
		fuentesDeInformacion = unasFuentes
	}
	
	// VARIOS
	
	method recibirDinero(cantidad){
		dinero += cantidad
	}
	
	method darFelicidad(cantidad){
		nivelFelicidad += cantidad
	}

	method cantidadDeAmigos(){
		return amigos.size()
	}
	
	method menor(){
		return edad <= 16
	}
	
	method dineroDeAmigos(){
		return amigos.sum({amigo=> amigo.dinero()})
	}
	
	// REQUERIMIENTOS
	
	
	method amigoMasValorado(){
		if(amigos.isEmpty()){
			self.error("No tengo amigos :(")
		}
			return amigos.max({unSim => self.valorarSim(unSim)})		
	}
	
	method esAmigoDe(otroSim){
		return amigos.contains(otroSim)
	}
	
	method amigoMasPopular(){
		if(amigos.isEmpty()){
			self.error("No tengo amigos :(")
		}
			return amigos.max({unSim => unSim.nivelPopularidad()})
	}
	
	method esElMasPopular(){
		return self.nivelPopularidad() > self.amigoMasPopular().nivelPopularidad()
	}
	
	method amigosMasNuevos(cantidad){
		return amigos.reverse().take(cantidad)
	}
	
	method amigosMasViejos(cantidad){
		return amigos.take(cantidad)
	}
	
	method quienesLeAtraen(listaDeSims){
		return listaDeSims.filter({sim => self.leAtrae(sim)})
	}	
	
	method cumplirAnios(){
		edad++
	}
}
