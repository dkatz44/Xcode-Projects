//
//  MenuViewController.swift
//  Depressing Quotes
//
//  Created by Daniel Katz on 9/15/16.
//  Copyright © 2016 OK. All rights reserved.
//

import UIKit

protocol DestinationViewDelegate {
    func reset()
    func invalidateTimer()
    func checkAnswers()
}


class MenuViewController: UIViewController {
  
    var delegate: DestinationViewDelegate! = nil
    
    var currentSeed: Int = 0
    
    var seedsPass: [Int] = []
    
    @IBAction func Reset(_ sender: AnyObject) {
 
        // Call reset function for the quote screen
        self.dismiss(animated: false, completion: nil)
        delegate.reset()
    }

    @IBAction func checkAnswers(_ sender: AnyObject) {
        
        // Call checkAnswers function for the quote screen
        self.dismiss(animated: false, completion: nil)
        delegate.checkAnswers()
    }
    
    @IBAction func Home(_ sender: AnyObject) {
        // Segue to Home Screen
        
        // Need to invalidate the here, timer.invalidate()
        
         let alertController = UIAlertController(title: "Are you sure you want to go home?", message: "", preferredStyle: .alert)
         
         let cancelAction: UIAlertAction = UIAlertAction(title: "No", style: .cancel) { action -> Void in
         }
         alertController.addAction(cancelAction)
         
         let homeScreen: UIAlertAction = UIAlertAction(title: "Yes", style: .default) { action -> Void in
         
         self.delegate.invalidateTimer()
            
         self.performSegue(withIdentifier: "quoteMenuToHomeScreen", sender: nil)
         }
        
         alertController.addAction(homeScreen)
        
         self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func NewQuote(_ sender: AnyObject) {
        // Segue to Quote Screen
        
        print("current seed:" + String(currentSeed))
        
        let alertController = UIAlertController(title: "Are you sure you want a new quote?", message: "", preferredStyle: .alert)
 
        let cancelAction: UIAlertAction = UIAlertAction(title: "No", style: .cancel) { action -> Void in
        }
        alertController.addAction(cancelAction)
 
        let newQuote: UIAlertAction = UIAlertAction(title: "Yes", style: .default) { action -> Void in
 
            self.performSegue(withIdentifier: "quoteMenuToNewQuote", sender: nil)
        }
        alertController.addAction(newQuote)
 
 
        self.present(alertController, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "quoteMenuToNewQuote"
        {
            let destination = segue.destination as! ViewController
            
            destination.seedsUsed = seedsPass
            print("seed pass win screen prep for segue: ", seedsPass)
        }
    }
    
}
