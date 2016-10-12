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

    @IBOutlet weak var uberRequestButton: RideRequestButton!
    
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		// Acquire users' current location
		var paramsBuilder = RideParametersBuilder()
			.setDropoffLocation(CLLocation(latitude: 40.0611, longitude: 116.62117), nickname: "首都机场T3")
            .setPickupLocation(CLLocation(latitude: 39.971023, longitude: 116.303922), nickname: "蜂鸟")
        self.uberRequestButton.client = RidesClient()
        self.uberRequestButton.client!.fetchCheapestProduct(pickupLocation: CLLocation(latitude: 39.971023, longitude: 116.303922), completion: { [weak self] (product, response) in
            if let productId = product?.productID {
                paramsBuilder = paramsBuilder.setProductID(productId)
                self!.uberRequestButton.rideParameters = paramsBuilder.build()
                self!.uberRequestButton.loadRideInformation()
            }
        })
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}

