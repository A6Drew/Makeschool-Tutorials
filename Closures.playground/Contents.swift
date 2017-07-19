//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var array = [1,2,3,4,5,6,7,8,9,10]


let descending  = { (first: Int, second: Int) -> Bool in
    return first > second

}

// $0 > $1 can be used as a replacement

let ascending = { (first: Int, second: Int) -> Bool in
    return second > first

}

// $1 > $0 can be used as a replacement

array.sorted(by: ascending)
array.sorted(by: descending)

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   