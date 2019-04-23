//
//  Game.swift
//  puzzle15
//
//  Created by siret on 21/04/2019.
//  Copyright © 2019 siret. All rights reserved.
//

import Foundation

class Game {
    var correctSolution = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15",""]
    var gameBoard: [[String]] = Array(repeating: Array(repeating: "", count: 4), count: 4)
    
    func startGame() {
        var boardToShuffle = correctSolution.shuffled()
        
        var k = 0;
        
        for i in 0...3 {
            for j in 0...3 {
                gameBoard[i][j] = boardToShuffle[k];
                k += 1;
            }
        }
    }
    
    
    func move(row clickedRow: Int, col clickedCol: Int) -> Bool {
        var emptyCell = getEmptyCoordinates();
        let emptyCellRowNo = emptyCell[0];
        let emptyCellColNo = emptyCell[1];
        let isXAxis = clickedRow-emptyCellRowNo == 0;
        let isYAxis = clickedCol-emptyCellColNo == 0;
        
        if (!isXAxis && !isYAxis) {
            return false;
        }
        
        if (isXAxis) {
            if (clickedCol < emptyCellColNo) {
                for i in stride(from: emptyCellColNo, to: clickedCol, by: -1) {
                    gameBoard[clickedRow][i] = gameBoard[clickedRow][i-1];
                }
            } else if (clickedCol > emptyCellColNo) {
                for i in stride(from: emptyCellColNo, to: clickedCol, by: 1) {
                    gameBoard[clickedRow][i] = gameBoard[clickedRow][i+1];
                }
            }
        } else if (isYAxis) {
            if (clickedRow < emptyCellRowNo) {
                for i in stride(from: emptyCellRowNo, to: clickedRow, by: -1) {
                    gameBoard[i][clickedCol] = gameBoard[i-1][clickedCol];
                }
            } else if (clickedRow > emptyCellRowNo) {
                for i in stride(from: emptyCellRowNo, to: clickedRow, by: 1) {
                    gameBoard[i][clickedCol] = gameBoard[i+1][clickedCol];
                }
            }
        }
        
        gameBoard[clickedRow][clickedCol] = "";
        return true
    }
    
    func getGameBoardValue(_ row: Int, _ column: Int) -> String {
        return gameBoard[row][column];
    }
    
    func getEmptyCoordinates() -> [Int] {
        var coordinates: [Int] = Array(repeating: 0, count: 2)
    
        for i in 0...3 {
            for j in 0...3 {
                if gameBoard[i][j] == "" {
                    coordinates[0] = i;
                    coordinates[1] = j;
                }
            }
        }
    
        return coordinates;
    }
    
    func isWon() -> Bool {
        var k = 0
    
        for i in 0...3 {
            for j in 0...3 {
                if (gameBoard[i][j] != correctSolution[k]) {
                    return false
                }
                
                k += 1
            }
        }
    
        return true
    }
}
