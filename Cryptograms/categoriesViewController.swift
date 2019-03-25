//
//  categoriesViewController.swift
//  Depressing Quotes
//
//  Created by Daniel Katz on 10/1/16.
//  Copyright © 2016 OK. All rights reserved.
//

import UIKit
import CoreData

class categoriesViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var backButton: UIButton!

    @IBOutlet var categoriesCollectionView: UICollectionView!
    
    
    @IBOutlet var collectionWidth: NSLayoutConstraint!
    
    let quoteDict = QuoteDictionary(seed: 0)
    
    var screenSize = UIScreen.main.bounds
    var screenWidth: CGFloat = 0.0
    var screenHeight: CGFloat = 0.0
    
    var buttonRow: Int = 0
    var categoryCell = categoriesCollectionViewCell()
    
    var compQuoteCategoryList: [String] = []
    
    var categoryList: [String] = []
    var compCategories: [String] = []
    
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
        categoriesCollectionView.layer.cornerRadius = 5
        
        categoryList = quoteDict.listOfCategories()
        fetchCompletedCategories()
    }
    
    
    override func viewDidLayoutSubviews() {
        
        let screenByFive = screenWidth / 5
        
        collectionWidth.constant = screenWidth - screenByFive
        
        categoriesCollectionView.layoutIfNeeded()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        let categoryCount = quoteDict.listOfCategories().count
        
        print("Category Count: ", categoryCount)
        
        return categoryCount
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
    //    print("sizeforitematIndexPath size", screenWidth)
        
        let w = categoriesCollectionView.frame.width - 20
        
        let h: CGFloat = 60.0
        
    //    print("sizeForItemAtIndexPath w: ", w, " h: ", h)
        
            return CGSize(width: w, height: h)
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
            let cell: categoriesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! categoriesCollectionViewCell
        
            cell.categoryNameButton.setTitle(categoryList[(indexPath as NSIndexPath).row], for: UIControlState())
        
            if compCategories.contains((cell.categoryNameButton.titleLabel?.text)!)
            {
                cell.categoryCompletionStatusLabel.text = "✔︎"
            }
            else
            {
                cell.categoryCompletionStatusLabel.text = " "
            }
        
        
            cell.categoryCompletionStatusLabel.layer.borderWidth = 3
            cell.categoryCompletionStatusLabel.layer.borderColor = UIColor.black.cgColor

            cell.layer.cornerRadius = 5
        
            cell.layer.backgroundColor = UIColor(red:1.0, green:1.0, blue:1.0, alpha:0.2).cgColor
        
        //    print("screen width", screenWidth)
        //    print("cell size h/w: ", cell.frame.height, cell.frame.width)
        
        //    print("indexPath: ",indexPath)
        
            cell.categoryNameButton.tag = (indexPath as NSIndexPath).row
        
        //    print("Index Path Row: ",cell.categoryNameButton.tag)

            cell.categoryNameButton.addTarget(self, action: #selector(categoriesViewController.buttonClicked(_:)), for: UIControlEvents.touchUpInside)
        
        
            return cell
    }
    
    func buttonClicked(_ sender:UIButton)
    {
        buttonRow = sender.tag
        print("button row: ", buttonRow)
        
        performSegue(withIdentifier: "categoriesToQuoteList", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
       if segue.identifier == "categoriesToQuoteList"
       {
            let quoteViewController = segue.destination as! pickAQuoteController
        
            let cellPath = IndexPath(row: buttonRow, section: 0)
       //     print("Cell path for button row: ", cellPath)
        
            categoryCell = categoriesCollectionView.cellForItem(at: cellPath) as! categoriesCollectionViewCell
        
            quoteViewController.selectedCategory = (categoryCell.categoryNameButton.titleLabel?.text)!
        
            print("Selected Category: ", quoteViewController.selectedCategory)
       }
    }

    func getContext () -> NSManagedObjectContext {
        let CDStack = CoreDataStack()
        return CDStack.persistentContainer.viewContext
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
                
                compCategories.append(trans.value(forKey: "category") as! String)
                print("category: ", trans.value(forKey: "category") as Any)
                
            }
        } catch {
            print("Error with request: \(error)")
        }
    }
    

    
}
