//
//  AppDelegate.swift
//  FareComparator
//
//  Created by BK on 10/12/16.
//  Copyright © 2016 Bokang Huang. All rights reserved.
//

import UIKit
import UberRides
import Zhugeio
import Siren

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
        // Check new version
        Siren.sharedInstance.checkVersion(checkType: .immediately)
        
		// AMap Config
		AMapServices.shared().apiKey = "1aa7c8d0f9dff2e0d30dc54228beab9a"
        
		// Uber Config
		Configuration.setRegion(.china)
		Configuration.setSandboxEnabled(false)
		Configuration.setFallbackEnabled(false)
		
		// Didi Config
		DIOpenSDK.registerApp("didi49694F49616E392B676D75715451", secret: "68c9ca942789448e279b7944547cf394")
		
        // ZhuGe Config
        Zhuge.sharedInstance().start(withAppKey: "b619a0a06ddc45208d725d45086ec6d2", launchOptions: launchOptions)
        
		// Handle incoming SSO Requests
		_ = RidesAppDelegate.sharedInstance.application(application, didFinishLaunchingWithOptions: launchOptions)
		
		return true
	}

	func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
		_ = RidesAppDelegate.sharedInstance.application(app, openURL: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation] as AnyObject?)
		
		return true
	}
	
	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        Siren.sharedInstance.checkVersion(checkType: .daily)
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}


}

