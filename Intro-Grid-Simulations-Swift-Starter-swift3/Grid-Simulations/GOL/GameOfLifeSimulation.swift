//
//  GameOfLifeSimulation.swift
//  Grid-Simulations
//
//  Created by Yujin Ariza on 3/21/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation

public class GameOfLifeSimulation: Simulation {

    public var liveChar: Character = "👾"
    
    public override func update() {
        
        var newGrid = grid
        
        for x in 0...grid.count-1 {
            for y in 0...grid[0].count-1 {
                //                if grid[x][y] == liveChar && countNeighbors(grid: grid, column: x, row: y) == 2{
                //                    //newGrid[x][y] = liveChar
                //                }
                //
                //
                //                else if grid[x][y] == liveChar && countNeighbors(grid: grid, column: x, row: y) == 3 {
                //                    //newGrid[x][y] = liveChar
                //                }
                
                if grid[x][y] == liveChar && countNeighbors(grid: grid, column: x, row: y) < 2 {
                    newGrid[x][y] = nil
                }
                    
                    
                else if grid[x][y] == liveChar && countNeighbors(grid: grid, column: x, row: y) > 3 {
                    newGrid[x][y] = nil
                }
                    
                else if grid[x][y] == nil && countNeighbors(grid: grid, column: x, row: y) == 3{
                    newGrid[x][y] = liveChar
                }
                
            }
        }
        grid = newGrid
    }

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
    
     func countNeighbors(grid: [[Character?]], column x: Int, row y: Int) -> Int {
        
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

}
