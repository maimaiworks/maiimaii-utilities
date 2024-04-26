//
//  MTAlert.swift
//  maiimaiiUtility
//
//  Created by Imai Hiroshi on 02/16/24.
//

import UIKit

open class MTAlert: NSObject {
	
	
	public static func show(title: String?, message: String?, okButtonTitle: String?, isDestructive: Bool, cancelButtonTitle: String?, completion: ((Bool) -> Void)?) {
		let buttonStyle: UIAlertAction.Style!
		if isDestructive == true {
			buttonStyle = .destructive
		} else {
			buttonStyle = .default
		}

		let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

		if let okButtonTitle = okButtonTitle {
			let OKAction = UIAlertAction(title: okButtonTitle, style: buttonStyle) { (_: UIAlertAction) in
				if let completion = completion {
					completion(true)
				}
			}
			alert.addAction(OKAction)
			alert.preferredAction = OKAction
		}

		if let cancelButtonTitle = cancelButtonTitle {
			let cancelAction = UIAlertAction(title: cancelButtonTitle, style: UIAlertAction.Style.cancel) { (_: UIAlertAction) in
				if let completion = completion {
					completion(false)
				}
			}
			alert.addAction(cancelAction)
		}

		let topview = MT.view.top()
		if let topview = topview {
			topview.present(alert, animated: true, completion: {})
		}
	}

	
	
}
