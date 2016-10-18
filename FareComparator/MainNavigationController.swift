//
//  MainNavigationController.swift
//  FareComparator
//
//  Created by BK on 16/10/2016.
//  Copyright © 2016 Bokang Huang. All rights reserved.
//

import UIKit
import RevealingSplashView
import ChameleonFramework

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let revealingSplashView = RevealingSplashView(iconImage: R.image.appLogo()!, iconInitialSize: CGSize(width: 80, height: 80), backgroundColor: UIColor.flatYellow)
        self.view.addSubview(revealingSplashView)
        revealingSplashView.startAnimation()
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
