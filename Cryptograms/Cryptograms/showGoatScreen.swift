//
//  showGoatScreen.swift
//  Swift Test 2
//
//  Created by Daniel Katz on 3/24/16.
//  Copyright © 2016 OK. All rights reserved.
//

import UIKit
import Foundation

class showGoatScreen: UIViewController {

    
    @IBOutlet var GoatImage: UIImageView!
    override func viewDidLoad(){
        super.viewDidLoad()
      //  self.GoatImage.layer.shadowOffset = CGSizeMake(0, 1);
      //  self.GoatImage.layer.shadowOpacity = 1;
      //  self.GoatImage.layer.shadowRadius = 10.0;
        perform(#selector(showGoatScreen.showHomeScreen), with: nil, afterDelay: 5)
    }
 
    
    
    func showHomeScreen()
    {
        performSegue(withIdentifier: "showGoatScreen", sender: self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
