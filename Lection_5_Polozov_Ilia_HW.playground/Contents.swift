import Foundation

// 1 task

var arrNumbers: Array<Int> = [1,5,3,6,2,6,4,4]
var maxNumber: Int  = arrNumbers[0]
var maxNumberIndex: Int = 0

var minNumber: Int = arrNumbers[0]
var minNumberIndex: Int = 0

for (index, number) in arrNumbers.enumerated() {
    if (number > maxNumber) {
        maxNumber = number
        maxNumberIndex = index
    }
    if (number < minNumber) {
        minNumber = number
        minNumberIndex = index
    }
}

print("1 task")
print("original array = ", arrNumbers)
arrNumbers[maxNumberIndex] = minNumber
arrNumbers[minNumberIndex] = maxNumber
print("mutated array = ", arrNumbers)
print("\n")


// 2 task

let arrFirst: Array<Int>  = [1,6,3,7]
let arrSecond: Array<Int>  = [4,23,12,4,6,7,32]

let firstSet: Set<Int>  = Set(arrFirst)
let secondSet: Set<Int> = Set(arrSecond)

let resultSet =  firstSet.intersection(secondSet)
print

print("2 task")
print("first array = ", arrFirst)
print("second array = ", arrSecond)
print("resultSet = ", resultSet)
print("\n")


// 3 task

let userPasswords: Dictionary<String, String> = [
    "Алексей": "ferwrwfds",
    "Марина": "bvbbcv",
    "Елизавета": "eggefggere",
    "Николай": "nthrtbhrtr",
    "Анастасия": "gergtrehtrbfdbdfbdb",
    "Василий": "weqeqwewq",
    "Василиса": "xczczxczcxzcbbdfbfdbfbfdb",
    "Андрей": "fwerfwew",
]

var safeUsers: Array<String> = []
let safetyThreshold = 10
for (user, password) in userPasswords {
    if (password.count > safetyThreshold) {
        safeUsers.append(user)
    }
}

print("3 task")
print("users with password longer then 10 = ", safeUsers)
