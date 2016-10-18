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
				rideTypeLabel.text = estimate.name
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
					carType = "滴滴舒适"
				case 4:
					carType = "滴滴豪华"
				case 16:
					carType = "滴滴商务"
				case 64:
					carType = "滴滴快车"
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
