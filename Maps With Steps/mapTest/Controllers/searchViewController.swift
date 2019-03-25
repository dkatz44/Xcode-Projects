//
//  searchViewController.swift
//  mapTest
//
//  Created by . on 6/17/18.
//  Copyright © 2018 OK. All rights reserved.
//

import UIKit
import MapKit

class SearchViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    @IBOutlet weak var statsLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet weak var searchResultsTableView: UITableView!
    @IBOutlet var centerButtonBarItem: UIBarButtonItem!
    
    @IBOutlet var searchBarItem: UISearchBar!
    @IBOutlet var resetButtonBarItem: UIBarButtonItem!
    @IBOutlet var routeButtonBarItem: UIBarButtonItem!
    @IBOutlet var saveButtonBarItem: UIBarButtonItem!
    @IBOutlet var settingsButtonBarItem: UIBarButtonItem!
    @IBOutlet var searchTableHeightConstraint: NSLayoutConstraint!
    
    
    var searchResultStartLat: CLLocationDegrees = 0
    var searchResultStartLong: CLLocationDegrees = 0

    var searchResultDestLat: CLLocationDegrees = 0
    var searchResultDestLong: CLLocationDegrees = 0
    
    var searchResultsDestName: String = ""
    
    let locationManager = CLLocationManager()
    
    // Walk & Run %
    @IBOutlet weak var walkPercentageLabel: UILabel!
    @IBOutlet weak var runPercentageLabel: UILabel!
    @IBOutlet weak var walkRunSlider: UISlider!
    var walkPercent = 100.0
    var runPercent = 0.0
    let walkStrideLength = 2.46
    let runStrideLength = 3.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
      //  button setImage:[[UIImage imageNamed:@"imageName.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
      
     // centerButtonBarItem.image = UIImage(named: "star-icon")
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        
        mapView.register(CustomAnnotationView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        statsLabel.layer.cornerRadius = 5
        statsLabel.clipsToBounds = true
        statsLabel.sizeToFit()
        
        self.searchCompleter.delegate = self
        
        let formattedString = NSMutableAttributedString()
        
        formattedString
            .bold("Distance\n")
            .normal("- Miles\n")
            .normal("- Feet\n")
            .normal("- Steps")
        
        self.statsLabel.attributedText = formattedString
        
        centerMapOnLocation(location: locationManager.location!)
        
    }
    
    let sliderStep: Float = 5
    
    @IBAction func walkRunSliderValueChanged(_ sender: UISlider) {
        
        let roundedValue = round(sender.value / sliderStep) * sliderStep
 //       sender.value = roundedValue
 //       let selectedValue = Float(sender.value)
        
        runPercent = Double(roundedValue)
        walkPercent = 100 - runPercent
        
        let runPercentText = String(Int(runPercent)) + "%"
        let walkPercentText = String( Int(walkPercent) ) + "%"
        
        runPercentageLabel.text = runPercentText
        walkPercentageLabel.text = walkPercentText
        
    }
    
    // Reset Button
    @IBAction func RemoveLines(_ sender: Any) {
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.removeOverlays(self.mapView.overlays)
        
        
        let formattedString = NSMutableAttributedString()
        
        formattedString
            .bold("Distance\n")
            .normal("- Miles\n")
            .normal("- Feet\n")
            .normal("- Steps")
        
        self.statsLabel.attributedText = formattedString
    }
    
    // Route Button
    @IBAction func addPolyline(_ sender: Any) {
        
        let formattedString = NSMutableAttributedString()
        
        var startLat = CLLocationDegrees()
        var startLong = CLLocationDegrees()
        var destLat = CLLocationDegrees()
        var destLong = CLLocationDegrees()
        
        if searchResultStartLat == 0 {
            startLat = (mapView.userLocation.location?.coordinate.latitude)!
        }
        else {
                startLat = searchResultStartLat
            }
        
        if searchResultStartLong == 0 {
            startLong = (mapView.userLocation.location?.coordinate.longitude)!
        }
        else{
                startLong = searchResultStartLong
            }

        if searchResultDestLat == 0 {
            destLat = 38.891988
        }
        else {
            destLat = searchResultDestLat
        }
        
        if searchResultDestLong == 0 {
            destLong = -77.080934
        }
        else{
            destLong = searchResultDestLong
        }
        
        print("Start Lat:",startLat)
        print("Start Long:",startLong)
        print("Dest Lat:",destLat)
        print("Dest Long:",destLong)
        
        
        let startAnnotation = CustomAnnotation(
            title: "Start",
            locationName: "Lat: " + String(startLat) + ", Long: " + String(startLong) ,
            discipline: "Start Point",
            coordinate: CLLocationCoordinate2D(latitude: startLat, longitude: startLong)
        )
        
        let destAnnotation = CustomAnnotation(
            title: "End",
            locationName: "Lat: " + String(destLat) + ", Long: " + String(destLong) ,
            discipline: "Dest Point",
            coordinate: CLLocationCoordinate2D(latitude: destLat, longitude: destLong)
        )
        
        let insets = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        
        
        let directionsRequest = getDirections(
            startLocation: CLLocationCoordinate2D(latitude: startLat, longitude: startLong),
            destLocation: CLLocationCoordinate2D(latitude: destLat, longitude: destLong))
        
        directionsRequest.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            for route in unwrappedResponse.routes {
                
                self.mapView.add(route.polyline)
                
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect,edgePadding: insets, animated: false)
                
                self.mapView.addAnnotation(startAnnotation)
                self.mapView.addAnnotation(destAnnotation)
                
                let miles = route.distance * 3.28084 / 5280
                let milesString = String(format: "%.1f", locale: Locale.current, miles)
                
                let feet = route.distance * 3.28084
                let feetString = String(format: "%.0f", locale: Locale.current, feet)
                
                let formattedWalkPercent = self.walkPercent/100
                let formattedRunPercent = self.runPercent/100
                
                let walkingFeet = (feet / self.walkStrideLength) * formattedWalkPercent
                let runningFeet = (feet / self.runStrideLength) * formattedRunPercent
                
                let steps = walkingFeet + runningFeet
                
                let stepsString = String(format: "%.0f", locale: Locale.current, steps)
                
                let minutes = Int(round(route.expectedTravelTime / 60))
                
                print("Distance: " + milesString + " Miles (" + feetString + " Feet)")
                print("Expected Time: " + String(minutes) + " Minutes")
                
                for step in route.steps {
                    if step.instructions != "" {
                        print(step.instructions + self.distanceFormat(distanceToFormat: step.distance))
                    }
                }
                
                formattedString
                    .bold("Distance\n")
                    .normal(milesString)
                    .normal(" Miles\n")
                    .normal(feetString)
                    .normal(" Feet\n")
                    .normal(stepsString)
                    .normal(" Steps")
                
                self.statsLabel.attributedText = formattedString
            }
        
    }
        
}
    
    func getDirections(startLocation: CLLocationCoordinate2D, destLocation: CLLocationCoordinate2D) -> MKDirections {
        
        let request = MKDirectionsRequest()
        
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: startLocation, addressDictionary: nil))
        
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destLocation, addressDictionary: nil))
        
        request.requestsAlternateRoutes = false
        
        // Options are: .automobile, .walking, .transit, .any
        request.transportType = .walking
        
        let directions = MKDirections(request: request)
        
        return directions
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor(    red: 25.0/255.0,
                                           green: 178.0/255.0,
                                           blue: 255.0/255.0,
                                           alpha: 1.0)
        renderer.lineWidth = 5.0
        return renderer
    }
    
        
        let regionRadius: CLLocationDistance = 200
        
        func centerMapOnLocation(location: CLLocation)
        {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                      regionRadius * 2.0, regionRadius * 2.0)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        /*
        // 1
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // 2
            guard let annotation = annotation as? CustomAnnotation else { return nil }
            // 3
            let identifier = "marker"
            var view: MKMarkerAnnotationView
            // 4
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKMarkerAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                // 5
                view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            return view
        }*/
        
        func distanceFormat(distanceToFormat: Double) -> String {
            
            let miles = distanceToFormat * 3.28084 / 5280
            let milesString = String(format: "%.1f", locale: Locale.current, miles)
            
            let feet = distanceToFormat * 3.28084
            let feetString = String(format: "%.0f", locale: Locale.current, feet)
            
            return " in " + milesString + " Miles (" + feetString + " Ft)"
        }
    
    
    @IBAction func centerOnUser(_ sender: Any) {
        
        centerMapOnLocation(location: mapView.userLocation.location!)
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       // let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
       // mapView.mapType = MKMapType.standard
        
       // let span = MKCoordinateSpanMake(0.05, 0.05)
       // let region = MKCoordinateRegion(center: locValue, span: span)
       // mapView.setRegion(region, animated: true)
        
       // let annotation = MKPointAnnotation()
       // annotation.coordinate = locValue
       // mapView.addAnnotation(annotation)
        
        //centerMap(locValue)
    }
