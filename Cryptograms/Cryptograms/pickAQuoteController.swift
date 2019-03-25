//
//  pickAQuoteController.swift
//  Depressing Quotes
//
//  Created by Daniel Katz on 10/1/16.
//  Copyright © 2016 OK. All rights reserved.
//

import UIKit
import CoreData

class pickAQuoteController: UIViewController {
    
    @IBOutlet var backButton: UIButton!

    
    @IBOutlet var quoteCollectionWidth: NSLayoutConstraint!
    @IBOutlet var quoteSelectionCollection: UICollectionView!
    
    var screenSize = UIScreen.main.bounds
    var screenWidth: CGFloat = 0.0
    var screenHeight: CGFloat = 0.0
    var buttonRow: Int = 0
    
    var selectedCategory: String = ""
    var selectedQuoteSeed: Int = 0
    
    let quoteDict = QuoteDictionary(seed: 0)
    var selectedQuoteCell = quoteSelectionCell()
    
    var compQuoteList: [Int] = []
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.black
        backButton.layer.borderWidth = 1
        //  self.buttonView.layer.borderColor = UIColor(red:0/255.0, green:122/255.0, blue:255/255.0, alpha: 1.0).CGColor
        backButton.layer.cornerRadius = 10
        backButton.layer.borderColor = UIColor(red:0/255.0, green:122/255.0, blue:255/255.0, alpha: 1.0).cgColor
        
        // categoriesCollectionView.layer.backgroundColor = UIColor.darkGrayColor().CGColor
        // ✔︎ ◎ ❒
        self.screenWidth = screenSize.width
        self.screenHeight = screenSize.height
        
        // categoriesCollectionView.backgroundColor = UIColor.clearColor()
        quoteSelectionCollection.layer.cornerRadius = 5
        
        getCompletedQuotes()
    }
    
    
    override func viewDidLayoutSubviews() {
        
        let screenByFive = screenWidth / 5
     //   print("Collection frame width: ",quoteSelectionCollection.frame.width)
        quoteCollectionWidth.constant = screenWidth - screenByFive
        
        quoteSelectionCollection.layoutIfNeeded()
     //   print("Collection frame width after layout: ",quoteSelectionCollection.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let quoteCount = quoteDict.quotesFromSpecificCategory(selectedCategory).count
        
        print("Quote Count: ", quoteCount)
        
        return quoteCount
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
    //    print("sizeforitematIndexPath size", screenWidth)
        
        let w = quoteSelectionCollection.frame.width - 20
        
        let h: CGFloat = 60.0
        
   //     print("sizeForItemAtIndexPath w: ", w, " h: ", h)
        
        return CGSize(width: w, height: h)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        
        // Call core data fetch for a list of completed quotes in the category
        
        let cell: quoteSelectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "quoteCell", for: indexPath) as! quoteSelectionCell
        
        let quoteList = quoteDict.quotesFromSpecificCategory(selectedCategory)
        
        var quoteSourceFromSelection: [String] = []
        var quoteDifficultyList: [String] = []
        
        for quoteSeed in quoteList
        {
            let quoteToAdd = quoteDict.quoteSourceWithInputSeed(quoteSeed)
            quoteSourceFromSelection.append(quoteToAdd)
            
            let quoteObjectForDifficulty = QuoteObject(seed: quoteSeed)
            let quoteDifficulty = quoteObjectForDifficulty.getDifficultyText()
            quoteDifficultyList.append(quoteDifficulty)
        //    print("quote source: ", quoteToAdd)
        //    print("quote length: ", quoteObjectForDifficulty.getDifficulty())
        //    print("quote difficulty text: ", quoteDifficulty)
            
        }
        
        cell.quoteNameButton.setTitle(quoteSourceFromSelection[(indexPath as NSIndexPath).row], for: UIControlState())
        
        cell.seed = quoteList[(indexPath as NSIndexPath).row]
        
        if quoteDifficultyList[(indexPath as NSIndexPath).row] == "Medium"
        {
            cell.difficultyLabel.textColor = UIColor.yellow
        }
        else if quoteDifficultyList[(indexPath as NSIndexPath).row] == "Hard"
        {
            cell.difficultyLabel.textColor = UIColor.red
        }
        
        // if completed quote list from core data contains cell.seed then quoteCompletionStatusLabel.text = ✔︎
        if compQuoteList.contains(cell.seed)
        {
            cell.quoteCompletionStatusLabel.text = "✔︎"
        }
        else
        {
            cell.quoteCompletionStatusLabel.text = " "
        }
        cell.quoteCompletionStatusLabel.layer.borderWidth = 3
        cell.quoteCompletionStatusLabel.layer.borderColor = UIColor.black.cgColor
        
        cell.layer.cornerRadius = 5
        
        cell.layer.backgroundColor = UIColor(red:1.0, green:1.0, blue:1.0, alpha:0.2).cgColor
        
        cell.quoteNameButton.tag = (indexPath as NSIndexPath).row
        
        cell.quoteNameButton.addTarget(self, action: #selector(pickAQuoteController.buttonClicked(_:)), for: UIControlEvents.touchUpInside)
        
        
        print("cell title:" ,cell.quoteNameButton.titleLabel?.text as Any)
        print("cell seed: ", cell.seed)
        print("quote button tag: ", cell.quoteNameButton.tag)
        print(indexPath)
        
        
        return cell
        
    }
    
    
    func buttonClicked(_ sender:UIButton)
    {
        
        buttonRow = sender.tag
        print("button row: ", buttonRow)
        
        performSegue(withIdentifier: "pickQuoteToQuoteGame", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pickQuoteToQuoteGame"
        {
            let cellPath = IndexPath(row: buttonRow, section: 0)
            //     print("Cell path for button row: ", cellPath)
            
            selectedQuoteCell = quoteSelectionCollection.cellForItem(at: cellPath) as! quoteSelectionCell
            
            selectedQuoteSeed = selectedQuoteCell.seed
            
            let destination = segue.destination as! ViewController
            
            destination.pickedSeed = selectedQuoteSeed
            print("seed picked: ", selectedQuoteSeed)
            
            destination.gameMode = "Category"
        }
    }
   
    func getContext () -> NSManagedObjectContext {
        let CDStack = CoreDataStack()
        return CDStack.persistentContainer.viewContext
    }
    
    func getCompletedQuotes () {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CdCompletedQuote")
        
        do {
            //go get the results
            let searchResults = try getContext().fetch(fetchRequest)
            
            //I like to check the size of the returned results!
            print ("num of results = \(searchResults.count)")
            
            //You need to convert to NSManagedObject to use 'for' loops
            for trans in searchResults as! [NSManagedObject] {
                
                compQuoteList.append(trans.value(forKey: "seed") as! Int)
                print("seed: ", trans.value(forKey: "seed") as Any)
                
            }
        } catch {
            print("Error with request: \(error)")
        }
    }

}
