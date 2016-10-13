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
    @IBOutlet weak var requestUberButton: UIButton!
    
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
        self.requestUberButton.isEnabled = false
		// Acquire users' current location
		_ = paramsBuilder.setDropoffLocation(CLLocation(latitude: 40.0611, longitude: 116.62117))
		_ = Location.getLocation(withAccuracy: .block, onSuccess: { (location) in
			_ = self.paramsBuilder.setPickupLocation(location)
            self.requestUberButton.isEnabled = true
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
