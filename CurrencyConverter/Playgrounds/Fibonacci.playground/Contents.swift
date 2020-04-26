
//First Approach: recurisve Approach
func fibonacciRecurisve(_ number: Int) -> Int {
    guard number > 1 else { return number }
    return fibonacciRecurisve(number - 1) + fibonacciRecurisve(number - 2)
}

let recurisveValue = fibonacciRecurisve(10)


//Second Approach: Iterative Approach
func fibonacciIterative(_ number: Int) -> Int {
    guard number > 1 else { return number }

    var first = 1
    var second = 1
    for index in (2...number) {
//        var temp = first
//        first = first + second
//        second = temp
        (first,second) = (first+second,first)
    }
    return first
}
let iterativeValue = fibonacciIterative(10)






