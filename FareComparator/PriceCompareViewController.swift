//
//  PriceCompareViewController.swift
//  FareComparator
//
//  Created by BK on 10/12/16.
//  Copyright © 2016 Bokang Huang. All rights reserved.
//

import UIKit
import UberRides

class PriceCompareViewController: UIViewController {
    
    let paramsBuilder = RideParametersBuilder()
    let rideClient = RidesClient()
    var userPickupLocation: CLLocation! = nil
    var userDropoffLocation: CLLocation! = nil
	var uberPriceEstimate: [PriceEstimate] = []
	
	@IBOutlet weak var uberTableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		// Params init
		_ = paramsBuilder.setDropoffLocation(userDropoffLocation)
        _ = paramsBuilder.setPickupLocation(userPickupLocation)
        // Fetch price estimate
        self.rideClient.fetchPriceEstimates(pickupLocation: userPickupLocation, dropoffLocation: userDropoffLocation, completion: { (priceEstimates, response) in
            if response.error == nil {
                self.uberPriceEstimate = priceEstimates
                DispatchQueue.main.async {
                    self.uberTableView.reloadData()
                }
            } else {
                MessageUtil.showError(title: response.error?.code, message: response.error?.title)
            }
        })
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
}

extension PriceCompareViewController : UITableViewDelegate, UITableViewDataSource {
	
	// MARK: - UITableViewDataSource
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.uberPriceEstimate.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let rideDetailCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.rideDetailCell, for: indexPath)!
		rideDetailCell.priceEstimate = self.uberPriceEstimate[indexPath.row]
		return rideDetailCell
	}
	
	// MARK: - UITableViewDelegate
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let priceEstimate = self.uberPriceEstimate[indexPath.row]
		_ = paramsBuilder.setProductID(priceEstimate.productID!)
		let rideRequestViewController = RideRequestViewController(rideParameters: paramsBuilder.build(), loginManager: LoginManager())
		rideRequestViewController.title = "优步叫车"
		self.navigationController?.pushViewController(rideRequestViewController, animated: true)
	}
	
}
