//
//  MapViewController.swift
//  FareComparator
//
//  Created by BK on 10/14/16.
//  Copyright © 2016 Bokang Huang. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

	@IBOutlet weak var mainMapView: MAMapView!
    var userCurrentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do avaradditional setup after loading the view.
        
        // Map init
		mainMapView.showsScale = true
		mainMapView.showsCompass = true
        mainMapView.showsUserLocation = true
        mainMapView.setUserTrackingMode(.follow, animated: true)
        mainMapView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK - IB Action
    
    @IBAction func locateUser(_ sender: AnyObject) {
        mainMapView.resetUserLocation(userLocation: userCurrentLocation)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.mapViewController.priceComparePush.identifier {
            let destVC = segue.destination as! PriceCompareViewController
            destVC.userDropoffLocation = CLLocation(latitude: 40.0611, longitude: 116.62117)
            if mainMapView.userLocation != nil {
                destVC.userPickupLocation = mainMapView.userLocation.location
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MapViewController: MAMapViewDelegate {

    // MARK: - MAMapViewDelegate
    
    func mapView(_ mapView: MAMapView!, didFailToLocateUserWithError error: Error!) {
        MessageUtil.showError(title: "Error", message: error.localizedDescription)
    }
    
    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
        if userCurrentLocation == nil {
            mainMapView.resetUserLocation(userLocation: userLocation.location)
        }
        userCurrentLocation = userLocation.location
    }
    
}
