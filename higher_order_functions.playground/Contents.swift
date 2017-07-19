
import UIKit

/*:
 
 # Higher-Order Functions
 
 In Swift, functions are first-class citizens. One defining aspect of this, is the ability to pass a function in and out other functions.
 
 A higher-order function is a function either:
 
 1. takes a function as a parameter
 2. returns a function as a return type
 
 A function only needs one of these attributes to be a higher-order functions.
 
 Higher-order functions are popular because they can help us write clear, concise code. Some of the most common higher-order functions are:
 
 * **Map:** Transforms each element of a collection by applying the function argument to the element. The result of transformed elements are returned as a new collection.
 * **Filter:** Removes elements from a collection based on the condition specified by the function argument. The result is returned as a new collection.
 * **Reduce:** Applies the function argument to each element of a collection to create an new accumulated value.
 * **FlatMap (for optionals):** Iterates through each element and removes nil values from an optional array. Returns the result as a new collection of unwrapped optionals without any nil values.

 
 - Note: In each higher-order function above, the transformed result is returned as a new collection or value. The existing collection is never modified!
 
 There are many more higher-order functions, but we'll focus on these 4 to start. As you begin to master closures and using functions as first-class citizens, you can also create your own higher-order functions.
 */
/*:
 
 ## Map
 
 The `map` function requires a collection and takes another function as a parameter. It returns a new array which is the result of applying the function argument to each element of the original array.
 
 ### Map Example
 */
class User {
    let uid: Int
    let username: String
    
    init(uid: Int, username: String) {
        self.uid = uid
        self.username = username
    }
}

let followers = [User(uid: 0, username: "crazytaco557"),
                 User(uid: 1, username: "rainbowunicorn123"),
                 User(uid: 2, username: "dancingpanda")]

let followerUsernames = followers.map { (user: User) in
    return user.username
}

debugPrint(followerUsernames) // ["crazytaco557", "rainbowunicorn123", "dancingpanda"]
/*:
 
 In the example above, we transform each `User` element of the `followers` array into an `String` array of each user's username.
 
 * Callout(Cool Facts):
 If you were to compare the two arrays `followers` and `followerUsernames`, you could create a one-to-one correspondence, or **map**, for each element. Hence the name **map.**
 
 ### Transforming Collections without Map
 */
let numbers = [1, 3, 4, 9, 20]

var doubled = [Int]()
for n in numbers {
    doubled.append(n * 2)
}

print("doubled: \(doubled)") // [2, 6, 8, 18, 40]
/*:
 
 Additionally, we can use closure shorthand-syntax to make our code even more readable.
 
 ### Map with Shorthand Syntax
 */
let _doubled = numbers.map { $0 * 2 }
print("doubled: \(_doubled)") // [2, 6, 8, 18, 40]
/*:
 
  - Note: Also notice how when we use map, we can store our mapped elements as a constants rather than a variable. Whenever we can, we want to use constants because they'll help us reduce code complexity and bugs.
 
 ## Filter
 
 The `filter` function requires a collection and takes a function parameter that returns a `Bool`. It applies the function argument to each element, which returns either `true` or `false`. Finally, it returns a new collection which is the result of removing, or **filtering**, each element that returned `false`.
 
 ### Filter Example
 */
let currentUID = 3

let users = [User(uid: 3, username: "boiledegg"),
             User(uid: 4, username: "lostcoffee4"),
             User(uid: 5, username: "toastedbagel110")]

let usersExcludingCurrent = users.filter { (user: User) -> Bool in
    return user.uid != currentUID
}

for user in usersExcludingCurrent {
    print("uid: \(user.uid), username: \(user.username)")
}
/*:
 
 In the example above, we remove the current user from the user's array based on the UID to create a new array `usersExcludingCurrent`.
 
 ### Filtering Collections without Filter
 */
let names = ["Rachel", "Joy", "Jarvis", "Bruce", "Jessica"]

var namesStartingWithJ = [String]()
for name in names {
    if name.lowercased().hasPrefix("j") {
        namesStartingWithJ.append(name)
    }
}

