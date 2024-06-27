
class Habitante {

	const inteligencia
	const valentia
	
	method poder() {
		return valentia + inteligencia
	}

}


class Planeta {

	const habitantes = []

	method poder() = habitantes.sum{h=>h.poder()}

	method poseeOrden() = self.habitantesMasPoderosos().sum{h=>h.poder()} > self.poder()/2

	method habitantesMasPoderosos() = 
		habitantes.sortedBy({a, b => a.poder() > b.poder()}).take(3)
}
class Soldado inherits Habitante{

	const armas = []

	method agarrarArma(nueva){
		armas.add(nueva)
	}
	override method poder() = super() + self.potenciaArmas()

	method potenciaArmas() = armas.filter{a=>a.util()}.sum{a=>a.potencia()}
}
class Sable {
	var property energia
}

class Maestro inherits Soldado{

	var midiclorianos = 3000
	var sable
	var property lado
	var property tiempo

	var interior = 1
	

	override method poder() = super() + midiclorianos/1000 + lado.potenciaDel(sable,tiempo)

	method vivirSuceso(suceso){
		tiempo += 1
			lado.haceVivirSuceso(suceso,self)
	}
	method cambiarLado() {
	   tiempo = 0
	   lado = lado.opuesto()
	   armas.forEach({a=>a.reparar()})
	} 

	method interior() = interior
	method aumentarInterior(cant) {
		interior += cant
	}
	method aumentarPorcentaje(porc){
		interior = interior * (1 + porc/100)
	}
}

object ladoLuz{
    method potenciaDel(sable,tiempo) = sable.energia() * tiempo

	method haceVivirSuceso(suceso,maestro){
		maestro.aumentarInterior(suceso.cargaEmocional())
		if(maestro.interior()<=0){
			maestro.cambiarLado() 
		}
	}
	method opuesto() = ladoOscuro
}
object ladoOscuro{
    method potenciaDel(sable,tiempo) = sable.energia() * 2 * tiempo

	method haceVivirSuceso(suceso,maestro){
		if(	maestro.interior() < suceso.cargaEmocional()) {
			maestro.cambiarLado()
		}
		else{
			maestro.aumentarPorcentaje(10) 
		}
	}
	method opuesto() = ladoLuz

}

class Suceso{

	var property cargaEmocional


}

class Arma{

    const property potencia
	var desgaste = false

	method util() = not desgaste and potencia > 10

	method usar() {
		desgaste = true
	}
	method reparar(){
		desgaste = false
	}

}