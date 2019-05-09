//
//  Game.swift
//  puzzle15
//
//  Created by siret on 21/04/2019.
//  Copyright © 2019 siret. All rights reserved.
//

import Foundation

class Game {
    var boardWidth: Int
    var boardHeight: Int
    
    var correctSolution: [String]
    var gameBoard: [[String]]

    init(width: Int, height: Int) {
        self.boardWidth = width
        self.boardHeight = height
        
        let tileCount = width*height
        
        self.correctSolution = Array(repeating: "", count: tileCount)
        
        for i in 1...tileCount-1 {
            correctSolution[i-1] = String(i)
        }
        
        correctSolution[tileCount-1] = ""
        
        self.gameBoard = Array(repeating: Array(repeating: "", count: width), count: height)
    }
    
    func startGame() {
        var boardToShuffle = correctSolution.shuffled()
        
        var k = 0;
        
        for i in 0...boardHeight-1 {
            for j in 0...boardWidth-1 {
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
    
        for i in 0...boardHeight-1 {
            for j in 0...boardWidth-1 {
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
    
        for i in 0...boardHeight-1 {
            for j in 0...boardWidth-1 {
                if (gameBoard[i][j] != correctSolution[k]) {
                    return false
                }
                
                k += 1
            }
        }
    
        return true
    }
    
    
}
