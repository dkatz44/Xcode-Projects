//
//  QuoteObject.swift
//  Swift Test 2
//
//  Created by Daniel Katz on 3/7/16.
//  Copyright © 2016 OK. All rights reserved.
//

import UIKit

/*
quote function list

getQuote()              --Gets and formats the initial quote
alphabetShuffle()       --Random number generator for coding the alphabet, returns an array of letters in random order
createCodeDictionary()  --Takes the random letters array, creates a dictionary and attaches symbols to the letters
quoteStringToChars()    --Takes the quote and turns it into an array of characters
codeTheQuote()          --Takes the quote and the code dictionary and returns the corresponding array of symbols (this is what should be passed to the inputCollection for cell creation
checkTheAnswer()        --Checks to see if the user entered the right quote when all input spaces are filled
*/

class QuoteObject: NSObject {
    
    var seed: Int
    
    init(seed: Int)
    {
        self.seed = seed
    }
    
    func formatQuote() -> String
    {
        let unformattedQuote = QuoteDictionary(seed: seed).generateQuote()
        
        let formattedQuote = unformattedQuote.uppercased()
        
        return formattedQuote
    }
    
    func formattedAnswerQuote() -> String
    {
        var unformattedQuote = QuoteDictionary(seed: seed).generateQuote()
        let characterArray = [",", ".", "!", "?", "'"]
            
        for chars in characterArray
        {
            let replaceQuote = unformattedQuote.replacingOccurrences(of: chars, with: " ")
            unformattedQuote = replaceQuote
        }
        
        let formattedQuote = unformattedQuote.uppercased()
        return formattedQuote
    }
    
    
    func lineAdjustedAnswerQuote() -> String
    {
        
        var lineAdjustedQuoteString = adjustedQuoteControl().joined(separator: "")
     //   print("Line adjusted quote string:",lineAdjustedQuoteString)
        let characterArray = [",", ".", "!", "?", "'"]
        
        for chars in characterArray
        {
            let replaceQuote = lineAdjustedQuoteString.replacingOccurrences(of: chars, with: " ")
            lineAdjustedQuoteString = replaceQuote
        }
        
        let formattedQuote = lineAdjustedQuoteString.uppercased()
        
      //  print("formatted lineAdjustedQuoteString",formattedQuote)
        return formattedQuote
        
    }
    
    func getQuoteSource() -> String
    {
    let Source = QuoteDictionary(seed: seed).quoteSource()
    
    return Source
    }
    
    func getQuoteCategory() -> String
    {
        let quoteCategory = QuoteDictionary(seed: seed).quoteCategory()
        
        return quoteCategory
    }
    
    func alphabetShuffle() -> Array<String>
    {
        var randomLetters: [String] = []
        
        let letters: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        
        while randomLetters.count < 26
        {
            
            let rand = Int(arc4random_uniform(26))
            
            let randLetter = letters.characters.index(letters.startIndex, offsetBy: rand)
            
            let randLetterPlusOne = letters.characters.index(letters.startIndex, offsetBy: rand + 1)
        //    let randLetterString = letters.substringWithRange(Range<String.Index>(start: randLetter, end: randLetterPlusOne))
            
            let randLetterString = letters.substring(with: Range<String.Index>(randLetter..<randLetterPlusOne))
            
            if randomLetters.contains(randLetterString) == false
            {
                randomLetters.append(randLetterString)
            }
        }
        return randomLetters
    }
    
    
    func createCodeDictionary (_ inputArray: Array<String>) -> Dictionary<String, String>
    {
        //let symbolList: [String] = ["👀", "🦄", "🐑" ,"🎃", "🔥", "🍕", "👾", "🎯", "☠️", "⚠️", "🔵", "❤️", "♦️", "🍉", "🎾", "👻", "💩", "👿", "📍", "🤖", "😡", "☃️", "📬", "😜", "🏈", "🌎"]
        
       // let symbolList: [String] = ["✔️", "➕", "➖", "➗", "✖️", "⚫️", "◼️", "♠️", "♣️", "💲", "🔲", "🔃", "D", "E", "F", "1", "2", "3", "4", "5", "6", "7","8","9","T","Y"]
        
        let symbolList: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V","W","X","Y","Z"]
        
        var symbolRandomDictionary: [String: String] = [:]
        
        for (index, element) in inputArray.enumerated()
        {
            symbolRandomDictionary[element] = symbolList[index]
        }
        
        return symbolRandomDictionary
    }
    
    func quoteStringToChars (_ inputQuote: String) -> Array<String>
    {
        
        let quoteCharacterArray = Array(inputQuote.characters)
        var quoteStringArray: [String] = []
        
        for characters in quoteCharacterArray
        {
            quoteStringArray.append(String(characters))
        }
        
        return quoteStringArray
        
    }
    
