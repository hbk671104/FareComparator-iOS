//
//  MapViewController.swift
//  FareComparator
//
//  Created by BK on 10/14/16.
//  Copyright © 2016 Bokang Huang. All rights reserved.
//

import UIKit
import Then
import IBAnimatable

class MapViewController: UIViewController {

	@IBOutlet weak var mainMapView: MAMapView!
	@IBOutlet weak var locateUserButton: AnimatableButton!
    @IBOutlet weak var comparePriceButton: AnimatableButton!
    
    // Search
    let poiSearchManager = AMapSearchAPI()
    let poiSearchRequest = AMapPOIKeywordsSearchRequest()
    
    // Child controllers
    let poiSearchResultController = R.storyboard.main.pOISearchResultViewController()
    var searchController : UISearchController!
    
    // Selected destination
    var userSelectedDestination: AMapPOI? {
        didSet {
            if let poi = userSelectedDestination {
                let pointAnnotation = MAPointAnnotation()
                pointAnnotation.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(poi.location.latitude), CLLocationDegrees(poi.location.longitude))
                pointAnnotation.title = poi.name
                pointAnnotation.subtitle = poi.address
                if !mainMapView.annotations.isEmpty {
                    for anno in mainMapView.annotations {
                        if anno is MAPointAnnotation {
                            mainMapView.removeAnnotation(anno as! MAPointAnnotation)
                        }
                    }
                }
                mainMapView.addAnnotation(pointAnnotation)
                mainMapView.showAnnotations(mainMapView.annotations, animated: true)
                comparePriceButton.isEnabled = true
                comparePriceButton.delay = 1.0
                comparePriceButton.pop(repeatCount: 1)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do avaradditional setup after loading the view.
        
        // Search controller init
        searchController = UISearchController(searchResultsController: poiSearchResultController)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "请输入目的地..."
		searchController.searchBar.barTintColor = UIColor.flatYellow
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
        
        // Map init
		mainMapView.showsScale = true
		mainMapView.showsCompass = true
        mainMapView.showsUserLocation = true
        mainMapView.setUserTrackingMode(.follow, animated: true)
        mainMapView.delegate = self
        
        // Search manager init
        poiSearchManager?.delegate = self
        
        // Search request init
        poiSearchRequest.cityLimit = true
		
		// Navigation item
		let imageView = UIImageView(frame: CGRect(origin: CGPoint.zero, size:CGSize(width: 35, height: 35)))
		imageView.image = R.image.bartLogo()
		let barButtonItem = UIBarButtonItem(customView: imageView)
		self.navigationItem.leftBarButtonItem = barButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK - IB Action
    
    @IBAction func locateUser(_ sender: AnyObject) {
		locateUserButton.tintColor = self.view.tintColor
        mainMapView.resetUserLocation(userLocation: mainMapView.userLocation.location)
    }
    
    @IBAction func startPriceCompare(_ sender: AnyObject) {
        self.performSegue(withIdentifier: R.segue.mapViewController.priceComparePush, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.mapViewController.priceComparePush.identifier {
            let destVC = segue.destination as! PriceCompareViewController
            destVC.userDropoffLocation = CLLocation(latitude: CLLocationDegrees(userSelectedDestination!.location.latitude), longitude:CLLocationDegrees(userSelectedDestination!.location.longitude))
			destVC.userPickupLocation = mainMapView.userLocation.location
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

extension MapViewController: MAMapViewDelegate {

    // MARK: - MAMapViewDelegate
	
	func mapView(_ mapView: MAMapView!, mapWillMoveByUser wasUserAction: Bool) {
		if wasUserAction {
			locateUserButton.tintColor = UIColor.flatGray
		}
	}
	
    func mapView(_ mapView: MAMapView!, didFailToLocateUserWithError error: Error!) {
        MessageUtil.showError(title: "用户定位错误", message: error.localizedDescription)
    }
    
    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
        if poiSearchRequest.city.isEmpty, updatingLocation {
			mapView.bringSubview(toFront: locateUserButton)
            mapView.bringSubview(toFront: comparePriceButton)
			locateUserButton.tintColor = self.view.tintColor
            mapView.resetUserLocation(userLocation: userLocation.location)
            // Regeocode
            let reGeoRequest = AMapReGeocodeSearchRequest().then { (request) in
                request.location = AMapGeoPoint.location(withLatitude: CGFloat(userLocation.coordinate.latitude), longitude: CGFloat(userLocation.coordinate.longitude))
            }
            poiSearchManager?.aMapReGoecodeSearch(reGeoRequest)
        }
    }
    
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation is MAPointAnnotation {
            let reuseId = "pointReuseIndentifier"
            var annoView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MAPinAnnotationView
            if annoView == nil {
                annoView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId )
            }
            annoView!.canShowCallout = true
            return annoView
        }
        return nil
    }
	
	func mapView(_ mapView: MAMapView!, didAnnotationViewCalloutTapped view: MAAnnotationView!) {
		self.performSegue(withIdentifier: R.segue.mapViewController.priceComparePush, sender: nil)
	}
    
}

extension MapViewController: AMapSearchDelegate {
    
    // MARK: - AMapSearchDelegate 
    
    func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
        MessageUtil.showError(title: "检索错误", message: error.localizedDescription)
    }
    
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        poiSearchResultController?.poiResult = response.pois
        poiSearchResultController?.poiTableView.reloadData()
    }
    
    func onReGeocodeSearchDone(_ request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
        if let city = response.regeocode.addressComponent.city, !city.isEmpty {
            poiSearchRequest.city = city
        }
        if let province = response.regeocode.addressComponent.province, !province.isEmpty {
            poiSearchRequest.city = province
        }
    }
    
}

extension MapViewController: UISearchResultsUpdating {
    
    // MARK: - UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            poiSearchRequest.keywords = searchText
            poiSearchManager?.aMapPOIKeywordsSearch(poiSearchRequest)
        }
    }
    
}

