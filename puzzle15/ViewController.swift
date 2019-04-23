//
//  ViewController.swift
//  puzzle15
//
//  Created by siret on 11/04/2019.
//  Copyright © 2019 siret. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var game: Game = Game()

    var noOfMoves: Int = 0
    @IBOutlet weak var containerStack: UIStackView!
    
    @IBOutlet weak var newGameButton: UIButton!
    
    @IBOutlet weak var moveCountLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    var seconds = 0 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    
    @IBOutlet var puzzleButtons: [UIButton]!
    
    @IBAction func newGameTouchUpInside(_ sender: UIButton) {
        newGame()
    }
    
    @IBAction func puzzleButtonTouchUpInside(_ sender: UIButton) {
        let (row, col) = getCoords(tag: sender.tag)
        
        if (game.move(row: row, col: col)) {
            noOfMoves += 1
            
            if (game.isWon()) {
                timer.invalidate()
            }
        }
        
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        if UIDevice.current.model == "iPhone4,1" || UIDevice.current.model == "iPhone6,1" {
//            UILabel.appearance().font = UIFont.systemFont(ofSize: 1)
//        }
        
        newGameButton.layer.cornerRadius = 10
        
        newGame()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            containerStack.axis = NSLayoutConstraint.Axis.horizontal
        } else {
            containerStack.axis = NSLayoutConstraint.Axis.vertical
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func newGame() {
        game.startGame();
        
        noOfMoves = 0;
        
        timer.invalidate()
        seconds = 0
        runTimer()
        
        updateUI();
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
        let rowNo = tag / 4
        let colNo = tag - rowNo * 4
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
                    gamebtn.backgroundColor = UIColor.init(red: 227/255, green: 231/255, blue: 254/255, alpha: 1.0)
                }
            }
        }
        
        moveCountLabel.text = "\(noOfMoves)"
    }
}

