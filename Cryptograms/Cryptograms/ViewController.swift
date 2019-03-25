//
//  ViewController.swift
//  Swift Test 2
//
//  Created by Daniel Katz on 3/5/16.
//  Copyright © 2016 OK. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIPopoverPresentationControllerDelegate, DestinationViewDelegate
{

    var gameMode: String = "Random"
    var pickedSeed: Int = 0
  
    @IBOutlet var displayTimeLabel: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var embeddedCollectionView: UICollectionView!

    @IBOutlet var keyboardCollectionView: UICollectionView!
    
    var screenSize = UIScreen.main.bounds
    var screenWidth: CGFloat = 0.0
    var screenHeight: CGFloat = 0.0
  
    var keyboardOriginY: CGFloat = 0.0
  
    @IBOutlet var movieName: UILabel!
    @IBOutlet var hintButton: UIButton!
    @IBOutlet var menuButton: UIButton!

    var seed: Int = 0
  
    var resetSeed: Int = 0
  
    var seedsUsed: [Int] = []
    
    var Quote: QuoteObject!
    var symbolArray: [String] = []
    var answerQuote: String = ""
    var lineAdjustedAnswerQuote = ""
    var quoteSpaceCount: Int = 0
    var vowelPositionArray: [Int] = []
    var quoteDifficulty: Int = 0

    var userInputDictionary: [IndexPath:String] = [:]
    
    var keyboardData: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "_"]
    
    var showVowels: Bool = false
    var autoFill: Bool = false
    
    var hintsGiven: [String] = []
    var hintsUsed: Int = 0
  
    var spaceIndexPath : [IndexPath] = []
  
    let quoteDictionarySize = UInt32(QuoteDictionary(seed: 0).quoteList.count)
  
    // Variables to determine time spent on quote
    let calendar = Calendar.current
    let startTime = Date()
    var endTime = Date()
  
    var compQuoteList: [Int] = []
  
    // Category completion tracking variables
    let quoteDict = QuoteDictionary(seed: 0)
    var compQuoteCategoryList: [String] = []
    var compCDCategoriesList: [String] = []
    var compCategories: [String] = []
  
    override func viewDidLoad() {
      //scrollView.indicatorStyle = UIScrollViewIndicatorStyle.White
      
      print("Quote dictionary size: ", quoteDictionarySize)
      
        self.view.backgroundColor = UIColor.black
        self.screenWidth = screenSize.width
        self.screenHeight = screenSize.height
        
        var seedUsed: Bool = false
      
      if gameMode == "Random"
      {
        while seedUsed == false
        {
            self.seed = Int(arc4random_uniform(quoteDictionarySize))
        
            if seedsUsed.contains(seed) == false
            {
                seedsUsed.append(seed)
                seedUsed = true
                print("seedsUsed append seed: ", seedsUsed)
            }
            else
            {
                if seedsUsed.count == Int(quoteDictionarySize)
                {
                    seedUsed = true
                    print("all seeds used")
                }
            }
        }
        print("Seeds Used:",seedsUsed)
      }
      else
      {
        seed = pickedSeed
      }
        self.Quote = QuoteObject(seed: seed)
        self.symbolArray = Quote.quoteControl()
        self.answerQuote = Quote.formattedAnswerQuote()
        self.quoteSpaceCount = Quote.numberOfSpaces()
        self.vowelPositionArray = Quote.vowelPosition()
        movieName.text = Quote.getQuoteSource()
     //   self.spaceIndexPath = getSpaceIndices()
        self.lineAdjustedAnswerQuote = Quote.lineAdjustedAnswerQuote()
        self.quoteDifficulty = Quote.getDifficulty()
      
        print("viewDidLoad embeddedHeight Constant", embeddedHeight.constant)
        print("viewDidLoad embeddedCollectionView content Size", embeddedCollectionView.contentSize)
      
        //self.embeddedCollectionView.backgroundColor = UIColor(red:255.0, green:179.0, blue:179.0, alpha:1.0)
          self.embeddedCollectionView.backgroundColor = UIColor.lightGray
      

        self.scrollView.layer.cornerRadius = 10
        self.embeddedCollectionView.layer.cornerRadius = 10
      
        self.scrollView.indicatorStyle = UIScrollViewIndicatorStyle.black
      
      
        self.hintButton.layer.borderWidth = 1
        self.menuButton.layer.borderWidth = 1
      
        self.hintButton.layer.cornerRadius = 10
        self.menuButton.layer.cornerRadius = 10
      
        self.hintButton.layer.borderColor = self.view.tintColor.cgColor
        self.menuButton.layer.borderColor = self.view.tintColor.cgColor
      
        print("viewdidload keyboard content size: ", keyboardCollectionView.contentSize.height)
        print("screen height: ", self.screenHeight)
        print("screen width: ", self.screenWidth)
        print("viewdidload keyboard cell count: ", keyboardCollectionView.numberOfItems(inSection: 0))
        print("viewdidload Keyboard content layout height: ", keyboardCollectionView.collectionViewLayout.collectionViewContentSize.height)
    
      //  startTimer()

    }
  
  override func viewWillAppear(_ animated: Bool) {
    
    keyboardOriginY = keyboardCollectionView.frame.origin.y
    
    // weird stuff with how the data has to be reloaded for the keyboard to display properly but this works so w/e
    keyboardCollectionView.reloadData()
    keyboardCollectionView.layoutIfNeeded()
    
    print("viewWillAppear Keyboard Y Origin: ", keyboardOriginY)
    print("viewWillAppear Keyboard content size: ", keyboardCollectionView.contentSize.height)
    print("viewWillAppear Keyboard content layout height: ", keyboardCollectionView.collectionViewLayout.collectionViewContentSize.height)
    print("viewWillAppear keyboard cell count: ", keyboardCollectionView.numberOfItems(inSection: 0))
  }
  
  
  
  @IBOutlet var movieNameHeightConstraint: NSLayoutConstraint!
  @IBOutlet var scrollViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet var keyboardHeightConstraint: NSLayoutConstraint!
  @IBOutlet var embeddedHeight: NSLayoutConstraint!
  func configureColletion()
  {
    
    //movieNameHeightConstraint.constant = CGFloat(movieName.intrinsicContentSize().height + 3)
    
    print("config collection keyboard content size: ", keyboardCollectionView.contentSize.height)
    
    // Get starting Y for the scrollview
    let scrollViewOriginY = scrollView.frame.origin.y
    print("configure collection scrollView Y Origin: ", scrollViewOriginY)
    
    // Get starting Y for the keyboard collection view
    //let keyboardOriginY = keyboardCollectionView.frame.origin.y
    print("configure collection keyboard Y Origin: ", keyboardOriginY)
    
    let scrollViewKeyboardHeightDiff = keyboardOriginY - scrollViewOriginY
    print("config collection scrollView Keyboard Height Diff: ", scrollViewKeyboardHeightDiff)
    
    // Get the content height of the quote and set quote collection height to content + 10 or so
    let contentHeight = embeddedCollectionView.contentSize.height + 5
    
    //If the QuoteCollection height is < the distance between the top of the scrollview and the top of the keyboard, then set the ScrollView height = QuoteCollection height
    if contentHeight < scrollViewKeyboardHeightDiff
    {
      scrollViewHeightConstraint.constant = contentHeight
      print("Content Height less than")
      
    }
      
    //If the QuoteCollection height is >= the distance between the top of the scrollview and the top of the keyboard, then set the ScrollView height = the distance between the top of the ScrollView and the top of the keyboard - 10 or so
    else
    {
      scrollViewHeightConstraint.constant = scrollViewKeyboardHeightDiff - 10
      print("Content height >=")
    }

    embeddedHeight.constant = CGFloat(contentHeight)
    
  }
  
  func configureKeyboardCollection()
  {
    let keyboardHeight = keyboardCollectionView.collectionViewLayout.collectionViewContentSize.height
    keyboardHeightConstraint.constant = CGFloat(keyboardHeight)
  }
  
  override func viewDidLayoutSubviews() {
    
    print("keyboard y origin before config keyboard", keyboardOriginY)
    // Calling this here makes sure that the proper keyboard Y origin is used
    if keyboardCollectionView.frame.origin.y != 0.0{
    keyboardOriginY = keyboardCollectionView.frame.origin.y
    }
    print("keyboard y origin before config keyboard 2", keyboardOriginY)
    configureKeyboardCollection()
    keyboardCollectionView.layoutIfNeeded()
    
    print("keyboard y origin after config keyboard", keyboardOriginY)
    
    configureColletion()
    //self.movieName.layoutIfNeeded()
    scrollView.reloadInputViews()
    scrollView.layoutIfNeeded()
    embeddedCollectionView.layoutIfNeeded()
    
    
    // Get starting Y for the scrollview
    let scrollViewOriginY = scrollView.frame.origin.y
    print("viewDidLayoutSubviews scrollView Y Origin: ", scrollViewOriginY)
    
    // Get starting Y for the keyboard collection view
    print("viewDidLayoutSubviews keyboard Y Origin: ", keyboardOriginY)
    
    
//    print("contentSize Height:", embeddedCollectionView.contentSize.height)
  }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 2
        {
            return symbolArray.count
        }
        else{
        
        return keyboardData.count
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 2
        {
        let cell: colViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! colViewCell
            
        if symbolArray[(indexPath as NSIndexPath).row] != " " && symbolArray[(indexPath as NSIndexPath).row] != "." && symbolArray[(indexPath as NSIndexPath).row] != "," && symbolArray[(indexPath as NSIndexPath).row] != "?" && symbolArray[(indexPath as NSIndexPath).row] != "!" && symbolArray[(indexPath as NSIndexPath).row] != "'"
        {
        cell.layer.cornerRadius = 5
        cell.labelCell.text = symbolArray[(indexPath as NSIndexPath).row]
        cell.inputCellButton.layer.cornerRadius = 5
        cell.inputCellButton.setTitleColor(UIColor(red:0.0, green:0.5, blue:0.0, alpha:1.0), for: .disabled)
        }
        else
        {
            if symbolArray[(indexPath as NSIndexPath).row] == " "
            {
                cell.labelCell.text = " "
                cell.inputCellButton.setTitle(" ", for: UIControlState())
            }
                if symbolArray[(indexPath as NSIndexPath).row] == "."
                {
                    cell.labelCell.text = " "
                    cell.inputCellButton.setTitle(".", for: UIControlState())
                }
                    if symbolArray[(indexPath as NSIndexPath).row] == ","
                    {
                        cell.labelCell.text = " "
                        cell.inputCellButton.setTitle(",", for: UIControlState())
                    }
                        if symbolArray[(indexPath as NSIndexPath).row] == "!"
                        {
                            cell.labelCell.text = " "
                            cell.inputCellButton.setTitle("!", for: UIControlState())
                        }
                            if symbolArray[(indexPath as NSIndexPath).row] == "?"
                            {
                                cell.labelCell.text = " "
                                cell.inputCellButton.setTitle("?", for: UIControlState())
                            }
                                if symbolArray[(indexPath as NSIndexPath).row] == "'"
                                {
                                    cell.labelCell.text = " "
                                    cell.inputCellButton.setTitle("'", for: UIControlState())
                                }
            
            if cell.inputCellButton.titleLabel?.text == " " || cell.inputCellButton.titleLabel?.text == "." || cell.inputCellButton.titleLabel?.text == "," || cell.inputCellButton.titleLabel?.text == "!" || cell.inputCellButton.titleLabel?.text == "?"
            {
                cell.inputCellButton.isEnabled = false
            }
            }
        

         // print("row is \(indexPath.row)")
        return cell
        }
            
        else{
            
        let cell: keyBoardViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "keyBoardCell", for: indexPath) as! keyBoardViewCell
            
        cell.keyBoardCellButton.setTitle(keyboardData[(indexPath as NSIndexPath).row], for: UIControlState())
        cell.keyBoardCellButton.layer.cornerRadius = 5
      //  cell.keyBoardCellButton.layer.backgroundColor = UIColor.darkGrayColor().CGColor
        cell.keyBoardCellButton.layer.backgroundColor = UIColor(red:1.0, green:1.0, blue:1.0, alpha:0.2).cgColor
        return cell
            
        }
    }
    
 /*   func getSpaceIndices() -> [NSIndexPath]
    {
        var indexPaths = [NSIndexPath]()
        
        for i in vowelPositionArray
        {
            let cellPath = NSIndexPath(forRow: i, inSection: 0)
            indexPaths.append(cellPath)
        }
        
        return indexPaths
    }*/
    
    func updateCells()
    {
        let userInputCollection = self.view.viewWithTag(2) as! UICollectionView
        
        userInputCollection.performBatchUpdates({userInputCollection.reloadItems(at: self.spaceIndexPath)}, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
      
      if collectionView.tag == 2
      {
          let numberOfCellInRow : Int = 11
          let padding : Int = 5
          let collectionCellWidth : CGFloat = (self.view.frame.size.width/CGFloat(numberOfCellInRow)) - CGFloat(padding)
          return CGSize(width: collectionCellWidth , height: collectionCellWidth * 2)
        
      }
      else{
               return CGSize(width: screenWidth / 10, height: (screenWidth / 10) * 0.85)
      // let numberOfCellInRow : Int = 9
      //  let padding : Int = 9
      //  let collectionCellWidth : CGFloat = (self.view.frame.size.width/CGFloat(numberOfCellInRow)) - CGFloat(padding)
     //   return CGSize(width: collectionCellWidth , height: collectionCellWidth)
      }

    }
  

  
    func highlightedCellCount() -> Int
    {
        var count: Int = 0
        let userInputCollection = self.view.viewWithTag(2) as! UICollectionView
        
        for cell in userInputCollection.visibleCells as! [colViewCell]
        {
            if cell.inputCellButton.userHighlighted == true
            {
                count += 1
            }
        }
        
        return count
    }
  
    func resetCellTextColor()
    {
      let userInputCollection = self.view.viewWithTag(2) as! UICollectionView
      
      for cell in userInputCollection.visibleCells as! [colViewCell]
      {
        //   print("title label text out of if: ", cell.inputCellButton.titleLabel?.text)
        if cell.inputCellButton.isEnabled == true
        {
          //   print("enabled text: ", cell.inputCellButton.titleLabel?.text)
          cell.inputCellButton.setTitleColor(UIColor.black, for: UIControlState())
        }
      }
    }
  
    
    func resetCellColor()
    {
       // print("reset cell color called")
        let userInputCollection = self.view.viewWithTag(2) as! UICollectionView
     
        for cell in userInputCollection.visibleCells as! [colViewCell]
            {
           //   print("title label text out of if: ", cell.inputCellButton.titleLabel?.text)
                if cell.inputCellButton.isEnabled == true
                {
               //   print("enabled text: ", cell.inputCellButton.titleLabel?.text)
                  cell.inputCellButton.layer.backgroundColor = UIColor.lightGray.cgColor
                  cell.inputCellButton.userHighlighted = false
                }
            }
        if showVowels == true
            {
               for i in vowelPositionArray
                {
                    let cellPath = IndexPath(row: i, section: 0)
                    let vowelCell = userInputCollection.cellForItem(at: cellPath) as! colViewCell
                //    vowelCell.inputCellButton.backgroundColor = UIColor.darkGrayColor()
                //    vowelCell.inputCellButton.backgroundColor = UIColor(red:192.0, green:192.0, blue:192.0, alpha:0.0)
                    vowelCell.inputCellButton.backgroundColor = UIColor(red:1.0, green:1.0, blue:1.0, alpha:0.0)
                    vowelCell.inputCellButton.userHighlighted = false
                }
            }
    }
    
    func emptyCellCount() -> Int
    {
        var emptyCount: Int = 0

        let dictionaryValues = [String](userInputDictionary.values)
        
        for value in dictionaryValues
        {
            if value == " " || value == "," || value == "." || value == "!" || value == "?" || value == "'"
            {
                emptyCount += 1
            }
        }
        
        return emptyCount
        
    }
    
    @IBAction func inputButtonPressed (_ sender: InputButton)
    {
      
        resetCellTextColor()
      
        let count = highlightedCellCount()
        
        let userInputCollection = self.view.viewWithTag(2) as! UICollectionView
        
        var indexRow: Int = 0
        
        if let cell = (sender as UIView?)!.parentViewOfType(UICollectionViewCell.self)
        {
            let indexPath = userInputCollection.indexPath(for: cell)
            
            indexRow = ((indexPath as NSIndexPath?)?.row)!
        }
      
      
      // if autoFill is off
      
      if autoFill == false
      {
        if sender.titleLabel?.text != " " && sender.titleLabel?.text != "." && sender.titleLabel?.text != "," && sender.titleLabel?.text != "?" && sender.titleLabel?.text != "!" && sender.titleLabel?.text != "'"
            {   // no highlighted cells then highlight this cell
                    if count == 0
                    {
                        sender.backgroundColor = UIColor.yellow
                        sender.userHighlighted = true
                    }
                    else
                    {
                        // this cell is already highlighted and it isn't a vowel then background = black
                        if count != 0 && sender.userHighlighted == true && vowelPositionArray.contains(indexRow) == false                        {
                            sender.userHighlighted = false
                            sender.backgroundColor = UIColor.lightGray
                            }
                            else
                            {
                                // this cell is already highlighted and it is a vowel and showVowels is on then background = gray
                                if sender.userHighlighted == true && vowelPositionArray.contains(indexRow) == true && showVowels == true
                                {
                                    resetCellColor()
                                    sender.userHighlighted = false
                                //    sender.backgroundColor = UIColor.darkGrayColor()
                                    sender.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha:0.0)
                                //    sender.backgroundColor = UIColor(red: 192.0, green: 192.0, blue: 192.0, alpha:0.0)
                                }
                                else
                                {
                                // this cell is already highlighted and it is a vowel and showVowels is off then background = black
                                if sender.userHighlighted == true && vowelPositionArray.contains(indexRow) == true && showVowels == false
                                {
                                    sender.userHighlighted = false
                                    sender.backgroundColor = UIColor.lightGray
                                }
                                
                                else
                                {
                                    // another cell is highlighted
                                    if count != 0 && sender.userHighlighted == false
                                    {
                                        resetCellColor()
                                        sender.backgroundColor = UIColor.yellow
                                        sender.userHighlighted = true
                                    }
                                }

                            }
                        }
                    }
              }
      }
      else
        {
         // print(count)
          if autoFill == true
          {
            if count != 0 && sender.userHighlighted == true
            {
              resetCellColor()
            }
            else
            {
              resetCellColor()
                for cell in userInputCollection.visibleCells as! [colViewCell]
                {
                  let labelText = sender.parentViewOfType(colViewCell.self)?.labelCell?.text
                
                  if labelText != " " && labelText != "." && labelText != "," && labelText != "?" && labelText != "!" && labelText != "'"
                  {
                    if cell.labelCell?.text == labelText
                    {
                      //cell.inputCellButton.layer.backgroundColor = UIColor(red: 255.0, green: 255.0, blue: 0.0, alpha:0.4).cgColor
                      cell.inputCellButton.layer.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha:0.4).cgColor
                      cell.inputCellButton.userHighlighted = true
                      sender.layer.backgroundColor = UIColor.yellow.cgColor
                    }
                  }
                }
              }
            
          }
        }
      }

    
    @IBAction func keyboardButtonPressed (_ sender: KeyboardButton)
    {
      
        resetCellTextColor()
      
        let count = highlightedCellCount()
      
        let userInputCollection = self.view.viewWithTag(2) as! UICollectionView
        
    //    var index: Int = 0
        let AnswerStringLength = lineAdjustedAnswerQuote.characters.count
        
        // Initialize the userInputDictionary with all of the cell paths
        if userInputDictionary.count == 0
        {
           // for index = 0; index < AnswerStringLength; index += 1
              for index in (0..<AnswerStringLength)
                {
                    let cellPath = IndexPath(row: index, section: 0)
                    userInputDictionary[cellPath] = " "
                }
        }
            else
            {
                if count != 0
                {
                    for cell in userInputCollection.visibleCells as! [colViewCell]
                    {
                        if cell.inputCellButton.userHighlighted == true
                        {
                            if sender.titleLabel?.text != "_"
                            {
                                if autoFill == true
                                {
                           //     1.  Get the sender text character
                                
                                    let senderLetter = sender.titleLabel!.text
                                
                           //     2.  Find all of the matching symbols for where the text was inputted
                                
                                    let highLightedCellPath = userInputCollection.indexPath(for: cell)
                                    
                                    let highLightedCellSymbol = symbolArray[(highLightedCellPath! as NSIndexPath).row]
                                 //   print("highlighted cell symbol",highLightedCellSymbol)
                                    
                                    let inputSymbolArray: [Int] = returnIndices(highLightedCellSymbol, localSymbolArray: symbolArray)
                                    
                                //    print("input symbol array",inputSymbolArray)
                                    
                          //      3.  Update the rest of the symbols based on the list of indices
                                
                                    for i in inputSymbolArray
                                    {
                                        let symbolCellPath = IndexPath(row: i, section: 0)
                                        let symbolCell = userInputCollection.cellForItem(at: symbolCellPath) as! colViewCell
                                        symbolCell.inputCellButton.setTitle(senderLetter, for: UIControlState())
                                        userInputDictionary[userInputCollection.indexPath(for: symbolCell)!] = senderLetter
                                     //   print(userInputDictionary)
                                    }
                                }
                                else
                                {
                                cell.inputCellButton.setTitle(sender.titleLabel?.text, for: UIControlState())
                                userInputDictionary[userInputCollection.indexPath(for: cell)!] = sender.titleLabel?.text
                             //   print(userInputDictionary)
                                }
                            }
                            else
                            {
                                cell.inputCellButton.setTitle(sender.titleLabel?.text, for: UIControlState())
                                userInputDictionary[userInputCollection.indexPath(for: cell)!] = " "
                             //   print(userInputDictionary)
                            }
                        }
                    }
                }
        
 
        // if all cells are filled in aka if NO CELL == "_"
        let emptyCount = emptyCellCount()
      //  print(emptyCount)
                
        if emptyCount == quoteSpaceCount
        {
            resetCellColor()
            let correctAnswer = checkTheAnswer(lineAdjustedAnswerQuote)
         //   print(correctAnswer)
            
            if correctAnswer == true
            {
                userWins()
            }
            else
            {
                incorrectAnswer()
            }
        }

        }
    }

    func checkHintForCorrectAlready(_ hintLetterString: String) -> Bool
    {
      
      var correctAlready: Bool = false
      
      let answerHintLetterPositionList = Quote.letterPosition(hintLetterString)
      print("hint letter :", hintLetterString)
      var userInputHintLetterPositionList: [Int] = []
      
      for input in userInputDictionary
      {
      //  print("Input.0.row :", input.0.row, "Input.1: ", input.1)
        if input.1 == hintLetterString
        {
          userInputHintLetterPositionList.append((input.0 as NSIndexPath).row)
        }
      }
      
      print("unsortedAnswerList: ", answerHintLetterPositionList)
      print("unsortedUserList: ", userInputHintLetterPositionList)
      
      let sortedAnswerList = answerHintLetterPositionList.sorted(by: <)
      let sortedUserList = userInputHintLetterPositionList.sorted(by: <)
      print("sortedAnswerList: ", sortedAnswerList)
      print("sortedUserList: ", sortedUserList)
     
      if sortedAnswerList == sortedUserList
      {
        correctAlready = true
      }
      
      return correctAlready
    }
  

    
    //    Triggered by keyboard event that fills up last empty input square
    func checkTheAnswer(_ AnswerString: String) -> Bool
    {
        let AnswerStringLength = AnswerString.characters.count
        print("AnswerLen",AnswerStringLength)
     //   print("UserInputLen",userInputDictionary)
        var userInputArray: [String] = []
        var correct: Bool
        
    //    Sort the dictionary keys
        let dictionaryIndexKeys = [IndexPath](userInputDictionary.keys)
        
        let sortedKeys = dictionaryIndexKeys.sorted {($0 as NSIndexPath).row < ($1 as NSIndexPath).row}

        for key in sortedKeys
        {
            userInputArray.append(userInputDictionary[key]!)
        }
        
        let userInputString = userInputArray.joined(separator: "")

      //  print("userinput",userInputString)
      //  print("answer",answerQuote)
        
        if(AnswerString == userInputString)
            {
                correct = true
            }
        else
            {
                correct = false
            }
    
        return correct
    }

    func userWins()
    {
        resetCellColor()
        self.performSegue(withIdentifier: "quoteToQuoteWin", sender: nil)
    }
    
    func incorrectAnswer()
    {
     //   print("incorrect, try again")
        let alertController = UIAlertController(title: "Sorry, that's incorrect.", message: "", preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Keep trying", style: .cancel) { action -> Void in
        }
      
        let goHome: UIAlertAction = UIAlertAction(title: "Give up", style: .default) { action -> Void in
          
          self.performSegue(withIdentifier: "quoteToHome", sender: nil)
        }
      
        alertController.addAction(cancelAction)
        alertController.addAction(goHome)
        self.present(alertController, animated: true, completion: nil)
    }
  
    @IBAction func AutoFill(_ sender: UISegmentedControl) {
      
      let userInputCollection = self.view.viewWithTag(2) as! UICollectionView
      var yellowCellExists: Bool = false
      
      var yellowCellPath: IndexPath = IndexPath(row: 0, section: 0)
      
      for cell in userInputCollection.visibleCells as! [colViewCell]
      {
        if cell.inputCellButton.backgroundColor == UIColor.yellow
        {
          print("yellow cell: ", userInputCollection.indexPath(for: cell)!)
          yellowCellPath = userInputCollection.indexPath(for: cell)!
          yellowCellExists = true
        }
      }

        if sender.selectedSegmentIndex == 0
        {
            autoFill = true
          
            if yellowCellExists == true
            {
              let yellowCell = userInputCollection.cellForItem(at: yellowCellPath) as! colViewCell
              
              for cell in userInputCollection.visibleCells as! [colViewCell]
              {
                if cell.labelCell.text == yellowCell.labelCell.text && cell != yellowCell
                {
                  cell.inputCellButton.userHighlighted = true
                  cell.inputCellButton.layer.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha:0.4).cgColor
                }
                yellowCell.inputCellButton.userHighlighted = true
              }
              
            }
        }
        else
        {
            autoFill = false
          
            if yellowCellExists == true
          {
            let yellowCell = userInputCollection.cellForItem(at: yellowCellPath) as! colViewCell
            
            for cell in userInputCollection.visibleCells as! [colViewCell]
            {
              if cell != yellowCell
              {
                cell.inputCellButton.userHighlighted = false
                cell.inputCellButton.layer.backgroundColor = UIColor.lightGray.cgColor
              }
            }
          }
        }
      
      for cell in userInputCollection.visibleCells as! [colViewCell]
      {
        if cell.inputCellButton.userHighlighted == true
        {
          print("highlighted cell rows :", (userInputCollection.indexPath(for: cell) as NSIndexPath?)?.row as Any)
        }
      }
    }
  
    
    @IBAction func ShowVowels(_ sender: UISegmentedControl) {

        let userInputCollection = self.view.viewWithTag(2) as! UICollectionView
        
        if sender.selectedSegmentIndex == 0
        {
            for i in vowelPositionArray
                {
                    let cellPath = IndexPath(row: i, section: 0)
                    let cell = userInputCollection.cellForItem(at: cellPath) as! colViewCell
                //    cell.backgroundColor = UIColor(red:192.0, green:192.0, blue:192.0, alpha:0.2)
                    cell.backgroundColor = UIColor(red:1.0, green:1.0, blue:1.0, alpha:0.2)
                    if cell.inputCellButton.userHighlighted == false
                    {
                      cell.inputCellButton.backgroundColor = UIColor(red:1.0, green:1.0, blue:1.0, alpha:0.0)
                    }
                }
            showVowels = true
        }
        else
        {
            for i in vowelPositionArray
            {
                let cellPath = IndexPath(row: i, section: 0)
                let cell = userInputCollection.cellForItem(at: cellPath) as! colViewCell
                cell.backgroundColor = UIColor.lightGray
                if cell.inputCellButton.userHighlighted == false
                {
                  cell.inputCellButton.backgroundColor = UIColor.lightGray
                }
            }
            showVowels = false
        }
    }
    
    @IBAction func Hint(_ sender: UIButton) {
      
        let keyboardCollection = self.view.viewWithTag(1) as! UICollectionView
        let userInputCollection = self.view.viewWithTag(2) as! UICollectionView
        
      //  var index: Int = 0
        let AnswerStringLength = lineAdjustedAnswerQuote.characters.count
        
        // When hint is pressed before any other letter input, initializes the userInputDictionary with all of the cell paths here
        if userInputDictionary.count == 0
        {
         //   for index = 0; index < AnswerStringLength; index += 1
          for index in (0..<AnswerStringLength)
            {
                let cellPath = IndexPath(row: index, section: 0)
                userInputDictionary[cellPath] = " "
            }
        }
   if hintsGiven != []
   {
    var alreadyInHintArray: Bool = true // also includes inputAlreadyCorrect
    
    // if hints have already been given, keep pulling hints until a new one is generated
    while alreadyInHintArray == true
    {
      let getHint = QuoteObject(seed: seed).getHint()
      let (hintLetter, _ ) = getHint
      let hintLetterString = String(hintLetter)
        
        // if a new hint is found and the user doesn't already have the letter correct, append the hint letter to the hints given array so it won't be used again
        if hintsGiven.contains(hintLetterString!) == false && checkHintForCorrectAlready(hintLetterString!) == false
        {
            hintsGiven.append(hintLetterString!)
            alreadyInHintArray = false
        
      
            let ( _, hintIndexArray) = getHint
        
            for i in hintIndexArray
            {
                let cellPath = IndexPath(row: i, section: 0)
                let cell = userInputCollection.cellForItem(at: cellPath) as! colViewCell
              
                cell.inputCellButton.setTitle(hintLetterString, for: .disabled)
                userInputDictionary[userInputCollection.indexPath(for: cell)!] = hintLetterString
              
                if vowelPositionArray.contains(((userInputCollection.indexPath(for: cell) as NSIndexPath?)?.row)!) == true
                {
                  cell.inputCellButton.layer.backgroundColor = UIColor(white: 1.0, alpha: 0.0).cgColor
                }
                else
                {
                  cell.inputCellButton.layer.backgroundColor = UIColor.lightGray.cgColor
                }
                cell.inputCellButton.userHighlighted = false
                cell.inputCellButton.isEnabled = false
              
            }
          
            for i in (0..<keyboardCollectionView.visibleCells.count)
            {
              let cellPath = IndexPath(row: i, section: 0)
              let cell = keyboardCollection.cellForItem(at: cellPath) as! keyBoardViewCell
            
              if cell.keyBoardCellButton.titleLabel?.text == hintLetter
              {
                cell.keyBoardCellButton.isEnabled = false
              }
          }
        }
    }
   }
// if no hints have been given yet, check if the letter for the pulled hint is already correct and if not then give the hint and append the hint letter to the hints given array
   else
   {
    
    var inputCorrectTest: Bool = false
    
    while inputCorrectTest == false
    {
      let getHint = QuoteObject(seed: seed).getHint()
      let (hintLetter, _ ) = getHint
    
  //  print(hintLetter)
    
      let hintLetterString = String(hintLetter)
    
      if checkHintForCorrectAlready(hintLetterString!) == false
      {
        hintsGiven.append(hintLetterString!)
        inputCorrectTest = true
      
        let ( _, hintIndexArray) = getHint
    
  //  print(hintIndexArray)
    
        for i in hintIndexArray
        {
            let cellPath = IndexPath(row: i, section: 0)
            let cell = userInputCollection.cellForItem(at: cellPath) as! colViewCell
          
            cell.inputCellButton.setTitle(hintLetterString, for: .disabled)
            userInputDictionary[userInputCollection.indexPath(for: cell)!] = hintLetterString
          
            if vowelPositionArray.contains(((userInputCollection.indexPath(for: cell) as NSIndexPath?)?.row)!) == true
            {
              cell.inputCellButton.layer.backgroundColor = UIColor(white: 1.0, alpha: 0.0).cgColor
            }
            else
            {
              cell.inputCellButton.layer.backgroundColor = UIColor.lightGray.cgColor
            }
            cell.inputCellButton.userHighlighted = false
            cell.inputCellButton.isEnabled = false
          
        //    print(userInputDictionary)
          
        }
      //  print("keyboard collection visible cell count: ",keyboardCollection.visibleCells().count)
        for i in (0..<keyboardCollection.visibleCells.count)
        {
          let cellPath = IndexPath(row: i, section: 0)
          let cell = keyboardCollection.cellForItem(at: cellPath) as! keyBoardViewCell
          
       //   print("title label: ",cell.keyBoardCellButton.titleLabel?.text, "hintLetter :", hintLetter)
          
          if cell.keyBoardCellButton.titleLabel?.text == hintLetter
          {
              cell.keyBoardCellButton.isEnabled = false
          }
        }
      }
    }
  }
      
    // Once the hint has been given...
        let emptyCount = emptyCellCount()
      //  print("emptycount ",emptyCount)
        if emptyCount == quoteSpaceCount
        {
            resetCellColor()
            let correctAnswer = checkTheAnswer(lineAdjustedAnswerQuote)
        //    print(correctAnswer)
            if correctAnswer == true
            {
                userWins()
            }
        }
    }

  func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
    return UIModalPresentationStyle.none
  }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "quoteToQuoteWin"
        {
            let destination = segue.destination as! QuoteWinViewController
          
            let elapsedTime = stopTimer()
          
            destination.elapsedTime = elapsedTime
            destination.quoteLabelText = QuoteDictionary(seed: seed).generateQuote()
            destination.seedsPass = seedsUsed
            print("Seeds Sent: ",destination.seedsPass)
          
            destination.hintCount = hintsGiven.count
          
            destination.quoteDifficulty = quoteDifficulty
          
            destination.score = calculateScore()
          
          
          
          if gameMode == "Category"
          {
            // Save the completed quote
            getCompletedQuotes()
            
            if compQuoteList.contains(seed) == false
            {
                saveCompletedQuote(compQuoteSeed: seed,
                                   compQuoteDifficulty: quoteDifficulty,
                                   compQuoteScore: calculateScore(),
                                   compQuoteTime: elapsedSeconds(),
                                   compQuoteHintsUsed: hintsUsed,
                                   compQuoteCategory: Quote.getQuoteCategory())
            }
            
            // Update Completed Categories
            
             // get completed quote category names (needed to build completed categories list)
             getCompletedQuoteCategoryNames()
             
             // returns list of completed categories (without core data)
             compCategories = getCompletedCategories()
             
             // pull the current core data completed categories list
             fetchCompletedCategories()
             
             // save any new completed categories to core data
             saveCompletedCategories(categoriesToSave: compCategories)
             
 
            
          }
        }
        if segue.identifier == "newQuoteSegue"
        {
            let destination = segue.destination as! ViewController
            
            destination.seedsUsed = seedsUsed
            print(destination.seedsUsed)
        }
        if segue.identifier == "menuPopoverSegue"
        {
          let popoverViewController = segue.destination as! MenuViewController
          
          popoverViewController.delegate=self
          
          popoverViewController.popoverPresentationController?.delegate=self
          
          popoverViewController.currentSeed = seed
          
          popoverViewController.seedsPass = seedsUsed
          
          print("Current seed sent on popover view: ", popoverViewController.currentSeed)
          print("Seed list on popover view: ", popoverViewController.seedsPass)
        }
    }
    
    
    func returnIndices(_ symbol: String, localSymbolArray: [String]) -> [Int]
    {
        var tempIndexArray: [Int] = []
        var indexArray: [Int] = []
        var count: Int = 0
        
        for character in localSymbolArray
        {
            if character == symbol
            {
                tempIndexArray.append(count)
                count += 1
            }
            else
            {
                tempIndexArray.append(999)
                count += 1
            }
        }
        
        indexArray = tempIndexArray.filter { $0 != 999 }
        
        return indexArray
    }
    
    func randomSeed() -> Int
    {
        let seed = Int(arc4random_uniform(5))
        
        return seed
    }