print("names starting with J: \(namesStartingWithJ)") // ["Joy", "Jarvis", "Jessica"]
/*: 
 
 Next, let's see how `filter` can condense our code using closure shorthand syntax.
 
 ### Filter with Shorthand Syntax
 
 */
let _namesStartingWithJ = names.filter { $0.lowercased().hasPrefix("j") }
print("names starting with J: \(_namesStartingWithJ)") // ["Joy", "Jarvis", "Jessica"]
/*:
 
 ## Reduce
 
 The `reduce` function requires a collection. Its parameters include an initial accumulated value and function that returns a successive accumulated value. The function argument is applied to each element to calculate the final accumulated value.
 
 ### Reduce Example
 */
struct FidgetSpinner {
    let price: Double
}

let shoppingCart = [FidgetSpinner(price: 10.00),
                    FidgetSpinner(price: 13.00),
                    FidgetSpinner(price: 4.00),
                    FidgetSpinner(price: 750.00)]

let totalCost = shoppingCart.reduce(0.0) { (accumulated: Double, fidgetSpinner: FidgetSpinner) -> Double in
    return accumulated + fidgetSpinner.price
}

print("total: \(totalCost)") // 777.0
/*:
 
 The example above combines each of the chat member's usernames into a single `chatTitle` string. The `reduce` function takes two arguments:
 
 1. an empty string as an initial accumulated value
 2. a function argument that is applied to each element to create the successive accumulated value
 
 ### Reducing Collections without Reduce
 */
let rangeNumbers = Array(0...10_000)

var sum = 0
for number in rangeNumbers {
    sum += number
}

print("sum: \(sum)") // 50005000
/*: 
 
 Next, let's see how `reduce` can condense our code using closure shorthand syntax.
 
 ### Reduce with Shorthand Syntax
 
 */
let _sum = rangeNumbers.reduce(0, +)
print("_sum: \(_sum)") // 50005000
/*:
 
 - Note: Don't overdo it with shorthand syntax! We want to condense our code because brevity can make code more readable. If you find that using shorthand syntax is making your code harder to understand, use the formal closure syntax instead.
 
 ## FlatMap (for optionals)
 
 The `flatMap` function (for optionals) will remove all `nil` values from an optional array. It returns a new non-optional array which is the result of unwrapping and removing all `nil` values.
 
 - Note: FlatMap has two different use cases, one for flattening arrays and the other for removing `nil` values from optional arrays. We're focusing on the optional use case because it's more common.
 
 ### FlatMap Example
 
 */
class Artist {
    let id: Int
    let username: String
    
    // Failable initializer returns nil if json contains invalid or insufficient
    // data for initializing Artist object.
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let username = json["username"] as? String
            else { return nil }
        
        self.id = id
        self.username = username
    }
}

var json: [[String: Any]] = [["id" : 6, "username" : "minorkeys003"],
                             ["id" : "b4dD4t4", "username" : "malicioususer"],
                             ["id" : 8, "username" : "tswizzle1989"],
                             ["id" : 9, "suername" : "spellingwiz"]]

let artists = json.flatMap { (artistJSON) -> Artist? in
    return Artist(json: artistJSON)
}

for artist in artists {
    print("id: \(artist.id), username: \(artist.username)")
}
/*:
 
 The example above reproduces a common use case of parsing JSON returned from a network request. Our `Artist` class has a failable initializer that returns `nil` if the json dictionary contains invalid data. With `flatMap`, we're able to remove invalid json data from our `artists` array.
 
 ### Removing Nils without FlatMap
 
 */
let optionalFruits: [String?] = ["banana", nil, "orange", nil, nil, "pineapple"]

var fruits = [String]()
for item in optionalFruits {
    if let item = item {
        fruits.append(item)
    }
}

print("fruits: \(fruits)") // ["banana", "orange", "pineapple"]
/*:
 
 Next, let's see how `flatMap` can condense our code using closure shorthand syntax.
 
 ### FlatMap with Shorthand Syntax
 
 */
