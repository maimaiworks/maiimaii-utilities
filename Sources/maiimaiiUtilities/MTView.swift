//
//  MTView.swift
//  maiimaiiUtility
//
//  Created by Imai Hiroshi on 02/18/24.
//

import UIKit

public class MTView: NSObject {

	/// 画面中の最上位のViewControllerを探索
	/// - Returns: 最上位のViewController
	public static func topViewController() -> UIViewController? {
		var topViewController: UIViewController?
		if #available(iOS 13.0, *) {
			if UIApplication.shared.windows.filter({ $0.isKeyWindow }).isEmpty == false {
				topViewController = UIApplication.shared.windows.filter { $0.isKeyWindow }[0].rootViewController
			}
		} else {
			topViewController = UIApplication.shared.keyWindow?.rootViewController
		}
		
		while (topViewController?.presentedViewController) != nil {
			topViewController = topViewController?.presentedViewController
		}
		
		return topViewController
	}
	
	
	/// windowの取得
	/// - Parameter level: windowレベル
	/// - Returns: window
	public static func getWindow(level: Int) -> UIWindow? {
		
		/// UIWindowの取得
		/// windowLevelをnormal + levelとすることで最上位のwindowに設定
		
		if #available(iOS 13.0, *) {
			let scenes = UIApplication.shared.connectedScenes
			let windowScenes = scenes.first as? UIWindowScene
			let window = windowScenes?.windows.first

			if let window = window {
				window.frame = UIScreen.main.bounds
				window.windowLevel = UIWindow.Level.normal + UIWindow.Level.RawValue(level)

				return window
			}else{
				return nil
			}
		} else {
			let window :UIWindow = UIApplication.shared.windows.first { $0.isKeyWindow }!
			window.frame = UIScreen.main.bounds
			window.windowLevel = UIWindow.Level.normal + 1
			window.frame = UIScreen.main.bounds
			window.windowLevel = UIWindow.Level.normal + UIWindow.Level.RawValue(level)
			
			return window
		}
	}
}
