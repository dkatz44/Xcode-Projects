//
//  QuoteWinViewController.swift
//  Swift Test 2
//
//  Created by Daniel Katz on 3/11/16.
//  Copyright © 2016 OK. All rights reserved.
//

import UIKit
import CoreData

class QuoteWinViewController: UIViewController
{
    
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var difficultyLabel: UILabel!
    @IBOutlet var hintsNeededLabel: UILabel!
    @IBOutlet var quoteTextLabel: UILabel!
    @IBOutlet var elapsedTimeLabel: UILabel!
    @IBOutlet var buttonStackView: UIStackView!
    
    var hintsUsed: Int = 0
    var hintCount: Int = 0
    
    @IBOutlet var buttonStack: UIView!
    var elapsedTime: String = ""
    
    var quoteLabelText: String = ""
    
    var seedsPass: [Int] = []
    
    var quoteDifficulty: Int = 0
    
    var score: Int = 0
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.black
        quoteTextLabel.text = quoteLabelText
        quoteTextLabel.font.withSize(30)
        hintsUsed = hintCount
        hintsNeededLabel.text = "Hints Needed: " + String(hintsUsed)
        print(quoteLabelText)
        
        difficultyLabel.text = "Quote Difficulty: " + String(quoteDifficulty)
        scoreLabel.text = "Score: " + String(score)
        
        elapsedTimeLabel.text = getElapsedTimeString(elapsedTime)
        
        self.buttonStack.layer.borderWidth = 3
        self.buttonStack.layer.borderColor = UIColor(red:0/255.0, green:122/255.0, blue:255/255.0, alpha: 1.0).cgColor
        print("seeds Pass win screen view did load: ", seedsPass)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewQuoteFromQuoteWin"
        {
            let destination = segue.destination as! ViewController
            
            destination.seedsUsed = seedsPass
            print("seed pass win screen prep for segue: ", seedsPass)
        }
        
    }
    
    
    func getElapsedTimeString(_ elapsedTime: String) -> String
    {
        var secondString: String
        var minuteString: String
        var hourString: String
        
        let secondsInt = Int(elapsedTime[Range(elapsedTime.characters.index(elapsedTime.startIndex, offsetBy: 6)..<elapsedTime.characters.index(elapsedTime.startIndex, offsetBy: 8))])!
        let minutesInt = Int(elapsedTime[Range(elapsedTime.characters.index(elapsedTime.startIndex, offsetBy: 3)..<elapsedTime.characters.index(elapsedTime.startIndex, offsetBy: 5))])!
        let hoursInt = Int(elapsedTime[Range(elapsedTime.startIndex..<elapsedTime.characters.index(elapsedTime.startIndex, offsetBy: 2))])!
        
        if secondsInt == 1
        {
            secondString = String(secondsInt) + " Second"
        }
        else
        {
            secondString = String(secondsInt) + " Seconds"
        }
        
        if minutesInt == 1
        {
            minuteString = " " + String(minutesInt) + " Minute"
        }
        else if minutesInt == 0 && hoursInt < 1
        {
            minuteString = ""
        }
        else
        {
            minuteString = " " + String(minutesInt) + " Minutes"
        }
        
        if hoursInt == 1
        {
            hourString = " " + String(hoursInt) + " Hour"
        }
        else if hoursInt == 0
        {
            hourString = ""
        }
        else
        {
            hourString = " " + String(hoursInt) + " Hours"
        }
        
        let elapsedTimeString = "Elapsed Time:" + hourString + minuteString + " " + secondString
        
        return elapsedTimeString
    }

}

