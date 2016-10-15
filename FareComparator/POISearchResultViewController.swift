//
//  POISearchResultViewController.swift
//  FareComparator
//
//  Created by BK on 15/10/2016.
//  Copyright © 2016 Bokang Huang. All rights reserved.
//

import UIKit

class POISearchResultViewController: UIViewController {
    
    @IBOutlet weak var poiTableView: UITableView!
    var poiResult: [AMapPOI] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Reset content inset, which shouldn't even exist
        self.poiTableView.contentInset = UIEdgeInsets.zero
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

extension POISearchResultViewController : UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.poiResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let poiDetailCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.pOIDetailCell, for: indexPath)!
        poiDetailCell.poiModal = self.poiResult[indexPath.row]
        return poiDetailCell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let mapViewVC = self.presentingViewController as? MapViewController {
            mapViewVC.userSelectedDestination = self.poiResult[indexPath.row]
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
