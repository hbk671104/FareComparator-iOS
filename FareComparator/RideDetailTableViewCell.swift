//
//  RideDetailTableViewCell.swift
//  FareComparator
//
//  Created by BK on 10/14/16.
//  Copyright © 2016 Bokang Huang. All rights reserved.
//

import UIKit
import UberRides

class RideDetailTableViewCell: UITableViewCell {

	var priceEstimate: PriceEstimate? {
		didSet {
			if let estimate = priceEstimate {
				rideTypeLabel.text = estimate.name
				timeEstimateLabel.text = "\(estimate.estimate!)"
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
