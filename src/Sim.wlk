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
	var estadoDeAnimo = null
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
	
	
	//+----------------+
	//| Inicio Getters |
	//+----------------+
	
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
	
	//+-------------+
	//| Fin Getters |
	//+-------------+
	
	//---------------------------------------------------------------
	
	//+------------------+
	//| Inicio Amistades |
	//+------------------+
	
	
	method hacerseAmigoDe (unSim){
		if(not amigos.contains(unSim)){
			amigos.add(unSim)
			nivelFelicidad += self.valorarSim(unSim)
		}
	}
	
	method hacerseAmigosMutuamente(unSim){
		self.hacerseAmigoDe(unSim)
		unSim.hacerseAmigoDe(self)
	}
	
	//+---------------+
	//| Fin Amistades |
	//+---------------+
	
	//---------------------------------------------------------------
	
	//+--------------------+
	//| Inicio Popularidad |
	//+--------------------+
	
	method nivelPopularidad (){
		return amigos.sum({unSim => unSim.nivelFelicidad()})
	}
	
	//+-----------------+
	//| Fin Popularidad |
	//+-----------------+
	
	//---------------------------------------------------------------
	
	//+-------------------+
	//| Inicio Valoracion |
	//+-------------------+
	
	method valorarSim(simValorado){
		return personalidad.valorarPersonalidad(self, simValorado)
	}
	
	//+----------------+
	//| Fin Valoracion |
	//+----------------+
		
	//---------------------------------------------------------------
	
	//+----------------+
	//| Inicio Abrazos |
	//+----------------+
	
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
	
	//+-------------+
	//| Fin Abrazos |
	//+-------------+
	
	//---------------------------------------------------------------
	
	//+-----------------------------+
	//| Inicio Relaciones (Parejas) |
	//+-----------------------------+
	
	
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
	
	//+--------------------------+
	//| Fin Relaciones (Parejas) |
	//+--------------------------+
	
	//---------------------------------------------------------------
	
	//+-------------------------+
	//| Inicio Dinero y Trabajo |
	//+-------------------------+
	
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
	
	//+----------------------+
	//| Fin Dinero y Trabajo |
	//+----------------------+
	
	
	//---------------------------------------------------------------
	
	//+--------------------+
	//| Inicio Atracciones |
	//+--------------------+
	
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
	
	//+-----------------+
	//| Fin Atracciones |
	//+-----------------+
		
	//---------------------------------------------------------------
	
	//+------------------------------------+
	//| Inicio Informacion y Conocimientos |
	//+------------------------------------+
	
	method contarInfoA(info, unSim){
		unSim.recibirInfo(info)
	}
	
	method recibirInfo(info){
		if(not self.conoce(info))
		{
			conocimientos.add(info)
		}
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
		conocimientos.clear() // preguntar si hay que hacer una variable auxiliar en caso de recuperar los conocimientos
	}
	
	//+---------------------------------+
	//| Fin Informacion y Conocimientos |
	//+---------------------------------+
	
	//---------------------------------------------------------------
	
	//+-------------------------+
	//| Inicio Estados de Animo |
	//+-------------------------+
	
	method darEstadoDeAnimo(estado){
		if (estadoDeAnimo != null){
			estadoDeAnimo = normal
		}
		else{
			estadoDeAnimo = estado
			estado.efectuar(self)	
		}	
	}
	
	//---------------------------------------------------------------
	
	//+---------------------+
	//| Fin Estados de Animo|
	//+---------------------+
	
	//---------------------------------------------------------------
	
	//+-------------------------+
	//| Inicio Ataques de Celos |
	//+-------------------------+
	
	method filtrarAmigos(criterio){
		amigos = amigos.filter(criterio)
	}
	
	method ataqueDeCelos(tipoDeCelos)
	{
		self.darFelicidad(-10)
		tipoDeCelos.ataque(self)
	}
	
	//+---------------------+
	//| Fin Ataques de Celos|
	//+---------------------+
	
	//---------------------------------------------------------------
	
	//+---------------+
	//| Inicio Varios |
	//+---------------+
	
	method darDinero(cantidad){
		dinero += cantidad
	}
	
	method darFelicidad(cantidad){
		nivelFelicidad += cantidad
	}
	
	//+------------+
	//| Fin Varios |
	//+------------+
	
	//---------------------------------------------------------------
	
	//+-----------------------+
	//| Inicio Requerimientos |
	//+-----------------------+
	
	
	method amigoMasValorado(){
		if(amigos.isEmpty()){
			return null
		}
		else {
			return amigos.max({unSim => self.valorarSim(unSim)})
		}		
	}
	
	method esAmigoDe(otroSim){
		return amigos.contains(otroSim)
	}
	
	method amigoMasPopular(){
		return amigos.max({unSim => unSim.nivelPopularidad()})
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
	
	//+--------------------+
	//| Fin Requerimientos |
	//+--------------------+
	
	//---------------------------------------------------------------
	
}