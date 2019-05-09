//
//  MasterViewController.swift
//  puzzle15
//
//  Created by siret on 07/05/2019.
//  Copyright © 2019 siret. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var gameboardWidthCountLabel: UILabel!
    
    @IBOutlet weak var gameboardHeightCountLabel: UILabel!
    
    @IBOutlet weak var gameboardWidthStepper: UIStepper!
    
    @IBOutlet weak var gameboardHeightStepper: UIStepper!
    
    @IBOutlet weak var themePickerView: UIPickerView!
    
    @IBOutlet weak var startGameButton: UIButton!
    
    var themePickerData = ["Light", "Dark", "Colorful"]
    
    var pickedTheme = "Light"
    
    @IBAction func gameboardHeightStepperValueChanged(_ sender: UIStepper) {
        gameboardHeightCountLabel.text = "\(Int(sender.value))"
    }
    
    
    @IBAction func gameboardWidthStepperValueChanged(_ sender: UIStepper) {
        gameboardWidthCountLabel.text = "\(Int(sender.value))"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.themePickerView.delegate = self
        self.themePickerView.dataSource = self
    
        gameboardWidthCountLabel.text = "\(Int(gameboardWidthStepper.value))"
        
        gameboardHeightCountLabel.text = "\(Int(gameboardHeightStepper.value))"

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let segueId = segue.identifier {
            switch segueId {
                case "StartGame":
                    // safe downcast to expected view controller class
                    let gameboardWidthSelection = Int(gameboardWidthStepper.value)
                    let gameboardHeightSelection = Int(gameboardHeightStepper.value)
                    
                    if let vc = segue.destination as? PuzzleViewController {
                        vc.game = Game(width: gameboardWidthSelection, height: gameboardHeightSelection)
                        switch pickedTheme {
                        // sorry for hard coding :(
                            case "Light":
                                vc.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
                                vc.labelTextColor = UIColor.darkGray
                                vc.buttonBackgroundColor = UIColor(red:0.97, green:0.72, blue:1.00, alpha:1.0)
                                vc.buttonTextColor = UIColor(red:0.39, green:0.39, blue:0.39, alpha:1.0)
                                break
                            case "Dark":
                                vc.backgroundColor = UIColor(red:0.39, green:0.39, blue:0.39, alpha:1.0)
                                vc.labelTextColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.0)
                                vc.buttonBackgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
                                vc.buttonTextColor = UIColor(red:0.44, green:0.44, blue:0.44, alpha:1.0)
                                break
                            case "Colorful":
                                vc.backgroundColor = UIColor(red:0.71, green:1.00, blue:0.87, alpha:1.0)
                                vc.labelTextColor = UIColor(red:0.61, green:0.66, blue:0.91, alpha:1.0)
                                vc.buttonBackgroundColor = UIColor(red:0.89, green:0.91, blue:0.60, alpha:1.0)
                                vc.buttonTextColor = UIColor(red:1.00, green:0.66, blue:0.95, alpha:1.0)
                            default:
                                vc.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
                                vc.labelTextColor = UIColor.darkGray
                                vc.buttonBackgroundColor = UIColor(red:0.97, green:0.72, blue:1.00, alpha:1.0)
                                vc.buttonTextColor = UIColor(red:0.39, green:0.39, blue:0.39, alpha:1.0)
                        }
                    }
                default:
                    break
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return themePickerData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return themePickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        pickedTheme = themePickerData[row]
    }
}
