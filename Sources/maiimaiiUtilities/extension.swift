//
//  extension.swift
//  
//
//  Created by Imai Hiroshi on 2/19/24.
//

import UIKit
import CommonCrypto


extension UIView {
	/** UIViewオブジェクトの原点と逆側(tail)のx、y座標 */
	var tail:CGPoint{
		return CGPoint(x: self.frame.origin.x + self.frame.size.width, y:self.frame.origin.y+self.frame.size.height)
	}
	
	/** UIViewオブジェクトのwidth */
	var width:CGFloat{
		return self.frame.size.width
	}
	
	/** UIViewオブジェクトのheight */
	var height:CGFloat{
		return self.frame.size.height
	}

}

// MARK: DispatchQueue
// https://techblog.sgr-ksmt.dev/2017/02/15/cancelable_async_after/
extension DispatchQueue{
	func cancelableAsyncAfter(deadline: DispatchTime, execute: @escaping () -> Void) -> DispatchWorkItem {
			let item = DispatchWorkItem(block: execute)
			asyncAfter(deadline: deadline, execute: item)

			return item
		}
}


extension String {
	
	public var sha1: String {
		let data = Data(self.utf8)
		var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
		data.withUnsafeBytes {
			_ = CC_SHA1($0.baseAddress, CC_LONG(data.count), &digest)
		}
		let hexBytes = digest.map { String(format: "%02hhx", $0) }
		return hexBytes.joined()
	}
	
	
	/// 正規表現でマッチの有無を判定
	/// - Parameter regex: 正規表現(String)
	/// - Returns: 判定結果(Bool)
	public func regex(regex: String)-> Bool {
		 return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
	}
	
	public var fullWidthToHalfWidth: String {
		
		if let halfStr = self.applyingTransform(.fullwidthToHalfwidth, reverse: false) {
			return halfStr
		}else{
			return self
		}
	}

	
	// 小数点第一位を切り上げて整数表示にする
	public var roundUpData: String {
		
		var tempNum:Double = Double(self) ?? 0
		tempNum = tempNum + 0.9
		let min:Int = Int(tempNum)

		return min.description
	}
}


extension UIImageView {
	func appIconEffect() -> UIImageView {
		let sourceImage = self.image
		let maskImage = UIImage(named: "appIconMask")

		if let iconimage = sourceImage?.masking(maskImage: maskImage) {
			self.image = iconimage
		}

		return self.dropShadow()
	}

	func dropShadow() -> UIImageView {
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowRadius = 6.0
		self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
		self.layer.shadowOpacity = 0.3

		return self
	}
}

extension UIImage{
	
	// 指定したマスク画像を利用して元画像を切り抜く
	// マスク画像は非透過画像を利用する (輝度情報からマスクを作成している模様)
	func masking(maskImage: UIImage?) -> UIImage? {
		guard let maskImage = maskImage else { return nil }
		let resizeMask = maskImage.resize(size: self.size)

		guard let maskImage = resizeMask?.cgImage else {
			return nil
		}

		// マスクを作成する
		let mask = CGImage(maskWidth: maskImage.width,
						   height: maskImage.height,
						   bitsPerComponent: maskImage.bitsPerComponent,
						   bitsPerPixel: maskImage.bitsPerPixel,
						   bytesPerRow: maskImage.bytesPerRow,
						   provider: maskImage.dataProvider!,
						   decode: nil, shouldInterpolate: false)!

		let maskdImage = UIImage(cgImage: mask)
		print(maskdImage.size)

		// マスクを適用する
		guard let maskedImage = self.cgImage?.masking(mask) else {
			return nil
		}

		let resultImage = UIImage(cgImage: maskedImage)

		return resultImage
	}

	func resize(size: CGSize) -> UIImage? {
		let widthRatio = size.width / self.size.width
		let heightRatio = size.height / self.size.height
		let ratio = widthRatio < heightRatio ? widthRatio : heightRatio

		let resizedSize = CGSize(width: self.size.width * ratio, height: self.size.height * ratio)

		UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0) // 変更
		draw(in: CGRect(origin: .zero, size: resizedSize))
		let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()

		return resizedImage
	}
	
}


extension UIDevice {
	static var modelName: String {
		var systemInfo = utsname()
		uname(&systemInfo)
		let mirror = Mirror(reflecting: systemInfo.machine)
		let identifier = mirror.children.reduce("") { identifier, element in
			guard let value = element.value as? Int8, value != 0 else { return identifier }
			return identifier + String(UnicodeScalar(UInt8(value)))
		}
		return identifier
	}
}
extension UIButton {
	func dropShadow() -> UIButton {
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowRadius = 6.0
		self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
		self.layer.shadowOpacity = 0.3

		return self
	}
}