let _fruits = optionalFruits.flatMap { $0 }
print("_fruits: \(_fruits)") // ["banana", "orange", "pineapple"]
/*:
 
 ## Chaining Higher-Order Functions
 
 It is possible to chain functions one after another. Doing so can create clear transformations of data.
 
 */
let input = [100, 32, 78, 51, 11, 98, 17, 19, 92]

let output = input
    .filter { $0 % 2 == 0 }     // filter out odd numbers
    .map { $0 * 3 + 1 }         // multiple each element by 3 and increment by 1
    .reduce(0, +)               // sums elements together

print("output \(output)") // 1205
/*:
 
 ## Summary
 
 In this playground, we've explored 4 of the most common higher-order functions. Higher-order functions can help us write clear, succinct code. The next time you find yourself iterating through a collection, see if you can apply any of the **knowledge** learned in this tutorial in your code.
 
 ## Challenges
 
 Below are some challenges to help you practice using higher-order functions.
 
 ### Challenge 1
 
 Use the `map` function that returns an array that converts each element in the `inputC1` array from a Float to an Int.
 
 */
let inputC1 = [1.18, 25.24, 21.6, 35.25, 30.41, 44.13]





/*:
 
 ### Challenge 2
 
 Use the `filter` function to filter out all odd numbers in the `inputC2` array.
 
 */
let inputC2 = [165, 684, 611, 500, 710, 9, 620, 254, 616, 920]





/*:
 
 ### Challenge 3
 
 Use the `reduce` function to find the lowest, odd number in the `inputC3` array.
 
 */
let inputC3 = [67, 2, 13, 88, 12, 56, 34, 33, 71, 7, 44]





/*:
 
 ### Challenge 4
 
 Use the following conditions to determine the student with the most points in the `inputC4` array. Each condition is ordered by priority and should be applied sequentially. You'll need to chain together multiple higher-order functions to find the winner.
 
 Conditions:
 1. Students with a even number of initial points get their points reduced by half
 2. Students with a first name that ends with the letter `e` get an additional 20 points
 3. Students with usernames less than 3 characters are disqualified
 4. Students with an even `id` get an extra 30 points; students with an odd `id` get their points reduced by 15
 
 */

class Student {
    let id: Int
    let firstName: String
    let username: String
    var points: Int
    
    init(id: Int, firstName: String, username: String, initialPoints: Int) {
        self.id = id
        self.firstName = firstName
        self.username = username
        self.points = initialPoints
    }
}

let inputC4 = [Student(id: 0, firstName: "Anna", username: "bluerune", initialPoints: 8),
               Student(id: 1, firstName: "Gary", username: "bowingcat", initialPoints: 66),
               Student(id: 2, firstName: "Tom", username: "tom", initialPoints: 44),
               Student(id: 3, firstName: "Caroline", username: "kalesalad", initialPoints: 63),
               Student(id: 4, firstName: "Tamara", username: "kitchensink", initialPoints: 84),
               Student(id: 5, firstName: "Jake", username: "organicglass", initialPoints: 16),
               Student(id: 6, firstName: "Ryan", username: "stormygrass", initialPoints: 53),
               Student(id: 7, firstName: "Jade", username: "sugarrush", initialPoints: 34),
               Student(id: 8, firstName: "Muhammad", username: "purplegoose", initialPoints: 88),
               Student(id: 9, firstName: "Taylor", username: "tay", initialPoints: 61),
               Student(id: 10, firstName: "Jesse", username: "obtusetriangle", initialPoints: 86),
               Student(id: 11, firstName: "Will", username: "emptyinbox", initialPoints: 16),
               Student(id: 12, firstName: "Dimitri", username: "dmtr", initialPoints: 30),
               Student(id: 13, firstName: "Gwen", username: "1", initialPoints: 98),
               Student(id: 14, firstName: "James", username: "j", initialPoints: 23),
               Student(id: 15, firstName: "Maggie", username: "mag", initialPoints: 67)]



























