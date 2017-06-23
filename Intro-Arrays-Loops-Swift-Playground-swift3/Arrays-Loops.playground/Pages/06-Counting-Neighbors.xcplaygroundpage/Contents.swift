class MySimulation: NeighborsSimulation {
/*:
 ![Make School Banner](./swift_banner.png)
 # Counting Neighbor Cells

 Now that we know how to instantiate a 2D grid, it's time to start implementing the logic of Game of Life. Here, we've provided you with a prefilled grid with a `Glider` pattern. Our first task is to count correctly how many neighbors each cell has!

 In the display to the right, you'll see that we've provided an overlay of the number of neighbors that your code will count. As you can see, all of the cells currently return 1, which is obviously incorrect. We'll fix this soon, so that all of the numbers will show the correct numbers and light up green!

 ## Is the cell living?

 Before we do our neighbor counting logic, let's instead prepare for ourselves a helper function -– something that will help us simplify our logic when we write a `countNeighbors` function later on.

 - callout(Challenge): Here, we have a `getAlive` function, which takes a `grid` of `[[Character?]]`, and `x` and `y` coordinates for the cell in question.

     Given these parameters, you should:

     - Check if the coordinates `x` and `y` are _in bounds_ of `grid`. If not, return 0.
     - Get the `Character?` (_character optional_) value from grid. Is it `nil`? If so, return 0.
     - If you haven't returned 0 yet, then return 1.

     
 - callout(Hint): To get the number of columns in grid, you can use `grid.count`. To get the number of rows, you can get the size of the first column: `grid[0].count`

 Write your code inside the following function:

*/

    func getAlive(grid: [[Character?]], column x: Int, row y: Int) -> Int {
        
        if x > grid.count-1 || x < 0 || y > grid[0].count-1 || y < 0 {
    
            return 0
            
            }
            else if grid[x][y] == nil {
            
            return 0
            
            }
        
            else {
                
            return 1
                
            }
        
        }
/*:

 ## Counting the neighboring cells

 Great! Now, we have to fill in the `countNeighbors` function. It should return an `Int` containing the number of neighboring cells a specific cell has. It is passed a `grid` of `[[Character?]]`, and `x` and `y` coordinates.

 To do this, we'll call our `getAlive` function on all the neighboring `x` & `y`. If it returns 0, that means that the cell is empty or that those are invalid coordinates – no error-checking necessary assuming you wrote `getAlive` correctly!

 To call `getAlive`, you can use a syntax like this:

    let alive = getAlive(grid: grid, column: x - 1, row: y)

 - note: We discussed this breifly in the Functions Playground. `getAlive` was declared with custom parameter labels of `column` and `row` for the `x` & `y` values!

     
 - callout(Hint): `alive` will then contain a 1 or 0 indicating status of the cell to the _left_ of the coordinate! Now all you have to do is call the function 8 times, in each of the directions (including diagonals) and add all of them up.

     If you get red numbers in the overlay, check your logic again (including `getAlive`) – look at which numbers are wrong to you pinpoint any bugs in your code. Grab a pen and some paper if you need to.

*/


    override func countNeighbors(grid: [[Character?]], column x: Int, row y: Int) -> Int {
        
        let d1 = getAlive(grid: grid, column: x - 1, row: y)
        
        let d2 = getAlive(grid: grid, column: x, row: y - 1)

        let d3 = getAlive(grid: grid, column: x - 1, row: y - 1)

        let d4 = getAlive(grid: grid, column: x + 1, row: y + 1)
        
        let d5 = getAlive(grid: grid, column: x + 1, row: y)
        
        let d6 = getAlive(grid: grid, column: x, row: y + 1)
        
        let d7 = getAlive(grid: grid, column: x + 1, row: y - 1)
        
        let d8 = getAlive(grid: grid, column: x - 1, row: y + 1)

        let alive = d1 + d2 + d3 + d4 + d5 + d6 + d7 + d8
        
        return (alive)
    }



//: [Previous](@previous) | [Next](@next)





















/*:
Don't worry about this code. It handles the display.
*/
}
import PlaygroundSupport
import SpriteKit
let size = CGSize(width: 320, height: 568)
let sceneView = SKView(frame: CGRect(origin: CGPoint.zero, size: size))
sceneView.wantsLayer = true
let scene = NeighborsOverlaySimulationScene(fileNamed: "SimulationScene")!
let path = Bundle.main.path(forResource: "map01", ofType: "txt")!
scene.setup(neighborsSim: MySimulation(file: path)!, palette: defaultPalette())
scene.scaleMode = .aspectFill
sceneView.presentScene(scene)
scene.checkNeighbors()
PlaygroundPage.current.liveView = sceneView