func timeDiff(_ startTime: Date, endTime: Date) -> String
{
  let calendar = Calendar.current
  let flags = NSCalendar.Unit.second
  let components = (calendar as NSCalendar).components(flags, from: startTime, to: endTime, options: [])
  
  let secDiff = components.second
  
  var seconds = secDiff
  var minutes = 00
  var hours = 00
  
  if secDiff! >= 60
  {
    seconds = secDiff! % 60
    minutes = (secDiff! / 60) % 60
    hours = ((secDiff! / 60) / 60) % 60
  }
  
  let timeString = String(format: "%02d:%02d:%02d", hours, minutes, seconds!)
  
  return (timeString)
 
}

var counterStartTime = TimeInterval()


func updateTime()
{
  
  let currentTime = Date.timeIntervalSinceReferenceDate
  
  //Find the difference between current time and start time.
  
  var elapsedTime: TimeInterval = currentTime - counterStartTime
  
  //calculate the hours in elapsed time.
  
  let hours = Int((elapsedTime / 60.0) / 60.0)
  
  elapsedTime -= ((TimeInterval(hours) * 60) * 60)
  
  //calculate the minutes in elapsed time.
  
  let minutes = UInt8(elapsedTime / 60.0)
  
  elapsedTime -= (TimeInterval(minutes) * 60)
  
  //calculate the seconds in elapsed time.
  
  let seconds = UInt8(elapsedTime)
  
  elapsedTime -= TimeInterval(seconds)
  
  //find out the fraction of milliseconds to be displayed.
  
  //let fraction = UInt8(elapsedTime * 100)
  
  //add the leading zero for minutes, seconds and millseconds and store them as string constants
  
  let strHours = String(format: "%02d", hours)
  let strMinutes = String(format: "%02d", minutes)
  let strSeconds = String(format: "%02d", seconds)
  // let strFraction = String(format: "%02d", fraction)
  
  //concatenate minuets, seconds and milliseconds as assign it to the UILabel
  if hours < 100
  {
    displayTimeLabel.text = strHours + ":" + strMinutes + ":" + strSeconds
  }
  else
  {
    displayTimeLabel.text = "Need some hints?"
  }
}

