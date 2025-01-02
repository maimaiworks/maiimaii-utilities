//
//  MTNotification.swift
//  
//
//  Created by Imai Hiroshi on 2/26/24.
//

import UIKit

open class MTNotification: NSObject {
	
	/// ローカル通知設定
	/// - Parameters:
	///   - title: タイトル
	///   - subTitle: サブタイトル
	///   - body: body(本文)
	///   - sound: 通知音(nil→default sound)
	///   - userInfo: 付加情報(Dictionry形式)
	///   - second: 通知時間(N秒後に通知)
	public static func setLocalNotificationWithTimeInterval(title: String?, subTitle: String?, body: String?, sound: UNNotificationSound?, userInfo: [String : Any]?, second: Double, repeats: Bool, identifier: String) {
		
		//通知設定
		let content = UNMutableNotificationContent()
		if let title = title {
			content.title = title
		}
		if let subTitle = subTitle {
			content.subtitle = subTitle
		}
		if let body = body {
			content.body = body
		}
		if let sound = sound {
			content.sound = sound
		}else{
			content.sound = UNNotificationSound.default
		}
		if let userInfo = userInfo {
			content.userInfo = userInfo
		}

		// timeInterval指定　1時間後
		let intervalTrigger = UNTimeIntervalNotificationTrigger(timeInterval: second, repeats: repeats)
		
		//リクエスト作成
		let calendarRequest = UNNotificationRequest(identifier: identifier,
											content: content,
											trigger: intervalTrigger)
		
		//通知実行
		UNUserNotificationCenter.current().add(calendarRequest)
	}
	
	
	/// ローカル通知設定
	/// - Parameters:
	///   - title: タイトル
	///   - subTitle: サブタイトル
	///   - body: body(本文)
	///   - sound: 通知音(nil→default sound)
	///   - userInfo: 付加情報(Dictionary形式)
	///   - year: 年(Int) 例:2024
	///   - month: 月(Int)　例:1
	///   - day: 日(Int)　例:24
	///   - hour: 時(Int)　例:12
	///   - minute: 分(Int)　例:34
	///   - second: 秒(Int)　例:56
	///   2024年1月24日12時34分56秒に通知
	///   Tips dayに0を指定すると前月の最終日を返してくれる
	public static func setLocalNotificationWithDateComponents(title: String?, subTitle: String?, body: String?, sound: UNNotificationSound?, userInfo: [String : Any]?, year: Int?, month: Int?, day: Int?, hour: Int? ,minute: Int?, second: Int?, weekday: Int?, repeats: Bool, identifier: String) {
		
		//通知設定
		var dateComponents = DateComponents()
		dateComponents.year = year
		dateComponents.month = month
		dateComponents.day = day
		dateComponents.hour = hour
		dateComponents.minute = minute
		dateComponents.second = second
		dateComponents.weekday = weekday

		
		let content = UNMutableNotificationContent()
		if let title = title {
			content.title = title
		}
		if let subTitle = subTitle {
			content.subtitle = subTitle
		}
		if let body = body {
			content.body = body
		}
		if let sound = sound {
			content.sound = sound
		}else{
			content.sound = UNNotificationSound.default
		}
		if let userInfo = userInfo {
			content.userInfo = userInfo
		}

		//時間指定
		let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: repeats)
		
		
		//リクエスト作成
		let calendarRequest = UNNotificationRequest(identifier: identifier,
											content: content,
											trigger: calendarTrigger)
		
		//通知実行
		UNUserNotificationCenter.current().add(calendarRequest)
	}
	
	/// セットされているローカル通知を全て削除
	public static func removeAllLocalNotification() {
		UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
	}
	
	/// identifierを指定してローカル通知を削除
	/// - Parameter identifiers: ローカル通知のID: [String]
	public static func removeLocalNotification(identifiers: [String]) {
		UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
	}
	
}
