//
//  MTSystemInfo.swift
//  maiimaiiUtility
//
//  Created by Imai Hiroshi on 2/16/24.
//

#if !os(OSX)
import UIKit
import Foundation

class MTInfo: NSObject {

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
}

open class MTSize: NSObject {
	
	public struct Screen {
		public static let height = UIScreen.main.bounds.size.height
		public static let width = UIScreen.main.bounds.size.width
	}

	public struct Safearea {
		// iOS11以降、ホームボタンタイプの端末の場合は0を返す
		public static let top = safeAreaTopFunc()
		public static let bottom = safeAreaBottomFunc()
		public static let left = safeAreaLeftFunc()
		public static let right = safeAreaRightFunc()
	}

	// iOS11以降、iPhone Xのsafe_area_top
	static func safeAreaTopFunc() -> CGFloat {
		var safeArea: CGFloat = 0
		safeArea = CGFloat(MTView.getWindow(level: 0)!.safeAreaInsets.top ?? 0.0)
		return safeArea
	}

	// iOS11以降、iPhone Xのsafe_area_bottom
	static func safeAreaBottomFunc() -> CGFloat {
		var safeArea: CGFloat = 0
		safeArea = CGFloat(MTView.getWindow(level: 0)!.safeAreaInsets.bottom ?? 0.0)
		return safeArea
	}

	// iOS11以降、iPhone Xのsafe_area_left
	static func safeAreaLeftFunc() -> CGFloat {
		var safeArea: CGFloat = 0
		safeArea = CGFloat(MTView.getWindow(level: 0)!.safeAreaInsets.left ?? 0.0)
		return safeArea
	}

	// iOS11以降、iPhone Xのsafe_area_right
	static func safeAreaRightFunc() -> CGFloat {
		var safeArea: CGFloat = 0
		safeArea = CGFloat(MTView.getWindow(level: 0)!.safeAreaInsets.right ?? 0.0)
		return safeArea
	}
}


#endif
