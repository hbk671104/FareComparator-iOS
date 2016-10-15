//
//  MapViewController.swift
//  FareComparator
//
//  Created by BK on 10/14/16.
//  Copyright © 2016 Bokang Huang. All rights reserved.
//

import UIKit
import Then

class MapViewController: UIViewController {

	@IBOutlet weak var mainMapView: MAMapView!
    let poiSearchManager = AMapSearchAPI()
    var hasUserLocation = false
    var searchController : UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do avaradditional setup after loading the view.
        
        // Search controller init
        let poiSearchResultVC = R.storyboard.main.pOISearchResultViewController()
        searchController = UISearchController(searchResultsController: poiSearchResultVC)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = poiSearchResultVC
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
        
        // Map init
		mainMapView.showsScale = true
		mainMapView.showsCompass = true
        mainMapView.showsUserLocation = true
        mainMapView.setUserTrackingMode(.follow, animated: true)
        mainMapView.delegate = self
        
        // Search
        poiSearchManager?.delegate = self
        let keywordRequest = AMapPOIKeywordsSearchRequest().then { (request) in
            request.city = "北京"
            request.keywords = "立方庭"
        }
        poiSearchManager?.aMapPOIKeywordsSearch(keywordRequest)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK - IB Action
    
    @IBAction func locateUser(_ sender: AnyObject) {
        mainMapView.resetUserLocation(userLocation: mainMapView.userLocation.location)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == R.segue.mapViewController.priceComparePush.identifier {
//            let destVC = segue.destination as! PriceCompareViewController
//            destVC.userDropoffLocation = CLLocation(latitude: 40.0611, longitude: 116.62117)
//            if mainMapView.userLocation != nil {
//                destVC.userPickupLocation = mainMapView.userLocation.location
//            }
//        }
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

extension MapViewController: MAMapViewDelegate {

    // MARK: - MAMapViewDelegate
    
    func mapView(_ mapView: MAMapView!, didFailToLocateUserWithError error: Error!) {
        MessageUtil.showError(title: "用户定位错误", message: error.localizedDescription)
    }
    
    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
        if !hasUserLocation {
            mainMapView.resetUserLocation(userLocation: userLocation.location)
            hasUserLocation = !hasUserLocation
        }
    }
    
}

extension MapViewController: AMapSearchDelegate {
    
    // MARK: - AMapSearchDelegate 
    
    func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
        MessageUtil.showError(title: "POI检索错误", message: error.localizedDescription)
    }
    
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        if response.count == 0 {
            MessageUtil.showError(title: "抱歉", message: "没有找到搜索地点")
            return
        }
    }
    
}
