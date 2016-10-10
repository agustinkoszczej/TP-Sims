import Personalidades.*
import Relaciones.*
import Trabajos.*
import EstadosDeAnimo.*
import Celos.*
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
	var relacion = new Relacion(self, self)
	
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
		return relacion
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
	
	method abrazar(unSim, duracion) {
		
	//Abrazo Comun
	if(duracion <= 2){ 
		self.darFelicidad(2)
		unSim.darFelicidad(4)
		}
		
	//Abrazo Prolongado
		else{
		if (unSim.leAtrae(self))
			{
				unSim.darEstadoDeAnimo(soniador)
			}
		else {
			unSim.darEstadoDeAnimo(incomodo)
		}
		}
		
	
	}
	
	// RELACIONES (PAREJAS)
	
	
	method empezarRelacionCon(unSim){
		relacion = new Relacion(self, unSim)
		unSim.relacion(relacion)
	}
	
	
	method terminarRelacion(){
		var pareja = self.pareja()
		self.pareja().relacion(new Relacion(pareja, pareja))
		relacion = new Relacion(self, self)
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
		if ((personalidad === buenazo) && (self.trabajaConTodosSusAmigos())){
			self.darFelicidad(nivelFelicidad * 0.1)
		}
	}
	
	// ATRACCIONES
	
	method joven(){
		return (edad >= 18 && edad <= 29)
	}
	
	method triste(){
		return (nivelFelicidad < 200)
	}
	
	method leAtrae(otroSim){ 
		if(otroSim.sexo() == preferencia)
		{	
			return personalidad.leAtraen(self, otroSim)
		}
		else{ 
			return false
		}
	}
	
	// INFORMACION Y CONOCIMIENTOS
	
	method contarInformacionA(info, unSim){
		unSim.conocimientos(info)
	}
	
	method conocimientos(info){ // Setter Conocimientos
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
	
	method ataqueDeCelos(tipoDeCelos)
	{
		self.darFelicidad(-10)
		tipoDeCelos.ataque(self)
	}
	
	// VARIOS
	
	method darDinero(cantidad){
		dinero += cantidad
	}
	
	method darFelicidad(cantidad){
		nivelFelicidad += cantidad
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
	
	method leAtraenDeLaLista(listaDeSims){
		return listaDeSims.filter({sim => self.leAtrae(sim)})
	}	
}

// Comentario de prueba