    func numberOfSpaces () -> Int
    {
        
        let lineAdjustedQuote = lineAdjustedAnswerQuote()
        
        let quoteCharacterArray = Array(lineAdjustedQuote.characters)
        

        var spaceCount: Int = 0
        for character in quoteCharacterArray
        {
            if character == " " || character == "," || character == "." || character == "!" || character == "?" || character == "'"
            {
            spaceCount += 1
            }
        }
        
        return spaceCount
    }
    
    
    func vowelPosition() -> [Int]
    {

    let lineAdjustedQuote = lineAdjustedAnswerQuote()
    
    let aArray: [Int] = lineAdjustedQuote.indicesOf("A")
    let eArray: [Int] = lineAdjustedQuote.indicesOf("E")
    let iArray: [Int] = lineAdjustedQuote.indicesOf("I")
    let oArray: [Int] = lineAdjustedQuote.indicesOf("O")
    let uArray: [Int] = lineAdjustedQuote.indicesOf("U")
    
    var vowelIndexArray: [Int] = aArray + eArray + iArray
    
    vowelIndexArray = vowelIndexArray + oArray + uArray
    vowelIndexArray = (vowelIndexArray.sorted(by: <))
    
        return vowelIndexArray
        
    }
    
    func letterPosition(_ letter: String) -> [Int]
    {
        let lineAdjustedQuote = lineAdjustedAnswerQuote()
        
        var letterArray: [Int] = lineAdjustedQuote.indicesOf(letter)
        
        letterArray = (letterArray.sorted(by: <))
        
        return letterArray
    }
    
    func getHint() -> (String, [Int])
    {
     //   let formattedQuote = formatQuote()
        let lineAdjustedQuote = lineAdjustedAnswerQuote()
        
        let quoteCharArray = quoteStringToChars(lineAdjustedQuote)
        let uniqueLettersSet = String(describing: Set(quoteCharArray))
        let uniqueLettersArray = [Character](uniqueLettersSet.characters)
        var arrayForRandom: [Character] = []
        
        for character in uniqueLettersArray
        {
            if character >= "A" && character <= "Z"
            {
                arrayForRandom.append(character)
            }
        }
        
        let count = arrayForRandom.count
        
        let rand = Int(arc4random_uniform(UInt32(count)))
     //   print(rand)

        let hintLetter = String(arrayForRandom[rand])
        
        let hintArray: [Int] = lineAdjustedQuote.indicesOf(hintLetter)
     //   print("indices",hintArray)
        let hintTuple = (hintLetter, hintArray)
        
        return hintTuple
    }
    
    
    func codeTheQuote (_ inputQuoteArray: Array<String>, inputCodeDictionary: Dictionary<String, String>) -> Array<String>
    {
        
        var codedQuote: [String] = []
        var symbol: String = ""
        
        
        
        for character in inputQuoteArray
        {
            if character == " " || character == "," || character == "." || character == "!" || character == "?" || character == "'"
            {
                codedQuote.append(String(character))
            }
            else
            {
                
                
                symbol = inputCodeDictionary[character]!
                codedQuote.append(symbol)
            }
        }
        
        return codedQuote
    }

    func shuffleCheck(_ plainQuote: Array<String>, codedQuote: Array<String>) -> Bool
    {
        
        var shuffled = false
        
        // Check if the plain letter == code letter
        
        var matchingChars: [String] = []
        
        for x in (0..<plainQuote.count)
        {
            if codedQuote[x] == plainQuote[x] && codedQuote[x] != " " && codedQuote[x] != "," && codedQuote[x] != "." && codedQuote[x] != "!" && codedQuote[x] != "?" && codedQuote[x] != "'"
            {
             //   print("plan letter code letter match: ", codedQuote[x])
                if matchingChars.contains(codedQuote[x]) == false
                {
                    matchingChars.append(codedQuote[x])
                }
            }
            else
            {
              //  print("special char or no match", codedQuote[x], plainQuote[x])
            }
        }
        
        if matchingChars.count == 0
        {
            shuffled = true
        }
        
        return shuffled
    }
    
    
    func quoteControl() -> Array<String>
    {
        
        var successfulShuffle: Bool = false
        
        let startingCount: Int = 10
        
        let plainQuote = formatQuote()
        
        let quoteAsChars = quoteStringToChars(plainQuote)
        
        var codedQuote: Array<String> = []
        
        while successfulShuffle == false
        {
            let shuffledAlphabet = alphabetShuffle()
        
            let codeDictionary = createCodeDictionary(shuffledAlphabet)
        
            let lineAdjustedQuote = adjustQuote(quoteAsChars, counter: startingCount)
 
            codedQuote = codeTheQuote(lineAdjustedQuote, inputCodeDictionary: codeDictionary)
            
            successfulShuffle = shuffleCheck(lineAdjustedQuote, codedQuote: codedQuote)
            
            if successfulShuffle == true
            {
                return codedQuote
            }
        }

        return codedQuote
    }
    
    
    func adjustedQuoteControl() -> Array<String>
    {
    
    let startingCount: Int = 10
    
    let plainQuote = formatQuote()
    
    let quoteAsChars = quoteStringToChars(plainQuote)
    
    let lineAdjustedQuote = adjustQuote(quoteAsChars, counter: startingCount)
      //  print(lineAdjustedQuote)
        return lineAdjustedQuote
    }

    
    func getSpaceIndices(_ inputString: [String]) -> [Int]
    {
        
        var spaceIndexArray: [Int] = []
        
        for i in 0 ..< inputString.count
        {
            if inputString[i] == " "
            {
                spaceIndexArray.append(i)
            }
        }
        
        return spaceIndexArray
    }
    
