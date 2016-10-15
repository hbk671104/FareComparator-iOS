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
	let locationManager = AMapLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do avaradditional setup after loading the view.
        
        // Start user location request
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.locationTimeout = 5
        self.locationManager.reGeocodeTimeout = 5
        self.locationManager.requestLocation(withReGeocode: true) { (location, reGeocode, error) in
            if let err = error {
                MessageUtil.showError(title: "Error!", message: err.localizedDescription)
            } else {
                self.mainMapView.showsUserLocation = true
                self.mainMapView.setCenter(location!.coordinate, animated: true)
                self.mainMapView.setZoomLevel(15, animated: true)
            }
        }
        
		mainMapView.showsScale = true
		mainMapView.showsCompass = true
        // TODO: 换高德定位
        //mainMapView.showsUserLocation = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
