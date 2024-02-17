// The Swift Programming Language
// https://docs.swift.org/swift-book

#if !os(OSX)

import Foundation
//import UIKit

public let MT = maiimaii.info.self


public struct maiimaii {
	public struct info{
		public static func appversion() -> String {
			return MTSystemInfo.appversion()
		}
		public static func buildnumber() -> String {
			return MTSystemInfo.buildnumber()
		}
		public static func systemversion() -> String {
			return MTSystemInfo.systemVersion()
		}
		public struct screen {
			public static let height = MTSystemInfo.Screen.height
			public static let width = MTSystemInfo.Screen.width
		}
		public struct safearea {
			public static let top = MTSystemInfo.Safearea.top
			public static let bottom = MTSystemInfo.Safearea.bottom
			public static let left = MTSystemInfo.Safearea.left
			public static let right = MTSystemInfo.Safearea.right
		}
	}
}

#endif
