//
//  MapViewController.swift
//  FareComparator
//
//  Created by BK on 10/14/16.
//  Copyright © 2016 Bokang Huang. All rights reserved.
//

import UIKit
import SwiftLocation

class MapViewController: UIViewController {

	@IBOutlet weak var mainMapView: MAMapView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		mainMapView.showsScale = true
		mainMapView.showsCompass = true
        // TODO: 换高德定位
		_ = Location.getLocation(withAccuracy: .block, onSuccess: { (location) in
            self.mainMapView.showsUserLocation = true
            self.mainMapView.setCenter(location.coordinate, animated: true)
            self.mainMapView.setZoomLevel(15, animated: true)
            }, onError: { (location, error) in
                MessageUtil.showError(title: "Error", message: error.description)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
