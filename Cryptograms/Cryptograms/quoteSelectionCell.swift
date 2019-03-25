//
//  quoteSelectionCell.swift
//  Depressing Quotes
//
//  Created by Daniel Katz on 10/1/16.
//  Copyright © 2016 OK. All rights reserved.
//

import UIKit

class quoteSelectionCell: UICollectionViewCell {
    @IBOutlet var quoteCompletionStatusLabel: UILabel!

    @IBOutlet var difficultyLabel: UILabel!
    
    @IBOutlet var quoteNameButton: UIButton!
    
    var seed: Int = 0
}
