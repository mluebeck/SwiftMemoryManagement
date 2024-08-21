//
//  MemoryManagementTestTests.swift
//  MemoryManagementTestTests
//
//  Created by Mario Rotz on 16.07.24.
//

import XCTest
import Foundation
 
class Car {
    var currentDriver:Person
    var identifier : String = UUID().uuidString
    init(owner:Person) {
        self.currentDriver = owner
    }
}
 

class Person {
    var carIAmDriving : Car?
    var name = "John Doe"
    init(carIAmDriving: Car? = nil) {
        self.carIAmDriving = carIAmDriving
    }
}
 
final class MemoryManagementTestTests: XCTestCase {

    func test_createAPersonWithACar() throws {
        let person = Person()
        let car = Car(owner:person)
        person.carIAmDriving = car
        //trackForMemoryLeaks(person)
        XCTAssert( car.currentDriver.name=="John Doe", "The Person is John Doe")
    }

    private func trackForMemoryLeaks(_ instance:AnyObject, file:StaticString = #file, line:UInt=#line) {
        addTeardownBlock {[weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential Memory leak",file:file,line: line)
        }
    }
}
