//
//  ViewController.swift
//  mapTest
//
//  Created by . on 7/4/18.
//  Copyright © 2018 OK. All rights reserved.
//

import UIKit

class settingsViewController: UIViewController, UITextFieldDelegate ,UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var walkingTextField: UITextField!
    
    @IBOutlet weak var runningTextField: UITextField!

    let pickerView1 = UIPickerView()
    let pickerView2 = UIPickerView()
    
    var walkingStrideLength: Float = 1.0
    var runningStrideLength: Float = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        walkingTextField.delegate = self
        runningTextField.delegate = self
        // Do any additional setup after loading the view.
        

        pickerView1.delegate = self
        pickerView2.delegate = self
        
        walkingTextField.inputView = pickerView1
        runningTextField.inputView = pickerView2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 5
        }
            
        else if component == 1 {
             return 1
        }
            
        else {
            return 100
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == 0 {
            return (self.view.frame.size.width * 10) / 100
        }
        else
        {
            return (self.view.frame.size.width * 15 ) / 100
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.black
        if component == 1 {
        pickerLabel.text = "."
        }
        else if component == 0 {
            pickerLabel.text = "\(row+1)"
        }
        else{
            
            if row < 10 {
                pickerLabel.text = "0\(row)"
            }
            else{
                pickerLabel.text = "\(row)"
            }
        }
        // pickerLabel.font = UIFont(name: pickerLabel.font.fontName, size: 15)
        pickerLabel.font = UIFont(name: "Helvetica", size: 30) // In this use your custom font
        pickerLabel.textAlignment = NSTextAlignment.center
        return pickerLabel
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        let selectedValue1 = Float(pickerView.selectedRow(inComponent: 0) + 1)
        let selectedValue2 = Float(pickerView.selectedRow(inComponent: 2)) / 100.0
        
        let combinedSelection = selectedValue1 + selectedValue2
        
        if pickerView == pickerView1{
            walkingTextField.text = String(format: "%.2f", combinedSelection)
            walkingStrideLength = combinedSelection
           // self.view.endEditing(true)
        }
        else {
            runningTextField.text = String(format: "%.2f", combinedSelection)
            runningStrideLength = combinedSelection
           // self.view.endEditing(true)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
/*
     
     disable paste
 import Foundation
 import UIKit  // don't forget this
 
 class CustomUITextField: UITextField {
 override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
 if action == "paste:" {
 return false
 }
 return super.canPerformAction(action, withSender: sender)
 }
 }*/

}
