import Foundation

// 14 Lecture HW

func functWithFuncParameter (function: (String) -> Void) -> Void {
    function("functWithFuncParameter calls function parameter")
}
functWithFuncParameter() {(arg: String) -> Void in
    print(arg)
}

func funcWithSeveralClosures(closure1: (String) -> Void, closure2: (String)-> Void) {
    closure1("funcWithSeveralClosures calls closure1")
    closure2("funcWithSeveralClosures calls closure2")
}
funcWithSeveralClosures(
    closure1: {(arg: String) -> Void in
        print(arg)
    },
    closure2: {(arg: String) -> Void in
        print(arg)
    }
)

func functWithAutoClosure (function: @autoclosure () -> Void) -> Void {
    function()
}
functWithAutoClosure(function: print("autoClosure"))

func funcWithInnerFunc() {
  func funcInner() {
    print("funcInner")
  }
  funcInner()
}
funcWithInnerFunc()


func funcGeneric<T: Comparable>(first: T, second: T) -> T {
    if first < second {
        return first
    }
    return second
}

let str1 = "abc"
let str2 = "def"

let maxString = funcGeneric(first: str1, second: str2)
print("maxString = ", maxString)

let num1 = 12
let num2 = 19

let maNumber = funcGeneric(first: num1, second: num2)
print("maNumber = ", maNumber)
