//
//  HomeScreenViewController.swift
//  Swift Test 2
//
//  Created by Daniel Katz on 3/6/16.
//  Copyright © 2016 OK. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController
{
  
    @IBOutlet var buttonView: UIView!
    @IBOutlet var categoriesButton: UIButton!
    @IBOutlet var quotesTitleImage: UIImageView!
    @IBOutlet var homeScreenGoat: UIImageView!

   
override func viewDidLoad() {
    //self.view.backgroundColor = UIColor.darkGrayColor()
    self.view.backgroundColor = UIColor.black
    self.quotesTitleImage.contentMode = UIViewContentMode.scaleAspectFit
    self.quotesTitleImage.image = UIImage(named: "QuotesTitle")
   // self.homeScreenGoat.image = UIImage(named: "Checkerboard")
    self.quotesTitleImage.layer.borderColor = UIColor.black.cgColor
    //self.view.addBackground()
    self.buttonView.layer.borderWidth = 3
    self.buttonView.layer.borderColor = UIColor(red:0/255.0, green:122/255.0, blue:255/255.0, alpha: 1.0).cgColor

}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
}

}