var timer = Timer()

func startTimer()
{
  if !timer.isValid {
    let aSelector : Selector = #selector(ViewController.updateTime)
    timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: aSelector,     userInfo: nil, repeats: true)
    counterStartTime = Date.timeIntervalSinceReferenceDate
  }
}

func stopTimer() -> String
{
  let elapsedTime = displayTimeLabel.text
  timer.invalidate()
  return elapsedTime!
}
 
func invalidateTimer()
{
  timer.invalidate()
  
  if !timer.isValid
  {
    print("no valid timers")
  }
  else
  {
    print("timer still valid")
  }
}
/*
  
  @IBAction func start(sender: AnyObject) {
    if !timer.valid {
      let aSelector : Selector = #selector(SWViewController.updateTime)
      timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector,     userInfo: nil, repeats: true)
      startTime = NSDate.timeIntervalSinceReferenceDate()
    }
  }
  @IBAction func stop(sender: AnyObject) {
    timer.invalidate()
    //   timer == nil
  }
  
*/  
  
  func reset(){
    let alertController = UIAlertController(title: "Are you sure you want to reset?", message: "", preferredStyle: .alert)
    
    let cancelAction: UIAlertAction = UIAlertAction(title: "No", style: .cancel) { action -> Void in
    }
    alertController.addAction(cancelAction)
    
    let resetQuote: UIAlertAction = UIAlertAction(title: "Yes", style: .default) { action -> Void in
      
      let userInputCollection = self.view.viewWithTag(2) as! UICollectionView
      let keyboardCollection = self.view.viewWithTag(1) as! UICollectionView
      
      for cell in userInputCollection.visibleCells as! [colViewCell]
      {
        cell.inputCellButton.isEnabled = true
        
        if cell.inputCellButton.titleLabel!.text != " " && cell.inputCellButton.titleLabel!.text != "." && cell.inputCellButton.titleLabel!.text != "," && cell.inputCellButton.titleLabel!.text != "?" && cell.inputCellButton.titleLabel!.text != "!" && cell.inputCellButton.titleLabel!.text != "'"
          
        {
          cell.inputCellButton.setTitle("_", for: UIControlState())
        }
      }
      
      for cell in keyboardCollection.visibleCells as! [keyBoardViewCell]
      {
        cell.keyBoardCellButton.isEnabled = true
      }
      
      self.resetCellColor()
      self.userInputDictionary = [:]
      self.hintsGiven = []
      
    }
    alertController.addAction(resetQuote)
    
    
    self.present(alertController, animated: true, completion: nil)
  }
  
  
  func checkAnswers()
  {
    
    var userInputList: [String] = []
    var answerList: [String] = []
    
    for letter in lineAdjustedAnswerQuote.characters
    {
      answerList.append(String(letter))
    }
    
    let dictionaryIndexKeys = [IndexPath](userInputDictionary.keys)
    
    let sortedKeys = dictionaryIndexKeys.sorted {($0 as NSIndexPath).row < ($1 as NSIndexPath).row}
    
    for key in sortedKeys
    {
      userInputList.append(userInputDictionary[key]!)
    }
    
    
    var correctAnswers: [Int] = []
    var incorrectAnswers: [Int] = []
    
    for i in (0..<userInputList.count)
    {
      if userInputList[i] == answerList[i]
      {
        correctAnswers.append(i)
      }
      else
      {
        incorrectAnswers.append(i)
      }
    }
    
   let userInputCollection = self.view.viewWithTag(2) as! UICollectionView

    for i in correctAnswers
    {
      let cellPath = IndexPath(row: i, section: 0)
      let cell = userInputCollection.cellForItem(at: cellPath) as! colViewCell
      cell.inputCellButton.layer.backgroundColor = UIColor.lightGray.cgColor
      cell.inputCellButton.userHighlighted = false
      cell.inputCellButton.isEnabled = false
    }
    
    for i in incorrectAnswers
    {
      let cellPath = IndexPath(row: i, section: 0)
      let cell = userInputCollection.cellForItem(at: cellPath) as! colViewCell
      
      //cell.inputCellButton.titleLabel?.textColor = UIColor.redColor()
      if cell.inputCellButton.titleLabel?.text != "_"
      {
        cell.inputCellButton.setTitleColor(UIColor.red, for: UIControlState())
      }
      // add to user input button pressed if any color is redcolor then reset?
    }
  
  }
  
  func calculateScore() -> Int
  {
    
    hintsUsed = hintsGiven.count
    
    let score = quoteDifficulty - hintsUsed
    
    // Add in time element
    
    return score
  }
  
  func elapsedSeconds() -> Int
  {
    return 0
  }
 
  /********************
 
   Core Data Functions
   
  *********************/
  
  func getContext () -> NSManagedObjectContext {
    let CDStack = CoreDataStack()
    return CDStack.persistentContainer.viewContext
  }
  
  func saveCompletedQuote (compQuoteSeed: Int,
                           compQuoteDifficulty: Int,
                           compQuoteScore: Int,
                           compQuoteTime: Int,
                           compQuoteHintsUsed: Int,
                           compQuoteCategory: String)
  {
    let context = getContext()
    
    //retrieve the entity that we just created
    let entity =  NSEntityDescription.entity(forEntityName: "CdCompletedQuote", in: context)
    
    let transc = NSManagedObject(entity: entity!, insertInto: context)
    
    //set the entity values
    transc.setValue(compQuoteSeed,  forKey: "seed")
    transc.setValue(compQuoteDifficulty, forKey: "difficulty")
    transc.setValue(compQuoteScore,   forKey: "score")
    transc.setValue(compQuoteTime, forKey: "time")
    transc.setValue(compQuoteHintsUsed,   forKey: "hintsUsed")
    transc.setValue(compQuoteCategory, forKey: "category")
    
    //save the object
    do {
      try context.save()
      print("saved!")
    } catch let error as NSError  {
      print("Could not save \(error), \(error.userInfo)")
    } catch {
      
    }
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
 
  
  func getCompletedQuoteCategoryNames () {
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CdCompletedQuote")
    
    do {
      //go get the results
      let searchResults = try getContext().fetch(fetchRequest)
      
      //I like to check the size of the returned results!
      print ("num of results = \(searchResults.count)")
      
      //You need to convert to NSManagedObject to use 'for' loops
      for trans in searchResults as! [NSManagedObject] {
        
        compQuoteCategoryList.append(trans.value(forKey: "category") as! String)
        print("category: ", trans.value(forKey: "category") as Any)
        
      }
    } catch {
      print("Error with request: \(error)")
    }
  }
  
  
  func getCompletedCategories() -> [String]
  {
    // Get list of categories from quote dictionary
    let categoryList = quoteDict.listOfCategories()
    
    var compCategories: [String] = []
    
    // for each unique category in the list from the quote dictionary
    for category in categoryList
    {
      print("category in categoryList: ", category)
      // count of quotes in quote dictionary for a particular category
      let categoryQuoteCount = quoteDict.quotesFromSpecificCategory(category).count
      print("categoryQuoteCount: ", categoryQuoteCount)
      
      var compQuoteCategoryCount: [String] = []
      
      // get list of completed quotes in the category
      for compQuoteCategory in compQuoteCategoryList
      {
        print("compQuoteCategory: ", compQuoteCategory)
        if compQuoteCategory == category
        {
          compQuoteCategoryCount.append(compQuoteCategory)
        }
      }
      
      print("compQuoteCategoryCount: ",compQuoteCategoryCount)
      // append completed categories
      if compQuoteCategoryCount.count == categoryQuoteCount
      {
        print("equal")
        print("categoryQuoteCount: ", categoryQuoteCount)
        print("compQuoteCategoryCount.count: ", compQuoteCategoryCount.count)
        compCategories.append(category)
      }
    }
    
    return compCategories
    
    
  }
  
  // fetch completed categories
  func fetchCompletedCategories () {
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CdCompletedCategory")
    
    do {
      //go get the results
      let searchResults = try getContext().fetch(fetchRequest)
      
      //I like to check the size of the returned results!
      print ("num of results CD Categories = \(searchResults.count)")
      
      //You need to convert to NSManagedObject to use 'for' loops
      for trans in searchResults as! [NSManagedObject] {
        
        compCDCategoriesList.append(trans.value(forKey: "category") as! String)
        print("category: ", trans.value(forKey: "category") as Any)
        
      }
    } catch {
      print("Error with request: \(error)")
    }
  }
  
  // save completed categories not already in core data
  func saveCompletedCategories (categoriesToSave: [String])
  {
    let context = getContext()
    
    for category in categoriesToSave
    {
      if compCDCategoriesList.contains(category) == false
      {
        //retrieve the entity that we just created
        let entity =  NSEntityDescription.entity(forEntityName: "CdCompletedCategory", in: context)
        
        let transc = NSManagedObject(entity: entity!, insertInto: context)
        
        //set the entity values
        transc.setValue(category,  forKey: "category")
        
        
        //save the object
        do {
          try context.save()
          print("saved!")
        } catch let error as NSError  {
          print("Could not save \(error), \(error.userInfo)")
        } catch {
          
        }
      }
    }
  }
 
 
}
