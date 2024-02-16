//
//  MTSystemInfo.swift
//  maiimaiiUtility
//
//  Created by Imai Hiroshi on 2/16/24.
//

import UIKit

class MTSystemInfo: NSObject {

	/// アプリバージョン
	/// - Returns: バージョン番号:String
	static func appversion() -> String {
		return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "0.0.0"
	}
	/// ビルドナンバー
	/// - Returns: ビルドナンバー:String
	static func buildnumber() -> String {
		return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "0"
	}
	
	/// OSバージョン
	/// - Returns: OSバージョン:String
	static func systemVersion() -> String {
		return UIDevice.current.systemVersion
	}
	
	struct Screen {
		static let height = UIScreen.main.bounds.size.height
		static let width = UIScreen.main.bounds.size.width
	}

	struct Safearea {
		// iOS11以降、ホームボタンタイプの端末の場合は0を返す
		static let top = safeAreaTopFunc()
		static let bottom = safeAreaBottomFunc()
		static let left = safeAreaLeftFunc()
		static let right = safeAreaRightFunc()
	}

	// iOS11以降、iPhone Xのsafe_area_top
	static func safeAreaTopFunc() -> CGFloat {
		var safeArea: CGFloat = 0
		if #available(iOS 11.0, *) {
			if #available(iOS 13.0, *) {
				safeArea = UIApplication.shared.windows.filter { $0.isKeyWindow }[0].safeAreaInsets.top
			} else {
				safeArea = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0.0
			}
		}
		return safeArea
	}

	// iOS11以降、iPhone Xのsafe_area_bottom
	static func safeAreaBottomFunc() -> CGFloat {
		var safeArea: CGFloat = 0
		if #available(iOS 11.0, *) {
			if #available(iOS 13.0, *) {
				safeArea = UIApplication.shared.windows.filter { $0.isKeyWindow }[0].safeAreaInsets.bottom
			} else {
				safeArea = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0
			}
		}
		return safeArea
	}

	// iOS11以降、iPhone Xのsafe_area_left
	static func safeAreaLeftFunc() -> CGFloat {
		var safeArea: CGFloat = 0
		if #available(iOS 11.0, *) {
			if #available(iOS 13.0, *) {
				safeArea = UIApplication.shared.windows.filter { $0.isKeyWindow }[0].safeAreaInsets.left
			} else {
				safeArea = UIApplication.shared.keyWindow?.safeAreaInsets.left ?? 0.0
			}
		}
		return safeArea
	}

	// iOS11以降、iPhone Xのsafe_area_right
	static func safeAreaRightFunc() -> CGFloat {
		var safeArea: CGFloat = 0
		if #available(iOS 11.0, *) {
			if #available(iOS 13.0, *) {
				safeArea = UIApplication.shared.windows.filter { $0.isKeyWindow }[0].safeAreaInsets.right
			} else {
				safeArea = UIApplication.shared.keyWindow?.safeAreaInsets.right ?? 0.0
			}
		}
		return safeArea
	}

}
