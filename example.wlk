// example.wlk
// example.wlk
// example.wlk
// example.wlk
// example.wlk
// example.wlk
// example.wlk
class Arma {
  method valorDeAtaque()
}

class ArmaDeFilo inherits Arma {
  var filo
  var longitud
  
  override method valorDeAtaque() = filo * longitud
  
  method filoActual() = filo
  
  method afilarArma() {
    filo += 1
  }
  
  method desafilarArma() {
    filo = (filo - 1).max(0)
  }
  
  method longitudActual() = longitud
  
  method extenderArma() {
    longitud += 1
  }
  
  method acortarArma() {
    longitud = (longitud - 1).max(0)
  }
}

class ArmaContundente inherits Arma {
  var peso
  
  override method valorDeAtaque() = peso
  
  method aumentarPeso() {
    peso += 1
  }
  
  method disminuirPeso() {
    peso = (peso - 1).max(0)
  }
}

object cascos {
  method puntos(luchador) = 10
}

object escudos {
  method puntos(luchador) = 5 + (luchador.destreza() * 0.1)
}

class Gladiador {
  
  var vida = 100
  
  method atacarA(gladiadorAtacado)
  
  method aumentarVida(unValor) {
    vida += unValor
  }
  
  method perderVida(unValor) {
    vida = (vida - unValor).max(0)
  }
  
  method vidaActual() = vida
  
  method valorDeAtaqueDelGladiador()
  
  method defensaTotal()
  
  method fuerzaActual()
  
  method destreza()
  
  method armasActualmente()
  
  method defensa()
  
  method atacarAUn(gladiadorAtacado) {
    const danio = self.atacarA(gladiadorAtacado)
    gladiadorAtacado.perderVida(danio)
  }

}

class Mirmillon inherits Gladiador {
  var armaEnMano
  var fuerza
  var casco
  var escudo
  
  override method destreza() = 15
  
  method aumentarFuerza() {
    fuerza += 1
  }
  
  override method armasActualmente() = armaEnMano.asList()
  
  method cambiarArmaEnMano(nuevaArma) {
    armaEnMano = nuevaArma
  }
  
  method disminuirFuerza() {
    fuerza = (fuerza - 1).max(0)
  }
  
  override method fuerzaActual() = fuerza
  
  override method defensaTotal() = self.puntosDelCasco() + self.puntosDelEscudo()
  
  method puntosDelCasco() = casco.puntos(self)
  
  method puntosDelEscudo() = escudo.puntos(self)
  
  method cambiarArmadura(nuevoCasco, nuevoEscudo) {
    self.cambiarCasco(nuevoCasco)
    self.cambiarEscudo(nuevoEscudo)
  }
  
  method cambiarCasco(nuevoCasco) {
    casco = nuevoCasco
  }
  
  method cambiarEscudo(nuevoEscudo) {
    escudo = nuevoEscudo
  }
  
  override method valorDeAtaqueDelGladiador() = armaEnMano.valorDeAtaque()
  
  override method atacarA(
    gladiadorAtacado
  ) = ((self.valorDeAtaqueDelGladiador() + self.fuerzaActual()) - gladiadorAtacado.defensaTotal()).max(
    0
  )
  
  method puntosDeArmadura() = self.puntosDelCasco() + self.puntosDelEscudo()
  
  override method defensa() = self.puntosDeArmadura() + self.destreza()
}

class Dimachaerus inherits Gladiador {
  var destreza
  const armas = []
  
  override method fuerzaActual() = 10
  
  override method destreza() = destreza
  
  method agregarUnArma(unArma) {
    armas.add(unArma)
  }
  
  method quitarUnArma(unArma) {
    armas.remove(unArma)
  }
  
  method sacarTodasLasArmas() {
    armas.clear()
  }
  
  override method armasActualmente() = armas
  
  override method valorDeAtaqueDelGladiador() = armas.sum(
    { a => a.valorDeAtaque() }
  )
  
  override method defensaTotal() = self.destreza() / 2
  
  method sumatoriaDelDanio() = self.fuerzaActual() + self.armasActualmente().sum(
    { a => a.valorDeAtaque() }
  )
  
  override method atacarA(gladiadorAtacado) {
    self.ataqueDe()
    return (self.sumatoriaDelDanio() - gladiadorAtacado.defensaTotal()).max(0)
  }
  
  method ataqueDe() {
    destreza += 1
  }
  
  override method defensa() = self.destreza() / 2
}

class Grupo {
  var property nombre
  const property miembros = []
  var property peleasParticipadas = 0
  
  method agregarGladiador(unGladiador) {
    miembros.add(unGladiador)
  }
  
  method quitarGladiador(unGladiador) {
    miembros.remove(unGladiador)
  }
  
  method registrarPelea() {
    peleasParticipadas += 1
  }
  
  method campeon() = miembros.filter({ g => g.vidaActual() > 0 }).max(
    { g => g.valorDeAtaqueDelGladiador() + g.fuerzaActual() }
  )
}
