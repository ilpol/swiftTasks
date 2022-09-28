import Foundation

// 13 Lecture HW

class Stack<T> {
    
    private var data: [T] = []

    func push(_ item:T) {
        data.append(item)
    }
    
    func pop() -> T? {
        return data.popLast()
    }
    
    func peek() -> T? {
        return data.last
    }
    
    func isEmpty() -> Bool {
        return data.isEmpty
    }
    
    func clear() -> Void {
        data = []
    }
}

class Queue<T> {
    
    private var data: [T] = []

    func push(_ item:T) {
        data.insert(item, at: 0)
    }
    
    func pop() -> T? {
        return data.popLast()
    }
    
    func peek() -> T? {
        return data.last
    }
    
    func isEmpty() -> Bool {
        return data.isEmpty
    }
    
    func clear() -> Void {
        data = []
    }
}

class Deque<T> {
    
    private var data: [T] = []
    
    func pushBack(_ item:T) {
        data.append(item)
    }

    func pushFront(_ item:T) {
        data.insert(item, at: 0)
    }
    
    func peekBack() -> T? {
        return data.last
    }
    
    func peekFront() -> T? {
        return data.first
    }
    
    func popBack() -> T? {
        return data.popLast()
    }
    
    func popFront() -> T? {
        return data.remove(at: 0)
    }
    
    func isEmpty() -> Bool {
        return data.isEmpty
    }
    
    func clear() -> Void {
        data = []
    }
}

var stack = Stack<Int>()

stack.push(15)
stack.push(23)
stack.push(26)
print("stack.pop = ", stack.pop() ?? "")
print("stack.peek = ", stack.peek() ?? "")
print("stack.pop = ", stack.pop() ?? "")

stack.clear()
print("stack.pop = ", stack.pop() ?? "")

print("stack.isEmpty = ", stack.isEmpty())
print("")


var queue = Queue<String>()

queue.push("123")
queue.push("456")
queue.push("789")

print("queue.pop = ", queue.pop() ?? "")
print("queue.peek = ", queue.peek() ?? "")
print("queue.pop = ", queue.pop() ?? "")

queue.clear()
print("queue.pop = ", queue.pop() ?? "")

print("queue.isEmpty = ", queue.isEmpty())
print("")


var deque = Deque<Double>()

deque.pushFront(12.5)
deque.pushFront(15.8)
deque.pushFront(25.7)

print("deque.popBack = ", deque.popBack() ?? "")
print("deque.peekBack = ", deque.peekBack() ?? "")
print("deque.popBack = ", deque.popBack() ?? "")

deque.pushBack(16.4)
deque.pushBack(18.2)
deque.pushBack(9.7)

print("deque.popFront = ", deque.popFront() ?? "")
print("deque.peekFront = ", deque.peekFront() ?? "")
print("deque.popFront = ", deque.popFront() ?? "")

deque.clear()
print("deque.popBack = ", deque.popBack() ?? "")

print("deque.isEmpty = ", deque.isEmpty())

