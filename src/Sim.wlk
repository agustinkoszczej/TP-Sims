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
	var relacion
	var soltero = true
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
		if(soltero){
			error.throwWithMessage("Este sim no esta en ninguna relacion")
		}		
		return relacion
	}
	
	method soltero(){
		return soltero
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
		unSim.soltero(false)
		soltero = false	

	}
	
	method terminarRelacion(){
		//self.pareja().soltero(true)
		soltero = true
	}
	
	method relacion(unaRelacion){
		relacion = unaRelacion
	}
	
	method soltero(boleano)
	{
		soltero = boleano
	}
	
	method pareja(){
		
		if(soltero){
			error.throwWithMessage("Este sim no tiene pareja")
		}	
		if(relacion.unSim() == self){
			return relacion.otroSim()
		}
		else
		{
			return relacion.unSim()
		}
	}
	
	// DINERO Y TRABAJO
	
	method asignarTrabajoCopado (sueldo, felicidad){
		trabajo = new Copado (sueldo, felicidad)
	}
	
	method asignarTrabajoMercenario (sueldo, felicidad){
		trabajo = new Mercenario (sueldo, felicidad)
	}
	
	method asignarTrabajoAburrido (sueldo, felicidad){
		trabajo = new Aburrido (sueldo, felicidad)
	}
	
	method quedarDesempleado (sueldo, felicidad){
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
	
	method cuanConocedorEs()
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
	
	// ATAQUES DE CELOS
	
	method filtrarAmigos(criterio){
		amigos = amigos.filter(criterio)
	}
	
	method ponerseCeloso(tipoDeCelos)
	{
		self.darFelicidad(-10)
		tipoDeCelos.ataque(self)
	}
	
	//PRESTAMOS
	
	method prestarA(unSim, cantidadDinero){
		if (self.puedePrestar(unSim, cantidadDinero)){
			unSim.darDinero(cantidadDinero)
			self.darDinero(-cantidadDinero)
		}
		else{
			self.error("No puedo prestarte :(")
		}
	}

	method puedePrestar(otroSim, unaCantidadDeDinero){
		return ((unaCantidadDeDinero <= dinero) && (unaCantidadDeDinero <= self.cuantoPrestaA(otroSim)))
	}
	
	method cuantoPrestaA(otroSim){
		return personalidad.cuantoPrestar(self, otroSim)
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
		//preguntar si se puede hacer asi con addall o hay que usar el metodo "aprender" en cada uno
	}
	
	method fuentesDeInformacion(unasFuentes){ //setter
		fuentesDeInformacion = unasFuentes
	}
	
	// VARIOS
	
	method darDinero(cantidad){
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
	
	method masPopularQueAmigos(){
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
