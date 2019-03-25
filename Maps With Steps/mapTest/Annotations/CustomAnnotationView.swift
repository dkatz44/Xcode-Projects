//
//  CustomAnnotationView.swift
//  mapTest
//
//  Created by . on 6/24/18.
//  Copyright © 2018 OK. All rights reserved.
//

import Foundation
import MapKit

/*class CustomAnnotationMarkerView: MKMarkerAnnotationView {
    
    override var annotation: MKAnnotation? {
        willSet {
            guard let customAnnotation = newValue as? CustomAnnotation else {return}
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
          //  rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
           // markerTintColor = customAnnotation.markerTintColor
        }
    }
}*/

class CustomAnnotationView: MKAnnotationView {
    
    override var annotation: MKAnnotation? {
        willSet {
            guard let customAnnotation = newValue as? CustomAnnotation else {return}
            
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)

            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            if customAnnotation.discipline == "Start Point"{
                image = UIImage(named: "placemark good")
            }
            else{
                image = UIImage(named: "Finish-Flag")
                
            }
            
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = customAnnotation.subtitle
            detailCalloutAccessoryView = detailLabel
        }
    }
    
}

