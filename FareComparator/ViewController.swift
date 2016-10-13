//
//  ViewController.swift
//  FareComparator
//
//  Created by BK on 10/12/16.
//  Copyright © 2016 Bokang Huang. All rights reserved.
//

import UIKit
import UberRides
import SwiftLocation
import CoreLocation

class ViewController: UIViewController {
    
    let paramsBuilder = RideParametersBuilder()
    let rideClient = RidesClient()
    @IBOutlet weak var requestUberButton: UIButton!
    @IBOutlet weak var rideTypeLabel: UILabel!
    @IBOutlet weak var estimatedTimeLabel: UILabel!
    
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
        self.requestUberButton.isEnabled = false
		// Acquire users' current location
		_ = paramsBuilder.setDropoffLocation(CLLocation(latitude: 40.0611, longitude: 116.62117))
		_ = Location.getLocation(withAccuracy: .block, onSuccess: { (location) in
			_ = self.paramsBuilder.setPickupLocation(location)
            self.requestUberButton.isEnabled = true
            // Fetch cheapest product
            self.rideClient.fetchCheapestProduct(pickupLocation: location, completion: { (uberProduct, response) in
                if let productId = uberProduct?.productID {
                    _ = self.paramsBuilder.setProductID(productId)
                    // Fetch time estimate
                    self.rideClient.fetchTimeEstimates(pickupLocation: location, completion: { (timeEstimates, response) in
                        self.estimatedTimeLabel.text = "\(timeEstimates[0].estimate)s"
                        self.rideTypeLabel.text = timeEstimates[0].name
                    })
                    // Fetch price estimate
                    self.rideClient.fetchPriceEstimates(pickupLocation: location, dropoffLocation: CLLocation(latitude: 40.0611, longitude: 116.62117), completion: { (priceEstimates, response) in
                        print(priceEstimates)
                    })
                }
            })
			}) { (location, locationError) in
				print(locationError.description)
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	
	@IBAction func login(_ sender: AnyObject) {
		let rideRequestViewController = RideRequestViewController(rideParameters: paramsBuilder.build(), loginManager: LoginManager())
		self.navigationController?.pushViewController(rideRequestViewController, animated: true)
	}
    
}
