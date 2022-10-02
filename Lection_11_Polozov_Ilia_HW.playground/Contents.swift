import Foundation

// 11 Lecture HW

class Animal {
    public var name: String

    internal var bodyTemperature: Int
    public var isHapy: Bool  = true

    public func produceVoice() -> String {
        return ""
    }
    
    init() {
        name = "Animal"
        bodyTemperature = 36
    }
    
    init(animalName: String, animalBodyTemperature: Int) {
        name = animalName
        bodyTemperature = animalBodyTemperature
    }
}

class Cat: Animal  {
    override func produceVoice()-> String {
        return "Meow"
    }

    override public var isHapy: Bool {
        get {
            return bodyTemperature < 30 && bodyTemperature > 20
        }
        set {
             newValue
        }
    }
    
    
    override init(animalName: String, animalBodyTemperature: Int) {
        super.init(animalName: animalName, animalBodyTemperature: animalBodyTemperature)
    }
}

class Dog: Animal {
    
    private var hightLevelOfEndorphin: Bool;
    
    public func feedTastyFood() -> Void {
        hightLevelOfEndorphin = true
    }
    
    public func feedTastelessFood() -> Void {
        hightLevelOfEndorphin = false
    }
    
    fileprivate func printLevelOfEndorphin() -> Void {
        if (hightLevelOfEndorphin) {
            print(super.name + " has hight level of endorphin")
        } else {
            print(super.name + "low level of endorphin")
        }
    }
    
    
    public var isVeryHapy: Bool {
        return hightLevelOfEndorphin
    }
    
    override func produceVoice()-> String {
        return "Gaf"
    }

    override public var isHapy: Bool {
        get {
            return bodyTemperature < 35 && bodyTemperature > 25
        }
        set {
             newValue
        }
    }
    
    override init(animalName: String, animalBodyTemperature: Int) {
        self.hightLevelOfEndorphin = false
        super.init(animalName: animalName, animalBodyTemperature: animalBodyTemperature)
    }
}

let chappy = Dog(animalName: "Chappy", animalBodyTemperature: 30)
let vasya = Cat(animalName: "Vasya", animalBodyTemperature: 30)

// пример полиморфизма
print("Polymorthism example:")
let arrayOfAnimals = [chappy, vasya]
for anymal in arrayOfAnimals {
    print(anymal.produceVoice())
}

print("")

print("Is Chappy happy? - ", chappy.isHapy ? "yes" : "no")
print("Is Chappy very happy? - ", chappy.isVeryHapy ? "yes" : "no", "\n")

print("Let's feed Chappy")
chappy.feedTastyFood()
print("Is Chappy now very happy? - ", chappy.isVeryHapy ? "yes" : "no", "\n")

print("why Chappy is Happy?")
chappy.printLevelOfEndorphin()

