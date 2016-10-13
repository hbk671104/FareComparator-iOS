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
    let paramsBuilder = RideParametersBuilder()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		// Acquire users' current location
		_ = paramsBuilder.setDropoffLocation(CLLocation(latitude: 40.0611, longitude: 116.62117), nickname: "首都机场T3")
		_ = Location.getLocation(withAccuracy: .block, onSuccess: { (location) in
			_ = self.paramsBuilder.setPickupLocation(location)
			self.uberRequestButton.client = RidesClient()
			self.uberRequestButton.client!.fetchCheapestProduct(pickupLocation: location, completion: { (product, response) in
				if let productId = product?.productID {
					_ = self.paramsBuilder.setProductID(productId)
					self.uberRequestButton.rideParameters = self.paramsBuilder.build()
					self.uberRequestButton.delegate = self
					self.uberRequestButton.loadRideInformation()
				}
				})
			}) { (location, locationError) in
				print(locationError.description)
		}
//		let rideRequestView = RideRequestView(rideParameters: paramsBuilder.build(), frame: self.view.bounds)
//		self.view.addSubview(rideRequestView)
//		rideRequestView.load()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	
	@IBAction func login(_ sender: AnyObject) {
		let rideRequestViewController = RideRequestViewController(rideParameters: paramsBuilder.build(), loginManager: LoginManager())
		self.present(rideRequestViewController, animated: true, completion: nil)
	}
}

extension ViewController : RideRequestButtonDelegate {
	
	// MARK: - RideRequestButtonDelegate
	
	func rideRequestButtonDidLoadRideInformation(_ button: RideRequestButton) {
		print(button.rideParameters.dropoffNickname)
	}
	
	func rideRequestButton(_ button: RideRequestButton, didReceiveError error: RidesError) {
		print(error.title)
	}
	
}
