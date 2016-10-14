//
//  MessageUtil.swift
//  FareComparator
//
//  Created by BK on 10/14/16.
//  Copyright © 2016 Bokang Huang. All rights reserved.
//

import UIKit
import SwiftMessages

class MessageUtil {
	
	class func showError(title: String?, message: String?) {
		var config = SwiftMessages.Config()
		config.presentationStyle = .bottom
		SwiftMessages.show(config: config, viewProvider: { () -> UIView in
			let view = MessageView.viewFromNib(layout: .CardView)
			if let t = title, let m = message {
				view.configureContent(title: t, body: m)
			}
			view.configureTheme(.error)
			view.button?.isHidden = true
			return view
		})
	}
	
}
