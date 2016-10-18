//
//  RideDetailTableViewCell.swift
//  FareComparator
//
//  Created by BK on 10/14/16.
//  Copyright © 2016 Bokang Huang. All rights reserved.
//

import UIKit
import UberRides
import SwiftyJSON

class RideDetailTableViewCell: UITableViewCell {

	var uberPriceEstimate: PriceEstimate? {
		didSet {
			if let estimate = uberPriceEstimate {
				var rideType = ""
				if estimate.name!.contains("Shared Ride") {
					rideType = "优步双人拼车"
				} else if estimate.name!.contains("Electric Vehicles") {
					rideType = "优步电动车"
				} else if estimate.name!.contains("People’s Uber") {
					rideType = "人民优步+"
				} else if estimate.name!.contains("uberX") {
					rideType = "优步优选轿车"
				} else if estimate.name!.contains("UBER XL") {
					rideType = "优步高级轿车"
				} else {
					rideType = "优步商务轿车"
				}
				rideTypeLabel.text = rideType
				timeEstimateLabel.text = "\(estimate.estimate!)"
			}
		}
	}
	var didiPriceEstimate: JSON? {
		didSet {
			if let estimate = didiPriceEstimate {
				var carType = ""
				switch estimate["car_type"].intValue {
				case 2:
					carType = "滴滴舒适专车"
				case 4:
					carType = "滴滴豪华专车"
				case 16:
					carType = "滴滴商务专车"
				case 64:
					carType = "滴滴普通快车"
				default:
					break
				}
				rideTypeLabel.text = carType
				timeEstimateLabel.text = "¥ \(estimate["estimate_price"].doubleValue / 100)"
			}
		}
	}
	@IBOutlet weak var rideTypeLabel: UILabel!
	@IBOutlet weak var timeEstimateLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
