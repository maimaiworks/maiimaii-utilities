// The Swift Programming Language
// https://docs.swift.org/swift-book

#if !os(OSX)

import Foundation
import UIKit


public let MT = maiimaii.self


public struct maiimaii {
	public struct info{
		
		public static let appVersion = MTInfo.appversion()
		public static let buildNumber = MTInfo.buildnumber()
		public static let systemVersion = MTInfo.systemVersion()

		public struct screen {
			public static let height = MTSize.Screen.height
			public static let width = MTSize.Screen.width
		}
		
		public struct safearea {
			public static let top = MTSize.Safearea.top
			public static let bottom = MTSize.Safearea.bottom
			public static let left = MTSize.Safearea.left
			public static let right = MTSize.Safearea.right
		}
	}
	
	public struct date {
		
		public static func dateToString(date: Date, format: String) -> String {
			return MTDateUtility.dateToString(date: date, format: format)
		}
		public static func stringToDate(dateString: String, format: String) -> Date {
			return MTDateUtility.stringToDate(dateString: dateString, format: format)
		}
		public static func dateWithFormat(date: Date, format: String) -> Date {
			return MTDateUtility.dateWithFormat(date: date, format: format)
		}
		public static func dateInterval(referenceDate: Date, targetDate: Date, format: String) -> Double {
			return MTDateUtility.timeInterval(referenceDate: referenceDate, targetDate: targetDate, format: format)
		}
		public static func convartingDateFormat(date: String, formatFrom: String, formatTo: String) -> String {
			return MTDateUtility.convertingDateFormat(date: date, formatFrom: formatFrom, formatTo: formatTo)
		}
		public static func getCurrentUTCTime() -> String {
			return MTDateUtility.getCurrentUTCTime()
		}
		public static func UTCToLocalTime(utc: String, format: String) -> String {
			return MTDateUtility.UTCToLocalTime(utc: utc, format: format)
		}
		public static func localDateToUTC(date: Date) -> String {
			MTDateUtility.localDateInUTC(date: date)
		}
		public static func getWeekdayString(date:Date, isShortened: Bool) -> String {
			return MTDateUtility.getWeekdayString(date: date, isShortened: isShortened)
		}
		public static func addTime(year: Int, month: Int, day: Int, hour: Int, min: Int, sec: Int, from: Date, wrappingComponents: Bool?) -> Date? {
			return MTDateUtility.addTime(year: year, month: month, day: day, hour: hour, min: min, sec: sec, from: from, wrappingComponents: wrappingComponents)
		}
	}
	
	public struct view {
		public static func top() -> UIViewController? {
			return MTView.topViewController()
		}
		public static func windowWith(level: Int) -> UIWindow? {
			return MTView.getWindow(level: level)
		}
	}
	
	public struct alert {
		public static func show(title: String?, message: String?, okButtonTitle: String?, isDestructive: Bool, cancelButtonTitle: String?, completion: ((Bool) -> Void)?){
			
			return MTAlert.show(title: title, message: message, okButtonTitle: okButtonTitle, isDestructive: isDestructive, cancelButtonTitle: cancelButtonTitle) { status in
				if let completion = completion {
					completion(status)
				}
			}
		}
	}
	
	public struct utility {
		public static func subData(data: NSData, start: Int, length: Int) -> NSData {
			return MTUtilities.SUBDATA(data: data, start: start, length: length)
		}
		public static func subStr(string: NSString, start: Int, length: Int) -> NSString {
			return MTUtilities.SUBSTR(string: string, start: start, length: length)
		}
		public static func replace(string: NSString, from: String, to: String) -> NSString {
			return MTUtilities.replace(string: string, from: from, to: to)
		}
		public static func urlDecode(encodedText: String) -> String {
			return MTUtilities.urlDecode(encodedText: encodedText)
		}
		public static func jsonConverter<T:Encodable> (object: T) -> String {
			return MTUtilities.jsonConverter(object: object)
		}
		public static func jsonObjectFromFilename<T: Decodable>(filename: String, Type:T.Type) -> T? {
			return MTUtilities.jsonObjectFromFilename(filename: filename, Type: Type)
		}
	}
	
	
//	public struct json {
//		public static func json<T:Decodable>(filename: String) -> sendBloodPressureModel? {
//			return extensions.jsonObjectFromFilename(filename)
//		}
//	}
}


public class aaa: NSObject {
	
	
}

#endif
