//
//  UIViewExtension.swift
//  Swift Test 2
//
//  Created by Daniel Katz on 3/12/16.
//  Copyright © 2016 OK. All rights reserved.
//

import Foundation

import UIKit

extension UIView {
    
    func parentViewOfType<T>(_ type: T.Type) -> T? {
        var currentView = self
        while currentView.superview != nil {
            if currentView is T {
                return currentView as? T
            }
            currentView = currentView.superview!
        }
        return nil
    }
    
}
