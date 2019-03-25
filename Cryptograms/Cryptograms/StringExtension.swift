//
//  StringExtension.swift
//  Swift Test 2
//
//  Created by Daniel Katz on 3/12/16.
//  Copyright © 2016 OK. All rights reserved.
//

import Foundation

extension String {
    
    func indicesOf(_ searchTerm:String) -> [Int] {
        var indices = [Int]()
        var pos = self.startIndex
        while let range = self.range(of: searchTerm, range: pos ..< self.endIndex) {
            indices.append(self.characters.distance(from: self.startIndex, to: range.lowerBound))
            pos = self.index(after: range.lowerBound)
        }
        return indices;
    }
}


/*
 extension String {
 
 func indicesOf(searchTerm:String) -> [Int] {
 var indices = [Int]()
 var pos = self.startIndex
 while let range = self.rangeOfString(searchTerm, range: pos ..< self.endIndex) {
    indices.append(self.startIndex.distanceTo(range.startIndex))
 pos = range.startIndex.successor()
 }
 return indices;
 }
 }*/
