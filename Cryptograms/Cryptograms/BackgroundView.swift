//
//  BackgroundView.swift
//  Swift Test 2
//
//  Created by Daniel Katz on 3/29/16.
//  Copyright © 2016 OK. All rights reserved.
//

import UIKit

@IBDesignable

class BackgroundView: UIView {
    
    //1
    @IBInspectable var lightColor: UIColor = UIColor.orange
    @IBInspectable var darkColor: UIColor = UIColor.yellow
    @IBInspectable var patternSize:CGFloat = 200
    
    override func draw(_ rect: CGRect) {
        //2
        let context = UIGraphicsGetCurrentContext()
        
        //3
        context?.setFillColor(darkColor.cgColor)
        
        //4
        context?.fill(rect)
        
        let drawSize = CGSize(width: patternSize, height: patternSize)
        
        //insert code here
        
        UIGraphicsBeginImageContextWithOptions(drawSize, true, 0.0)
        let drawingContext = UIGraphicsGetCurrentContext()
        
        //set the fill color for the new context
        darkColor.setFill()
        drawingContext?.fill(CGRect(x: 0, y: 0, width: drawSize.width, height: drawSize.height))
        
        
        let trianglePath = UIBezierPath()
        //Top Square
        //1
        trianglePath.move(to: CGPoint(x:0, y:0))
        
        //2
        trianglePath.addLine(to: CGPoint(x:0, y:drawSize.height/2))
        
        //3
        trianglePath.addLine(to: CGPoint(x:drawSize.width/2, y:drawSize.height/2))
        
        //4
        trianglePath.addLine(to: CGPoint(x:drawSize.width/2, y:0))
        
        //5
        trianglePath.addLine(to: CGPoint(x:0, y:0))
        
        //6
        trianglePath.move(to: CGPoint(x:drawSize.width/2, y:drawSize.height/2))
       /*
        //Bottom Square
        //5
        trianglePath.addLineToPoint(CGPoint(x: drawSize.width/2, y: drawSize.height))
        
        //6
        trianglePath.addLineToPoint(CGPoint(x: drawSize.width, y: drawSize.height))
        
        //7
        trianglePath.moveToPoint(CGPoint(x: drawSize.width, y: drawSize.height/2))
        
        //8
        trianglePath.addLineToPoint(CGPoint(x:drawSize.width/2, y:drawSize.height/2))
       
        //9
        trianglePath.addLineToPoint(CGPoint(x: drawSize.width, y: drawSize.height))
      */  
        lightColor.setFill()
        trianglePath.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIColor(patternImage: image!).setFill()
        context?.fill(rect)

    }
}
