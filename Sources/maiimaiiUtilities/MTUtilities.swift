//
//  MTUtilities.swift
//  
//
//  Created by Imai Hiroshi on 2/26/24.
//

import UIKit

public class MTUtilities: NSObject {

	
	/// データのクリッピング
	static func SUBDATA(data: NSData, start: Int, length: Int) -> NSData {
		return data.subdata(with: NSRange(location: start, length: length)) as NSData
	}
	/// 文字列のクリッピング
	static func SUBSTR(string: NSString, start: Int, length: Int) -> NSString {
		return string.substring(with: NSRange(location: start, length: length)) as NSString
	}

	/// 文字列の置換
	/// - Parameters:
	///   - string: 対象となる文字列
	///   - from: 置換対象の文字列
	///   - to: 置換する文字列
	/// - Returns: 置換結果
	static func replace(string: NSString, from: String, to: String) -> NSString {
		return string.replacingOccurrences(of: from, with: to) as NSString
	}
	
	
	/// URLデコード
	/// - Parameter encodedText: エンコードされた文字列:String
	/// - Returns: デコードされた文字列(平文):String
	/// https://blog.prosta.org/articles/【swift】urlエンコード・デコードの実装メモ/
	static func urlDecode(encodedText: String) -> String {
		if let decodedText = encodedText.removingPercentEncoding {
			return decodedText
		}
		// error
		return ""
	}

	
	/// dataModelをString形式のjsonに変換
	/// - Parameter object: CodableもしくはEncodableなdataModel
	/// - Returns: json(String)
	public static func jsonConverter<T:Encodable> (object: T) -> String {
		
		let encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted // リーダブルな出力
		let encoded = try! encoder.encode(object)
//		print(String(data: encoded, encoding: .utf8)!)
		
		return String(data: encoded, encoding: .utf8)!
	}
	
	
//	public static func jsonObjectFromFilenameOld<T: Decodable>(name: String) -> T? {
//		guard let filePath = Bundle.main.url(forResource: name, withExtension: "json") else {
//			print("File not found")
//			return nil
//		}
//		do {
//			let codable = try JSONDecoder().decode(T.self, from: Data.init(contentsOf: filePath))
//			return codable
//		} catch let error {
//			print("Json parser error: \(error.localizedDescription)")
//			return nil
//		}
//	}
	
	/// バンドル内のダミーjsonファイルを指定したデータモデルの型で取得
	/// - Parameters:
	///   - filename: バンドル内のjsonファイル名(.jsonは不要)
	///   - Type: dataModelを指定
	/// - Returns: 指定したdataModel型のobject
	public static func jsonObjectFromFilename<T: Decodable>(filename: String, Type:T.Type) -> T? {
		guard let filePath = Bundle.main.url(forResource: filename, withExtension: "json") else {
			print("File not found")
			return nil
		}
		do {
			let codable = try JSONDecoder().decode(T.self, from: Data.init(contentsOf: filePath))
			return codable
		} catch let error {
			print("Json parser error: \(error.localizedDescription)")
			return nil
		}
	}
	
	public static func jsonObjectFromString<T: Decodable>(string: String, Type: T.Type) -> T? {
				
		do {
			let codable = try JSONDecoder().decode(T.self, from: Data(string.utf8))
			return codable
		} catch let error {
			print("Json parser error: \(error.localizedDescription)")
			return nil
		}
	}
}
