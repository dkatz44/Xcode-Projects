//
//  LaunchBackground.swift
//  Swift Test 2
//
//  Created by Daniel Katz on 3/29/16.
//  Copyright © 2016 OK. All rights reserved.

import Foundation
import UIKit

extension UIView {
    func addLaunchBackground() {
        // screen width and height:
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
        imageViewBackground.image = UIImage(named: "Checkerboard")
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
        
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }}