import Foundation
 
class Person  {
    var name = ""
    unowned var carIAmDrivingToday : Car?

    init(name: String = "") {
        self.name = name
    }

    deinit {
        print("Person \(self.name) deallocated!")
    }
}

class Car   {
    var owner:Person
    var modell = ""

    init(owner:Person,modell:String = "") {
        self.owner = owner
        self.modell = modell
    }
    
    deinit {
        print("Car deallocated!")
    }
}


// 1
var person : Person? = Person(name:"Max Mustermann") // retain count = 1

print("Person Retain count: \(CFGetRetainCount(person)-1)")

// 1a
  print("Person Retain count: \(CFGetRetainCount(Person(name:"Max Mustermann2"))-1)")

 

// 2
var car : Car?  = Car(owner: person!,modell:"VW Polo") // retain count von person : 2  und von car : 1

print("Person Retain count: \(CFGetRetainCount(person)-1)")
print("Car Retain count: \(CFGetRetainCount(car!)-1)")

// 3
person!.carIAmDrivingToday = car!   // retain count von car erhöht sich!  = 2

print("Person Retain count: \(CFGetRetainCount(person)-1)")
print("Car Retain count: \(CFGetRetainCount(car!)-1)")

// 4
var person2 : Person? = person  // retain count von person erhöht sich! = 3

print("Person Retain count: \(CFGetRetainCount(person)-1)")
print("Car Retain count: \(CFGetRetainCount(car!)-1)")

// 5
var car2 : Car? = person!.carIAmDrivingToday  // retain count von car erhöht sich! = 3

print("Person Retain count: \(CFGetRetainCount(person)-1)")
print("Car Retain count: \(CFGetRetainCount(car!)-1)")

// 6
func print(person:Person) {
    print("Person Retain count: \(CFGetRetainCount(person)-1)")
}

// retain count von perso erhöht sich, da wir über einen Funktionsaufruf
// eine weitere Referenz zu person hinzufügen  =>  4

print(person:person!)

// 7
// funktionsaufruf beendet, also geht der retain count von person um 1 zurück => 3
print("Person Retain count: \(CFGetRetainCount(person)-1)")

// 8
person2 = nil

// eine weitere Referenz weniger: => 2
print("Person Retain count: \(CFGetRetainCount(person)-1)")

// 9
person = nil
// die vorletzte Referenz geht verloren: => 1, da Person noch über car referenziert wird!

print("Person Retain count: \(CFGetRetainCount(car?.owner)-1)")
print("Car Retain count: \(CFGetRetainCount(car!)-1)")

// 10
car2 = nil

//print("Person Retain count: \(CFGetRetainCount(car?.owner)-1)")
print("Car Retain count: \(CFGetRetainCount(car!)-1)")

// 11
car = nil
// retain count vom VW Polo : 1, da wir noch über Max Mustermann den VW Polo referenziert haben
// retain count von Max Mustermann : 1, da wir noch über den VW Polo Max Mustermann referenziert haben
