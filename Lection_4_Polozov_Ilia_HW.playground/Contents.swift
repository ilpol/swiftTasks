import Foundation

// Lection 4 HW

var randomNumber: Int;
var randomArray: Array<Int> = [];
let randomNumberLength = 10
for _ in 0..<randomNumberLength {
    randomNumber = Int.random(in: 1..<10)
    randomArray.append(randomNumber)
}


// Первая реализация, в которой возвращается индекс ПЕРВОГО повторения
// Описание алгоритма
// Заносим в словарь индекс каждого элемента и перед занесением проверяем, если такой элемент уже есть, то значит он повторился, возвращаем его индекс из словаря

var randomDict = [Int : Int]()

func findOccurFromDict (array: Array<Int>) -> (Int, Int?) {
    for (index, randomN) in array.enumerated() {
        if (randomDict[randomN] == nil) {
            randomDict[randomN] = index
        } else {
            return (randomDict[randomN] ?? -1, randomN)
        }
    }
    return (-1, nil)
}

print("random array = ", randomArray)
var (occuringInd, occuringNum)  = findOccurFromDict(array: randomArray)
print("index of first occcurence of occuring number = ", occuringInd)
if let occuringNum = occuringNum {
    print("occuring number = ", occuringNum)
}


// Вторая реализация, в которой возвращается индекс ВТОРОГО повторения
// Описание алгоритма
// Каждый элемент добавляем во множество и сравниваем его размер с размером множества до добавления. Как только размер множества не увеличился - значит добавили уже повторившийся элемент - возвращаем его индекс

func findOccurFromSet (array: Array<Int>) -> (Int, Int?) {
    var randomSet: Set<Int> = Set<Int>()
    var prevSetSize: Int = 0
    for (index, randomN) in randomArray.enumerated() {
        randomSet.insert(randomN)
        if (randomSet.count == prevSetSize) {
            return (index, randomN)
        }
        prevSetSize = randomSet.count
    }
    return (-1, nil)
}

print("random array = ", randomArray)
(occuringInd, occuringNum)  = findOccurFromSet(array: randomArray)
print("index of second occcurence of occuring number = ", occuringInd)
if let occuringNum = occuringNum {
    print("occuring number = ", occuringNum)
}



