//
//  MTDateUtility.swift
//  maiimaiiUtility
//
//  Created by Imai Hiroshi on 02/18/24.
//

import UIKit

public class MTDateUtility: NSObject {

	/// DateからStringに変換
	/// - Parameters:
	///   - date: Date
	///   - format: ex) "yyyy-MM-dd"
	/// - Returns: ex) "2021-11-03"
	public static func dateToString(date: Date, format: String) -> String {
		let format = dateFormat(format: format)
		let dateStr: String = format.string(from: date)

		return dateStr
	}

	/// StringからDate
	/// - Parameters:
	///   - dateString: ex) "2021-11-03"
	///   - format: ex) "yyyy-MM-dd"
	/// - Returns: Date
	public static func stringToDate(dateString: String, format: String) -> Date {
		let format = dateFormat(format: format)
		let date: Date = format.date(from: dateString)!

		return date
	}

	/// DateFormatter雛形
	/// - Parameter format: ex) "yyyy-MM-dd"
	/// - Returns: 西暦、和暦などに影響を受けないフォーマット形式
	public static func dateFormat(format: String) -> DateFormatter {
		let dateFormat = DateFormatter()
		dateFormat.dateFormat = format
		dateFormat.locale = Locale(identifier: "en_US_POSIX")

		return dateFormat
	}

	/// DateのyyyyMMdd形式のFormat変換
	/// - Parameter date: Date形式の日付データ
	/// - Returns: (例)時間を00:00:00に固定したDate形式の日付データ→format:"yyyy-MM-dd"
	public static func dateWithFormat(date: Date, format: String) -> Date {
		let format = dateFormat(format: format)
		let dateStr: String = format.string(from: date)
		let dateWithFormat: Date = format.date(from: dateStr)!

		return dateWithFormat
	}


	/// format形式で日付の差分を比較
	/// - Parameters:
	///   - referenceDate: 基準日(Date)
	///   - targetDate: 比較対象の日付(Date)
	///   - format: (例)yyyy-MM-dd HH:mm:ss→秒単位の比較　yyyy-MM-dd HH→1時間単位での比較(欠損分は0埋め)
	/// - Returns: 差分(秒)　targetDateがreferenceDateより過去だとマイナス値で返ってくる
	/// 単純な時系列の前後の比較であれば比較演算子で確認ができる
	public static func timeInterval(referenceDate: Date, targetDate: Date, format: String?) -> Double {
		if let format = format {
			let reference = dateWithFormat(date: referenceDate, format: format)
			let target = dateWithFormat(date: targetDate, format: format)
			return target.timeIntervalSince(reference)
		}else{
			return targetDate.timeIntervalSince(referenceDate)
		}
	}


	
	/// 日付データの加算減算
	/// - Parameters:
	///   - year: 年
	///   - month: 月
	///   - day: 日
	///   - hour: 時間
	///   - min: 分
	///   - sec: 秒
	///   - from: 基準の日時:Date nilのばあいは現在に日時を設定Date()を指定するのと同じ意味合いになる
	///   - wrappingComponents: trueだと他のcomponentに影響を与えない(繰り上がりなどが考慮されない) default:false
	/// - Returns: 加工された日付:Date
	/// 【参考】https://qiita.com/isom0242/items/e83ab77a3f56f66edd2f
	public static func addTime(year: Int, month: Int, day: Int, hour: Int, min: Int, sec: Int, from: Date, wrappingComponents: Bool?) -> Date?{
		
		let wc = wrappingComponents ?? false
		let date = from
		let calendar = Calendar.current
		let components = DateComponents(year: year, month: month, day: day, hour: hour, minute: min, second: sec)
		
		let outdate:Date? = calendar.date(byAdding: components, to: date, wrappingComponents: wc) 
		
		return outdate
	}
	

	/// 日付けのフォーマット変換
	/// - Parameters:
	///   - date: 日付(String)　ex: 2022/01/01
	///   - formatFrom: 変換前フォーマット(String) ex:yyyy/MM/dd
	///   - formatTo: 返還後フォーマット(String) ex:yyyy-M-d
	/// - Returns: 返還後の日付(String) ex:2022-1-1
	public static func convertingDateFormat(date: String, formatFrom: String, formatTo: String) -> String {
		let tempDate = self.stringToDate(dateString: date, format: formatFrom)
		let resultStr = self.dateToString(date: tempDate, format: formatTo)
		return resultStr
	}

	/// UTC時刻の取得 yyyy-MM-ddTHH:mm:ssZ
	/// - Returns: UTC時刻(String)
	public static func getCurrentUTCTime() -> String {
		let dateFormat = DateFormatter()
		dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
		dateFormat.timeZone = TimeZone(identifier: "UTC")
		dateFormat.locale = Locale(identifier: "en_US_POSIX")

		return dateFormat.string(from: Date())
	}
	
	/// UTC表示からローカルタイム表示に変換
	/// - Parameters:
	///   - utc: UTC Time (String, format: yyyy-MM-ddTHH:mm:ssZ")
	///   - format: 出力フォーマット(例: yyyy/MM/dd HH:mm:ss)
	/// - Returns: Local Time(String)
	public static func UTCToLocalTime(utc: String, format: String) -> String {
		let utcFormat = DateFormatter()
		utcFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
		utcFormat.timeZone = TimeZone(identifier: "UTC")

		let date: Date = utcFormat.date(from: utc)!

		let dateFormat = DateFormatter()
		dateFormat.dateFormat = format
		dateFormat.locale = Locale(identifier: "en_US_POSIX")

		let dateStr: String = dateFormat.string(from: date)

		return dateStr
	}

	
	/// local TimeのUTC表示
	/// - Parameter date: Local Time(Date)
	/// - Returns: UTC Time (String, format: yyyy-MM-ddTHH:mm:ssZ)
	public static func localDateInUTC(date: Date) -> String {
		let utcFormat = DateFormatter()
		utcFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
		utcFormat.timeZone = TimeZone(identifier: "UTC")
		utcFormat.locale = Locale(identifier: "en_US_POSIX")

		let dateStr: String = utcFormat.string(from: date)

		return dateStr
	}
	
	// 日付の差分計算
//	public static func timeInterval(referenceDate: Date, targetDate: Date) -> Double {
//		return targetDate.timeIntervalSince(referenceDate)
//	}
	
	// 基準日時に対して過去現在未来の判定
	// swift3よりDateの直接比較(<, >, ==, !=, など...)ができるよになったので省略→未来のデータが値が大きい
	
	/// 曜日をStringで取得
	/// - Parameters:
	///   - date: Date形式
	///   - isShortened: 短縮系 -> true:月、Mon, false:月曜日、Monday
	/// - Returns: 曜日: String　localeは設定アプリの言語設定と、当該アプリのLocalizationで決まる。該当するものがなければデフォルトの言語が使用される
	public static func getWeekdayString(date:Date, isShortened: Bool) -> String {
		
		var template:String = "EEEE"
		if isShortened == true {
			template = "EEE"
		}
		
		let weekdayFormat = DateFormatter()
		weekdayFormat.dateFormat = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: .current)
		let weekday = weekdayFormat.string(from: date)
		
		return weekday
	}

}