    func adjustQuote (_ inputQuote: [String], counter: Int) -> [String]
    {
    
    var quoteToAdjust = inputQuote
    var adjustedQuote: [String] = []
    let x = counter
    
    if x >= quoteToAdjust.count - 1
    {
        return quoteToAdjust
    }
        else
        {
            //   if lineposition[10] == space, then do nothing
            if quoteToAdjust[x] == " "
            {
                adjustedQuote = quoteToAdjust
              //  print("First Condition",x, adjustedQuote)
                return adjustQuote(adjustedQuote, counter: x + 11)
            }
            else
            {
                //   if lineposition[10] == letter && no letter after it, remove the space after it
                if quoteToAdjust[x] != " " && quoteToAdjust[x + 1] == " "
                {
                    quoteToAdjust.remove(at: x + 1)
                    adjustedQuote = quoteToAdjust
                 //   print("2nd Condition",x, adjustedQuote)
                    return adjustQuote(adjustedQuote, counter: x + 11)
                }
                    else
                    {
                        // if there are letters after lineposition[10], then we also have to check for letters before it
                        //  if lineposition[10] has at least one letter after it and NO letters before it, insert a space at lineposition[10]
                        if quoteToAdjust[x] != " " && quoteToAdjust[x + 1] != " " && quoteToAdjust[x - 1] == " "
                        {
                            quoteToAdjust.insert(" ", at: x)
                            adjustedQuote = quoteToAdjust
                       //     print("3rd Condition",x, adjustedQuote)
                            return adjustQuote(adjustedQuote, counter: x + 11)
                        }
                        else
                        {
                            //  if lineposition[10] has at least one letter after it and at least one letter before it, count the number of letters before it and insert a space for each letter before it + itself
                            if quoteToAdjust[x] != " " && quoteToAdjust[x + 1] != " " && quoteToAdjust[x - 1] != " "
                            {
                                // return the max space index that's less than 9
                                let spaceIndexArray = getSpaceIndices(quoteToAdjust)
                                var arrayForMaxVal: [Int] = []
    
                                for i in 0 ..< spaceIndexArray.count
                                {
                                    if spaceIndexArray[i] < (x - 1)
                                    {
                                        arrayForMaxVal.append(spaceIndexArray[i])
                                    }
                                }
    
                                let maxVal = arrayForMaxVal.max()
                                var i = Int(maxVal!)
                              //  print(i)
                                
                                if x - i < 11
                                {
                                while i <= (x - 1)
                                {
                                    quoteToAdjust.insert(" ", at: i)
                                    i += 1
                                }
                                    adjustedQuote = quoteToAdjust
                               //     print("4th Condition",x, adjustedQuote)
                                    return adjustQuote(adjustedQuote, counter: x + 11)
                                }
                                else{
                                adjustedQuote = quoteToAdjust
                             //   print("4th Condition",x, adjustedQuote)
                                return adjustQuote(adjustedQuote, counter: x + 11)
                                }
                            }
                        }
                }
            }
            
    adjustedQuote = quoteToAdjust
          //  print("random return ",adjustedQuote)
    return adjustedQuote

        }
}

        func getDifficulty() -> Int
        {
            var difficulty: Int = 0
            
            let quoteCharacterArray = Array(formattedAnswerQuote().characters)
            
 /*           for character in quoteCharacterArray
            {
                if character == " " || character == "," || character == "." || character == "!" || character == "?" || character == "'"
                {
                    spaceCount += 1
                }
            }
 */
            difficulty = quoteCharacterArray.count
            
            
            return difficulty
        }
    
        func getDifficultyText() -> String
        {
            var difficulty: Int = 0
            var difficultyText: String = "Easy"
            
            let quoteCharacterArray = Array(formattedAnswerQuote().characters)
            
            /*           for character in quoteCharacterArray
             {
             if character == " " || character == "," || character == "." || character == "!" || character == "?" || character == "'"
             {
             spaceCount += 1
             }
             }
             */
            difficulty = quoteCharacterArray.count
            
            if difficulty >= 40 && difficulty <= 70
            {
                difficultyText = "Medium"
            }
            else if difficulty > 70
            {
                difficultyText = "Hard"
            }
            print(difficultyText)
            return difficultyText
        }

    
}
