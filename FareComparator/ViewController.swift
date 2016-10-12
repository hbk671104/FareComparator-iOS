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

	@IBOutlet weak var rideRequestButton: RideRequestButton!
	let ridesClient = RidesClient()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		// Acquire users' current location
		let paramsBuilder = RideParametersBuilder()
			.setDropoffLocation(CLLocation(latitude: 40.0611, longitude: 116.62117), nickname: "首都机场T3")
		_ = Location.getLocation(withAccuracy: .block, onSuccess: { [weak self] (location) in
			self!.ridesClient.fetchCheapestProduct(pickupLocation: location, completion: { (product, response) in
				//print(product.pro)
			})
			}) { (location, error) in
				print(error.description)
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

