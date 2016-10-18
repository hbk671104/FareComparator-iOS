//
//  DidiPriceViewController.swift
//  FareComparator
//
//  Created by BK on 10/18/16.
//  Copyright © 2016 Bokang Huang. All rights reserved.
//

import UIKit
import SwiftyJSON
import DZNEmptyDataSet
import MJRefresh

class DidiPriceViewController: UIViewController {

	@IBOutlet weak var didiTableView: UITableView!
	var priceQueryParams: [String: String] = [:]
	var didiPriceEstimate: [JSON] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		didiTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
			self.loadPriceEstimate()
		}).then({ (header) in
			header.lastUpdatedTimeLabel.isHidden = true
			header.stateLabel.isHidden = true
		})
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		didiTableView.mj_header.beginRefreshing()
	}

	func loadPriceEstimate() {
		if let parentVC = self.parent as? PriceCompareViewController {
			// Fetch price estimate
			priceQueryParams = ["fromlat": "\(parentVC.userPickupLocation.coordinate.latitude)",
			                    "fromlng": "\(parentVC.userPickupLocation.coordinate.longitude)",
			                    "tolat": "\(parentVC.userDropoffLocation.coordinate.latitude)",
			                    "tolng": "\(parentVC.userDropoffLocation.coordinate.longitude)",
			                    "maptype": "soso"]
			let total = 4
			var count = total
			var tempEstimate: [JSON] = []
			var tempCarTypePool: [Int] = []
			for i in 1...total {
				priceQueryParams["biz"] = "\(i)"
				DIOpenSDK.asyncCallOpenAPI("getEstimatePrice", params: priceQueryParams, resultBlock: { [weak self] (error, baseModel) in
					if error == nil {
						if let array = baseModel?.data["price"] as? NSArray {
							for price in array {
								let json = JSON(price)
								if !tempCarTypePool.contains(json["car_type"].intValue) {
									tempCarTypePool.append(json["car_type"].intValue)
									tempEstimate.append(json)
								}
							}
						}
					} else {
						MessageUtil.showError(title: "Error", message: error?.localizedDescription)
					}
					count -= 1
					if count == 1 {
						self?.didiPriceEstimate = tempEstimate
						self?.didiPriceEstimate.sort(by: { (j1, j2) -> Bool in
							return j1["estimate_price"].intValue < j2["estimate_price"].intValue
						})
						self?.didiTableView.reloadData()
						self?.didiTableView.mj_header.endRefreshing()
					}
				})
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

extension DidiPriceViewController: DIOpenSDKDelegate {
	
	// MARK: - DIOpenSDKDelegate
	
	func diopensdkTopNavigationTheme() -> DITopNavigationTheme! {
		return DITopNavigationTheme().then { (theme) in
			theme.backgroundColor = UIColor.flatYellow
		}
	}
}

extension DidiPriceViewController : UITableViewDelegate, UITableViewDataSource {
	
	// MARK: - UITableViewDataSource
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.didiPriceEstimate.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let rideDetailCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.rideDetailCell, for: indexPath)!
		rideDetailCell.didiPriceEstimate = self.didiPriceEstimate[indexPath.row]
		return rideDetailCell
	}
	
	// MARK: - UITableViewDelegate
	
//	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		let priceEstimate = self.uberPriceEstimate[indexPath.row]
//		_ = paramsBuilder.setProductID(priceEstimate.productID!)
//		let rideRequestViewController = RideRequestViewController(rideParameters: paramsBuilder.build(), loginManager: LoginManager())
//		rideRequestViewController.title = "优步叫车"
//		self.navigationController?.pushViewController(rideRequestViewController, animated: true)
//	}
	
}

extension DidiPriceViewController: DZNEmptyDataSetSource {
	
	// MARK: - DZNEmptyDataSetSource
	
	func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
		return R.image.confusedFace()
	}
	
}
