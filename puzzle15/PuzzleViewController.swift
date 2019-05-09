//
//  ViewController.swift
//  puzzle15
//
//  Created by siret on 11/04/2019.
//  Copyright © 2019 siret. All rights reserved.
//

import UIKit

class PuzzleViewController: UIViewController {
    var game = Game(width: 3, height: 3)
    
    var noOfMoves: Int = 0
    
//    var gameboardWidth = 3
//
//    var gameboardHeight = 3
    
    var puzzleButtons: [UIButton] = [UIButton]()
    
    var themes: [String: [String : UIColor]] = ["Light": ["background" : UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0), "labeltext" : UIColor.darkGray, "buttonbackground" : UIColor(red:0.97, green:0.72, blue:1.00, alpha:1.0), "buttontext" : UIColor(red:0.39, green:0.39, blue:0.39, alpha:1.0)], "Dark": ["background" : UIColor(red:0.39, green:0.39, blue:0.39, alpha:1.0), "labeltext" : UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.0), "buttonbackground" : UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0), "buttontext" : UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)]]
    
    var backgroundColor : UIColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
    var labelTextColor : UIColor = UIColor.darkGray
    var buttonBackgroundColor : UIColor = UIColor(red:0.39, green:0.39, blue:0.39, alpha:1.0)
    var buttonTextColor : UIColor = UIColor(red:0.97, green:0.72, blue:1.00, alpha:1.0)
    
    @IBOutlet weak var gameBoard: UIStackView!
    
    @IBOutlet weak var containerStack: UIStackView!
    
    @IBOutlet weak var moveCountLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    var seconds = 0 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //        if UIDevice.current.model == "iPhone4,1" || UIDevice.current.model == "iPhone6,1" {
        //            UILabel.appearance().font = UIFont.systemFont(ofSize: 1)
        //        }
        
//        game = Game(width: gameboardWidth, height: gameboardHeight)
        puzzleButtons = Array(repeating: UIButton.init(), count: game.boardWidth * game.boardHeight)
    
        newGame()
    }
    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        if UIDevice.current.orientation.isLandscape {
//            containerStack.axis = NSLayoutConstraint.Axis.horizontal
//        } else {
//            containerStack.axis = NSLayoutConstraint.Axis.vertical
//        }
//    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(PuzzleViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func newGame() {
        game.startGame();
        
        noOfMoves = 0;
        
        timer.invalidate()
        seconds = 0
        runTimer()
        
        drawBoard()
    }
    
    @objc func updateTimer() {
        seconds += 1     //This will decrement(count down)the seconds.
        timeLabel.text = timeString(time: TimeInterval(seconds)) //This will update the label.
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    func getCoords(tag: Int) -> (row: Int, col: Int) {
        let rowNo = tag / game.boardWidth
        let colNo = tag % game.boardWidth
        return (rowNo, colNo)
    }
    
    func updateUI() {
        UIView.performWithoutAnimation {
            for gamebtn in puzzleButtons {
                let (row,col) = getCoords(tag: gamebtn.tag)
                let title = game.gameBoard[row][col]
                
                gamebtn.setTitle(title, for: UIControl.State.normal)
                gamebtn.layer.cornerRadius = 10
                
                if title == "" {
                    gamebtn.backgroundColor = UIColor.clear
                } else {
                    gamebtn.backgroundColor = buttonBackgroundColor
                    gamebtn.setTitleColor(buttonTextColor, for: UIControl.State.normal)
                }
            }
        }
        
        moveCountLabel.text = "\(noOfMoves)"
    }
    
    func drawBoard() {
        var k = 0
        
        for i in 0...game.boardHeight-1 {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.alignment = .fill
            rowStack.distribution = .fillEqually
            rowStack.spacing = 8.0
            gameBoard.addArrangedSubview(rowStack)
            
            for j in 0...game.boardWidth-1 {
                let button = UIButton()
                button.tag = k
                button.addTarget(self, action: Selector(("buttonClicked:")), for: .touchUpInside)
                button.layer.cornerRadius = 10
                let title = game.gameBoard[i][j]
                button.setTitle(title, for: UIControl.State.normal)
                if title == "" {
                    button.backgroundColor = UIColor.clear
                } else {
                    button.backgroundColor = buttonBackgroundColor
                    button.setTitleColor(buttonTextColor, for: UIControl.State.normal)
                }
                rowStack.addArrangedSubview(button)
                puzzleButtons[k] = button
                k += 1
            }
        }
        
        moveCountLabel.text = "\(noOfMoves)"
        moveCountLabel.textColor = labelTextColor
        timeLabel.textColor = labelTextColor
        self.view.backgroundColor = backgroundColor
        navigationController?.navigationBar.barTintColor = backgroundColor
        navigationController?.navigationBar.tintColor = labelTextColor
    }
    
    @objc func buttonClicked(_ sender: UIButton) {
        let (row, col) = getCoords(tag: sender.tag)
        
        if (game.move(row: row, col: col)) {
            noOfMoves += 1
            
            if (game.isWon()) {
                timer.invalidate()
            }
        }
        
        updateUI()
    }
}
