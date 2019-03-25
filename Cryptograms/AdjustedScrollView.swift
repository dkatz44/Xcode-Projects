//
//  AdjustedScrollView.swift
//  Swift Test 2
//
//  Created by Daniel Katz on 4/17/16.
//  Copyright © 2016 OK. All rights reserved.
//

import Foundation
import UIKit

class AdjustedScrollView: UIScrollView {

     CGRect contentRect = CGRectZero;
     for each view as UIView in self.subviews
     contentRect = CGRectUnion(contentRect, view.frame);
     self.contentSize = contentRect.size;

    
}
