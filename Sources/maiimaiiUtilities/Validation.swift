//
//  Validation.swift
//  WelbyUtility1
//
//  Created by Imai Hiroshi on 12/18/22.
//

import UIKit


public extension String {
	
	/// メールアドレスのバリデーション。メアドと判定されればtrue
	var isMailAddress: Bool {
		//                do {
		//                    let regex = try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$", options: [])
		//        			return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: self.count)) != nil
		//                } catch {
		//                    return false
		//                }

		let regex1 = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$"
		let res1 = NSPredicate(format: "SELF MATCHES %@", regex1).evaluate(with: self)

		// 先頭にピリオドがあればアウト
		let regex2 = "^\\..*$"
		let res2 = NSPredicate(format: "SELF MATCHES %@", regex2).evaluate(with: self)
		// ピリオドが2つ連続していたらアウト
		let regex3 = "^.*\\.\\..*$"
		let res3 = NSPredicate(format: "SELF MATCHES %@", regex3).evaluate(with: self)
		// @の直前にピリオドがあったらアウト
		let regex4 = "^.*\\.@.*$"
		let res4 = NSPredicate(format: "SELF MATCHES %@", regex4).evaluate(with: self)

		return res1 && !res2 && !res3 && !res4
	}

	/// キャリアメールドメイン判定
	var isCareerMailAddress: Bool {
		// https://creazy.net/2019/08/mobile-carrier-domains.html
		let careerArray: [String] = [
			"ezweb.ne.jp", "biz.ezweb.ne.jp", "augps.ezweb.ne.jp", "ido.ne.jp", "uqmobile.jp",
			"au.com", "biz.au.com", "docomo.ne.jp", "mopera.net", "disney.ne.jp", "disneymobile.ne.jp",
			"i.softbank.jp", "softbank.ne.jp", "vodafone.ne.jp", "emnet.ne.jp", "emobile.ne.jp",
			"emobile-s.ne.jp", "ymobile1.ne.jp", "ymobile.ne.jp", "yahoo.ne.jp", "pdx.ne.jp", "willcom.com",
			"wcm.ne.jp", "y-mobile.ne.jp", "jp-c.ne.jp", "jp-d.ne.jp", "jp-h.ne.jp", "jp-k.ne.jp", "jp-n.ne.jp",
			"jp-q.ne.jp", "jp-r.ne.jp", "jp-s.ne.jp", "jp-t.ne.jp", "sky.tkc.ne.jp", "sky.tkk.ne.jp", "sky.tu-ka.ne.jp"
		]

		for domain in careerArray {
			if self.contains(domain) {
				return true
			}
		}
		return false
	}

	
	/// パスワードのバリデーション項目
	struct PWValidationResult {
		var isValid: Bool = false
		var lowercase: Bool = false
		var uppercase: Bool = false
		var length: Bool = false
		var numeric: Bool = false
		var symbol: Bool = false
		var noMultibyteCharactersExist: Bool = false
	}

	/// テキストのバリデーション項目(絵文字、環境依存文字、4バイト文字)該当すればtrue
	struct TextValidationResult {
		var emoji: Bool = false
		var platformDependentCharacters: Bool = false
		var fourByteOrMoreCharacters: Bool = false
	}

