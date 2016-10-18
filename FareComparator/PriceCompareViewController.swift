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
    
    var userPickupLocation: CLLocation! = nil
    var userDropoffLocation: CLLocation! = nil
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func openDidi(_ sender: AnyObject) {
		DIOpenSDK.showDDPage(self, animated: true, params: nil, delegate: self)
	}
}

extension PriceCompareViewController: DIOpenSDKDelegate {

	// MARK: - DIOpenSDKDelegate 
	
	func diopensdkTopNavigationTheme() -> DITopNavigationTheme! {
		return DITopNavigationTheme().then { (theme) in
			theme.backgroundColor = UIColor.flatYellow
		}
	}
}