/*
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! CustomAnnotation
        // let launchOptions = [MKLaunchOptionsDirectionsModeKey:
        //     MKLaunchOptionsDirectionsModeDriving]
        // location.mapItem().openInMaps(launchOptions: launchOptions)
    }*/
}
    

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchCompleter.queryFragment = searchText
    }
    
    //searchBarSearchButtonClicked instead?
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //myWebView.scalesPageToFit = true
        searchTableHeightConstraint.constant = 200
        searchBar.setShowsCancelButton(true, animated: true)
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        searchTableHeightConstraint.constant = 0
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
    //    searchBar.showsScopeBar = false
     //   searchBar.sizeToFit()
      //  searchBar.setShowsCancelButton(false, animated: true)
        
        return true
    }
    
}


extension SearchViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        searchResultsTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // handle error
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let completion = searchResults[indexPath.row]

        searchTableHeightConstraint.constant = 0
        searchBarItem.setShowsCancelButton(false, animated: true)
 
        searchBarItem.endEditing(true)
        
        let searchRequest = MKLocalSearchRequest(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            let coordinate = response?.mapItems[0].placemark.coordinate
            print(String(describing: coordinate))
            self.searchResultDestLat = (coordinate?.latitude)!
            self.searchResultDestLong = (coordinate?.longitude)!
            
            let searchResult = String(completion.title)
            let searchResultSubTitle = String(completion.subtitle)
            
            let destAnnotation = CustomAnnotation(
                title: searchResult,
                locationName: searchResultSubTitle, //"Lat: " + String(self.searchResultDestLat) + ", Long: " + String(self.searchResultDestLong) ,
                discipline: "Dest Point",
                coordinate: CLLocationCoordinate2D(latitude: self.searchResultDestLat, longitude: self.searchResultDestLong)
            )
            
            self.mapView.addAnnotation(destAnnotation)
            
            self.centerMapOnLocation(location: CLLocation(latitude: self.searchResultDestLat, longitude: self.searchResultDestLong))
        }
    }
}