	/// パスワードのバリデーション
	var passwordValidation: PWValidationResult {
		var returnValue: PWValidationResult = PWValidationResult()
		var cnt: Int = 0

		if self.count > 7 {
			returnValue.length = true
		} else {
			returnValue.length = false
		}

		let regexLowercase = try! NSRegularExpression(pattern: "[a-z]", options: [])
		if regexLowercase.firstMatch(in: self, options: [], range: NSRange(0..<self.count)) != nil {
			returnValue.lowercase = true
		} else {
			returnValue.lowercase = false
		}

		let regexUppercase = try! NSRegularExpression(pattern: "[A-Z]", options: [])
		if regexUppercase.firstMatch(in: self, options: [], range: NSRange(0..<self.count)) != nil {
			returnValue.uppercase = true
		} else {
			returnValue.uppercase = false
		}

		let regexNumeric = try! NSRegularExpression(pattern: "[0-9]", options: [])
		if regexNumeric.firstMatch(in: self, options: [], range: NSRange(0..<self.count)) != nil {
			returnValue.numeric = true
		} else {
			returnValue.numeric = false
		}

		let regexSymbol = try! NSRegularExpression(pattern: "[!-/:-@\\[-`{-~]", options: [])
		if regexSymbol.firstMatch(in: self, options: [], range: NSRange(0..<self.count)) != nil {
			returnValue.symbol = true
		} else {
			returnValue.symbol = false
		}

		let utf8Cnt = self.utf8.count
		let textCnt = self.count

		if utf8Cnt == textCnt {
			returnValue.noMultibyteCharactersExist = true
		}

		if returnValue.uppercase {
			cnt += 1
		}
		if returnValue.lowercase {
			cnt += 1
		}
		if returnValue.numeric {
			cnt += 1
		}
		if returnValue.symbol {
			cnt += 1
		}

		/// 大文字、小文字、数字、記号の中の3種類 + 8文字以上 + マルチバイト文字が入ってない
		if cnt >= 3 && returnValue.noMultibyteCharactersExist && returnValue.length {
			returnValue.isValid = true
		}

		return returnValue
	}

	/// 電話番号のバリデーション。電話番号と判定されればtrue
	var isPhoneNo: Bool {
		do {
			let regex = try NSRegularExpression(pattern: "^0[5789]0\\d{8}$", options: [])
			return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: self.count)) != nil
		} catch {
			return false
		}
	}

	/// エイリアス許可の場合の電話番号バリデーション
	var isPhoneNoWithAilias: Bool {
		do {
			let regex = try NSRegularExpression(pattern: "^0[5789]0\\d{8}(|#\\d*)$", options: [])
			return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: self.count)) != nil
		} catch {
			return false
		}
	}


	/// 環境依存文字チェック
	var isSpecialCharacters: TextValidationResult {
		var returnValue: TextValidationResult = TextValidationResult()

		let utf16Cnt: Int = self.utf16.count
		let utf32Cnt: Int = self.unicodeScalars.count

		if utf16Cnt == utf32Cnt {
			returnValue.fourByteOrMoreCharacters = false
		} else {
			returnValue.fourByteOrMoreCharacters = true
		}

		/// 環境依存文字
		/// shiftJIS,UTF-8,EUCに変換できるものは依存性なしと判断(基準が変わる可能性あり)
		let canBeConvertToShiftJis = self.canBeConverted(to: .shiftJIS)
		let canBeConvertToEUC = self.canBeConverted(to: .japaneseEUC)
		let canBeConvertToUTF8 = self.canBeConverted(to: .utf8)

		returnValue.platformDependentCharacters = !(canBeConvertToShiftJis && canBeConvertToEUC && canBeConvertToUTF8)

		/// 絵文字判定
		/// https://qiita.com/takabosoft/items/e8d99b2c5899616517d8
		let appleColorEmojiFont = CTFontCreateWithName("AppleColorEmoji" as CFString, 20, nil)

		// 1文字毎に判定
		let charArray = Array(self)
		var appleEmoji: Bool = false

		for char in charArray {
			let chars = Array(char.utf16)
			
			var glyphs = [CGGlyph](repeating: 0, count: chars.count)
			appleEmoji = CTFontGetGlyphsForCharacters(appleColorEmojiFont, chars, &glyphs, glyphs.count)

			if chars.count == 1 && chars[0] <= 57 { // 制御文字やスペース、数字を除外
				appleEmoji = false
			}

			if appleEmoji == true{
				returnValue.emoji = true
				break
			}
		}

		return returnValue
	}
	
}
