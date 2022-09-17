import Foundation

// 6 Lecture HW

func sum2(first: Int, second: Int) -> Int {
    return first + second
}
print("func sum2: sum of 5 and 5 = ", sum2(first: 5,second: 5))


func toString(tupleParam : (Int, String)) -> Void {
    print("func toString: string of first item in tuple = ",String(tupleParam.0))
}
toString(tupleParam: (3, "3"))


func runClosure(detector: Int, closure: (() -> ())?) -> Void {
    if (detector > 0) {
        if let closure = closure {
            closure()
        }
    }
}
runClosure(detector: 5) {
    print("func runClosure: i am closure")
}
runClosure(detector: -2) {
   print("i am closure")
}


func isLeap(year: Int) -> Bool {
    return (year % 100 == 0) ? (year % 400 == 0) : (year % 4 == 0);
}
print("func isLeap: 2022 is leap? - ", isLeap(year: 2022))
print("func isLeap: 2012 is leap? - ", isLeap(year: 2012))
