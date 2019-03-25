//
//  StatsScreenViewController.swift
//  Depressing Quotes
//
//  Created by Daniel Katz on 11/2/16.
//  Copyright © 2016 OK. All rights reserved.
//

import UIKit
import CoreData

class StatsScreenViewController: UIViewController {

    var compQuoteList: [Int] = []
    var compQuoteDifficultyList: [Int] = []
    var compQuoteHintsUsedList: [Int] = []
    var compQuoteTimeList: [Int] = []
    var compQuoteScoreList: [Int] = []
    var compCategoryCount: Int = 0
    
    @IBOutlet var uniqueQuotesSolved: UILabel!
    @IBOutlet var categoriesCompleted: UILabel!
    @IBOutlet var highScore: UILabel!
    @IBOutlet var averageScore: UILabel!
    @IBOutlet var fastestSolve: UILabel!
    @IBOutlet var averageSolveTime: UILabel!
    @IBOutlet var averageDifficulty: UILabel!
    @IBOutlet var averageHintsUsed: UILabel!
    @IBOutlet var totalHintsUsed: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        getCompletedQuotes()
        compCategoryCount = fetchCompletedCategoryCount()
        
        if compQuoteList.count != 0
        {
            calcStats()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                
                compQuoteDifficultyList.append(trans.value(forKey: "difficulty") as! Int)
                print("difficulty: ", trans.value(forKey: "difficulty") as Any)
                
                compQuoteList.append(trans.value(forKey: "seed") as! Int)
                print("seed: ", trans.value(forKey: "seed") as Any)
                
                compQuoteScoreList.append(trans.value(forKey: "score") as! Int)
                print("score: ", trans.value(forKey: "score") as Any)
                
                compQuoteHintsUsedList.append(trans.value(forKey: "hintsUsed") as! Int)
                print("hintsUsed: ",trans.value(forKey: "hintsUsed") as Any)
                
                compQuoteTimeList.append(trans.value(forKey: "Time") as! Int)
                print("time: ", trans.value(forKey: "Time") as Any)

            }
        } catch {
            print("Error with request: \(error)")
        }
    }

    func average(numbers: [Int]) -> Int
    {
        var sum: Int = 0
        var avg: Int = 0
        
        if numbers.count != 0
        {
            for number in numbers
            {
                sum += number
            }
            
            avg = sum / numbers.count
        }
        
        return avg
    }
    
    func sumList(numbers: [Int]) -> Int
    {
        var sum: Int = 0
        
        if numbers.count != 0
        {
            for number in numbers
            {
                sum += number
            }
        }
        
        return sum
    }
    
    func calcStats()
    {
        // Quotes Completed
        uniqueQuotesSolved.text = String(compQuoteList.count)
        
        // Categories Completed
        categoriesCompleted.text = String(compCategoryCount)
        
        // High Score

            let highScoreInt = compQuoteScoreList.max()! as Int
        
            highScore.text = String(highScoreInt)
        
        // Average Score
        let averageScoreInt = average(numbers: compQuoteScoreList)
        
        averageScore.text = String(averageScoreInt)
        
        // Fastest Solve
        let minTime = compQuoteTimeList.min()! as Int
        
        fastestSolve.text = String(minTime)
        
        // Average Solve Time
        let averageTimeInt = average(numbers: compQuoteTimeList)
        
        averageSolveTime.text = String(averageTimeInt)
        
        
        // Average Difficulty
        let averageDifficultyInt = average(numbers: compQuoteDifficultyList)
        
        averageDifficulty.text = String(averageDifficultyInt)
        
        
        // Average Hints Used
        let averageHintsUsedInt = average(numbers: compQuoteHintsUsedList)
        
        averageHintsUsed.text = String(averageHintsUsedInt)
        
        // Total Hints Used
        let totalHintsUsedInt = sumList(numbers: compQuoteHintsUsedList)
        
        totalHintsUsed.text = String(totalHintsUsedInt)
        print("total hints used list: ", compQuoteHintsUsedList)
        
        
    }
    
    // fetch completed categories
    func fetchCompletedCategoryCount() -> Int {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CdCompletedCategory")
        
        var compCDCategoriesList: [String] = []
        var compCategoriesCount: Int = 0
        
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
        
        compCategoriesCount = compCDCategoriesList.count
        
        return compCategoriesCount
    }
    
    @IBAction func fetchData(_ sender: Any) {
        
        getCompletedQuotes()
        compCategoryCount = fetchCompletedCategoryCount()
        print(compCategoryCount)
        
    }

    func resetCoreData()
    {
        let context = getContext()
        
        let clearQuotes = NSFetchRequest<NSFetchRequestResult>(entityName: "CdCompletedQuote")
        let deleteQuotes = NSBatchDeleteRequest(fetchRequest: clearQuotes)

        let clearCategories = NSFetchRequest<NSFetchRequestResult>(entityName: "CdCompletedCategory")
        let deleteCategories = NSBatchDeleteRequest(fetchRequest: clearCategories)
        
        do {
            try context.execute(deleteQuotes)
            try context.execute(deleteCategories)
            try context.save()
        } catch {
            print("Error with save: \(error)")
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "statsResetButtonSegue"
        {
            resetCoreData()
        }
    }
}
