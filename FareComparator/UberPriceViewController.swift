//
//  UberPriceViewController.swift
//  FareComparator
//
//  Created by BK on 10/17/16.
//  Copyright © 2016 Bokang Huang. All rights reserved.
//

import UIKit
import UberRides
import DZNEmptyDataSet
import MJRefresh

class UberPriceViewController: UIViewController {

	let paramsBuilder = RideParametersBuilder()
	let rideClient = RidesClient()
	var uberPriceEstimate: [PriceEstimate] = []
	
	@IBOutlet weak var uberTableView: UITableView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        uberTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.loadPriceEstimate()
        }).then({ (header) in
            header.lastUpdatedTimeLabel.isHidden = true
            header.stateLabel.isHidden = true
        })
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		uberTableView.mj_header.beginRefreshing()
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadPriceEstimate() {
        if let parentVC = self.parent as? PriceCompareViewController {
            _ = paramsBuilder.setDropoffLocation(parentVC.userDropoffLocation)
            _ = paramsBuilder.setPickupLocation(parentVC.userPickupLocation)
            // Fetch price estimate
            self.rideClient.fetchPriceEstimates(pickupLocation: parentVC.userPickupLocation, dropoffLocation: parentVC.userDropoffLocation, completion: { [weak self](priceEstimates, response) in
                if response.error == nil {
                    self?.uberPriceEstimate = priceEstimates
                    DispatchQueue.main.async {
                        self?.uberTableView.reloadData()
                    }
                } else {
                    MessageUtil.showError(title: response.error?.code, message: response.error?.title)
                }
                self?.uberTableView.mj_header.endRefreshing()
            })
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

extension UberPriceViewController : UITableViewDelegate, UITableViewDataSource {
	
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

extension UberPriceViewController: DZNEmptyDataSetSource {
	
	// MARK: - DZNEmptyDataSetSource
	
	func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
		return R.image.confusedFace()
	}
	
}
