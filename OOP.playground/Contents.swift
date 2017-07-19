////: Playground - noun: a place where people can play
//
//import UIKit
//
//var str = "Hello, playground"
//
//func addNUmbers(one: Double, two: Double) -> Int {
//    let sum = Int(one + two)
//    return (sum)
//    
//}
//
//print(addNUmbers(one: 1.5, two: 2.6))


class Person {
    
    var firstName: String
    var middleName: String?
    var lastName: String
    var fullName: String{
        if let middleName = middleName {
            return "\(firstName) \(middleName) \(lastName)"
        }
            else {
                return "\(firstName) \(lastName)"
            }
        
        }
    
    
    init(firstName: String, middleName: String?, lastName: String) {
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
    }
   
    convenience init(firstName: String, lastName: String) {
        self.init(firstName: firstName, middleName: nil, lastName: lastName)
    }
    
    func doStuff() {
       print("\(fullName) does stuff")
    }

}

class makeSchoolPerson: Person {
    var track: String
    
    init(firstName: String, middleName: String?, lastName: String, track: String) {
        self.track = track
        super.init(firstName: firstName, middleName: middleName, lastName: lastName)
        
    }
}

class makeSchoolInstructor: makeSchoolPerson {
   override func doStuff() {
        print("\(fullName) is teaching the \(track) track")
    }
}

class makeSchoolStudent: makeSchoolPerson {
    
    override func doStuff() {
        print("\(fullName) is learning the \(track) track")
    }
    
}

let instructor = makeSchoolInstructor(firstName: "Dion", middleName: "NL", lastName: "Larson", track: "Intro")
    
let student1 = makeSchoolStudent(firstName: "Alex", middleName: nil, lastName: "Cubs", track: "Games")

let student2 = makeSchoolStudent(firstName: "Zoey", middleName: nil, lastName: "Dames", track: "Apps")

//instructor.doStuff()
//student1.doStuff()
//student2.doStuff()

let randomPerson = Person(firstName: "J", lastName: "Doe")

let people: [Person] = [instructor, student1, student2, randomPerson]

for person in people {
 person.doStuff()
}


