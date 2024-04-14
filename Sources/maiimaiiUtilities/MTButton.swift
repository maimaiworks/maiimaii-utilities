//
//  MTButton.swift
//  libtest2
//
//  Created by Imai Hiroshi on 2/22/24.
//

import UIKit

@available(iOS 13.0, *)
@IBDesignable
open class MTButton: UIButton {
	
	// property設定
	@IBInspectable public var title:String?{
		didSet{
			self.titleSetting()
		}
	}
	@IBInspectable public var titleFontSize:CGFloat = 17.0 {
		didSet{
			self.titleSetting()
		}
	}
	@IBInspectable public var titleFontIsBold:Bool = true {
		didSet {
			self.titleSetting()
		}
	}
	@IBInspectable public var color:UIColor? {
		didSet {
			self.backGroundImageSetting()
			self.iconImageSetting()
		}
	}
	@IBInspectable public var isBorder:Bool = false {
		didSet {
			self.titleSetting()
			self.backGroundImageSetting()
			self.iconImageSetting()
			self.cornerSetting()
			self.borderSetting()
		}
	}
	@IBInspectable public var isOval:Bool = false {
		didSet {
			self.cornerSetting()
			self.borderSetting()
		}
	}
	@IBInspectable public var round:CGFloat = 0.0 {
		didSet {
			self.cornerSetting()
			self.borderSetting()
		}
	}
	@IBInspectable public var iconImage:UIImage? {
		didSet {
			self.iconImageSetting()
		}
	}
	@IBInspectable public var imageScale:CGFloat = 1.0 {
		didSet {
			self.iconImageSetting()
		}
	}
	
	
	// 最終的に内部で使用する変数
	private var buttonTitle:String = ""
	private var buttonColor:UIColor = UIColor.black
	private var buttonIsBorder:Bool = false
	private var buttonIsOval:Bool = false
	private var buttonRound:CGFloat = 0.0
	private var buttonIconImage:UIImage?
	private	var buttonImageScale:CGFloat = 1.0
	private var buttonTitleFontSize:CGFloat = 17.0
	private var buttonTitleFontIsBold:Bool = true
	
	private var isInit:Bool = true

	
	public override init(frame: CGRect){
		super.init(frame: frame)
		loadNib()
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)!
		loadNib()
	}
	
	func loadNib(){
		
		DispatchQueue.main.async {
			self.initialSetting()
		}
	}
	
	func initialSetting() {
		
		if let color = self.color {
			buttonColor = color
		}
		
		if let title = self.title {
			buttonTitle = title
		}
		
		if let iconImage = self.iconImage {
			buttonIconImage = iconImage
		}else{
			buttonIconImage = nil
		}
		
		buttonIsBorder = self.isBorder
		buttonIsOval = self.isOval
		buttonRound = self.round
		buttonImageScale = self.imageScale
		buttonTitleFontSize = self.titleFontSize
		buttonTitleFontIsBold = self.titleFontIsBold
		
	}
	
	public override func draw(_ rect: CGRect) {
		self.buttonSetting()
	}

	func buttonSetting() {
		
		if isInit == true {
			self.initialSetting()
			isInit = false
		}
		
		if #available(iOS 15.0, *) {
			self.configuration = nil
		}
		
		self.titleSetting()
		self.backGroundImageSetting()
		self.iconImageSetting()
		self.cornerSetting()
		self.borderSetting()
	}
	
	
	private func titleSetting() {
		
		switch buttonIsBorder {
		case true:
			
			if buttonTitle.count == 0 {
				setTitle(buttonTitle, for: .normal)
				setTitle(buttonTitle, for: .highlighted)
				setTitle(buttonTitle, for: .selected)
				setTitle(buttonTitle, for: .disabled)
				
				setTitleColor(buttonColor, for: .normal)
				setTitleColor(.white, for: .highlighted)
				setTitleColor(.white, for: .selected)
				setTitleColor(color(color: buttonColor, alpha: 0.3), for: .disabled)
				setTitleColor(buttonColor, for: [.highlighted, .selected])
			}else{
				setAttributedTitle(attrTitle(title: buttonTitle, color: buttonColor), for: .normal)
				setAttributedTitle(attrTitle(title: buttonTitle, color: UIColor.white), for: .highlighted)
				setAttributedTitle(attrTitle(title: buttonTitle, color: UIColor.white), for: .selected)
				setAttributedTitle(attrTitle(title: buttonTitle, color: color(color: buttonColor, alpha: 0.3)), for: .disabled)
				setAttributedTitle(attrTitle(title: buttonTitle, color: buttonColor), for: [.highlighted, .selected])

			}

		case false:
			
			if buttonTitle.count == 0 {
				setTitle(buttonTitle, for: .normal)
				setTitle(buttonTitle, for: .highlighted)
				setTitle(buttonTitle, for: .selected)
				setTitle(buttonTitle, for: .disabled)
				
				setTitleColor(.white, for: .normal)
				setTitleColor(buttonColor, for: .highlighted)
				setTitleColor(buttonColor, for: .selected)
				setTitleColor(.white, for: .disabled)
				setTitleColor(.white, for: [.highlighted, .selected])

			}else{
				setAttributedTitle(attrTitle(title: buttonTitle, color: UIColor.white), for: .normal)
				setAttributedTitle(attrTitle(title: buttonTitle, color: buttonColor), for: .highlighted)
				setAttributedTitle(attrTitle(title: buttonTitle, color: buttonColor), for: .selected)
				setAttributedTitle(attrTitle(title: buttonTitle, color: UIColor.white), for: .disabled)
				setAttributedTitle(attrTitle(title: buttonTitle, color: UIColor.white), for: [.highlighted, .selected])
			}
		}
		self.titleIconPositionSetting()
	}
	
	private func backGroundImageSetting() {
		
		if self.frame.size.height == 0 {
			return
		}
		
		switch buttonIsBorder {
		case true:
			setBackgroundImage(backgroundImage(color: UIColor.white), for: .normal)
			setBackgroundImage(backgroundImage(color: buttonColor), for: .highlighted)
			setBackgroundImage(backgroundImage(color: buttonColor), for: .selected)
			setBackgroundImage(backgroundImage(color: color(color: buttonColor, alpha: 0.2)), for: .disabled)
			setBackgroundImage(backgroundImage(color: UIColor.white), for: [.highlighted, .selected])

		case false:
			setBackgroundImage(backgroundImage(color: buttonColor), for: .normal)
			setBackgroundImage(backgroundImage(color: color(color: buttonColor, alpha: 0.2)), for: .disabled)
			setBackgroundImage(backgroundImage(color: UIColor.white), for: .highlighted)
			setBackgroundImage(backgroundImage(color: UIColor.white), for: .selected)
			setBackgroundImage(backgroundImage(color: buttonColor), for: [.highlighted, .selected])

		}
	}
	
	private func borderSetting() {
		
		switch buttonIsBorder {
		case true:
			switch isEnabled {
			case true:
				self.layer.borderColor = buttonColor.cgColor
			case false:
				self.layer.borderColor = color(color: buttonColor, alpha: 0.3).cgColor
			}
				
			self.layer.borderWidth = 2.0

		case false:
			switch isEnabled {
			case true:
				self.layer.borderColor = buttonColor.cgColor
				self.layer.borderWidth = 2.0
			case false:
				self.layer.borderColor = color(color: buttonColor, alpha: 0.2).cgColor
				self.layer.borderWidth = 0
			}
		}
	}
	
	
	private func cornerSetting() {
		
		if buttonIsOval == true {
			let r:CGFloat = self.frame.size.height / 2.0
			self.layer.cornerRadius = r
		}else{
			self.layer.cornerRadius = buttonRound
		}
		
		self.layer.masksToBounds = true

	}
	
	private func iconImageSetting() {
		
		if var image = buttonIconImage {
			
			if buttonIsBorder == true {
				image = image.withRenderingMode(.alwaysOriginal)
				setImage(resizeImage(iconImage: image.withTintColor(buttonColor)), for: .normal)
				setImage(resizeImage(iconImage: image.withTintColor(.white)), for: .highlighted)
				setImage(resizeImage(iconImage: image.withTintColor(.white)), for: .selected)
				setImage(resizeImage(iconImage: image.withTintColor(color(color: buttonColor, alpha: 0.3))), for: .disabled)
				setImage(resizeImage(iconImage: image.withTintColor(buttonColor)), for: [.highlighted, .selected])
			}else{
				image = image.withRenderingMode(.alwaysOriginal)
				setImage(resizeImage(iconImage: image.withTintColor(.white)), for: .normal)
				setImage(resizeImage(iconImage: image.withTintColor(buttonColor)), for: .highlighted)
				setImage(resizeImage(iconImage: image.withTintColor(buttonColor)), for: .selected)
				setImage(resizeImage(iconImage: image.withTintColor(.white)), for: .disabled)
				setImage(resizeImage(iconImage: image.withTintColor(.white)), for: [.highlighted, .selected])
			}

			self.imageView?.contentMode = .scaleAspectFit
			
		}else{
			setImage(nil, for: .normal)
			setImage(nil, for: .highlighted)
			setImage(nil, for: .selected)
			setImage(nil, for: .disabled)
		}
		self.titleIconPositionSetting()
	}
	
	private func titleIconPositionSetting () {
		
		if buttonIconImage != nil {
			if buttonTitle.count > 0 {
				if self.contentHorizontalAlignment == .left {
					let space = buttonTitleFontSize / 6.0
					titleEdgeInsets = UIEdgeInsets(top: 0, left: 20+space, bottom: 0, right: 0)
					imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: space)
				}else{
					let space = buttonTitleFontSize / 6.0
					titleEdgeInsets = UIEdgeInsets(top: 0, left: space, bottom: 0, right: 0)
					imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: space)
				}
			}
		}else{
			if self.contentHorizontalAlignment == .left {
				titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
			}
		}
	}
	
	
	private func attrTitle(title:String, color:UIColor) -> NSAttributedString {
		
		var font:UIFont = UIFont.systemFont(ofSize: buttonTitleFontSize)
		if self.titleFontIsBold {
			font = UIFont.boldSystemFont(ofSize: buttonTitleFontSize)
		}
		
		let dict = [
			NSAttributedString.Key.font: font /*Font */,
			NSAttributedString.Key.foregroundColor: color /*文字色 */,
		]
				
		let str = NSAttributedString(string: title , attributes: dict)
		return str
	}
	
	private func backgroundImage(color:UIColor) -> UIImage {
		
		//グラデーション画像も作成できますがここではスタートとエンドを同色にしてベタ塗り画像を生成
		let startColor:UIColor = color
		let endColor:UIColor = color
		
		//* 自身のサイズ
		let size = CGSize(width: self.frame.size.width, height: self.frame.size.height)

		//* グラデーションイメージ生成
		let gradient = CAGradientLayer()
		gradient.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		gradient.colors = [startColor.cgColor, endColor.cgColor].compactMap { $0 }
		gradient.startPoint = CGPoint(x: 0.5, y: 1)
		gradient.endPoint = CGPoint(x: 0.5, y: 0)

		UIGraphicsBeginImageContextWithOptions(size, _: false, _: 0)
		if let context = UIGraphicsGetCurrentContext() {
			gradient.render(in: context)
		}
		let outputImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return outputImage!
		
	}
	
	private func color(color:UIColor, alpha:CGFloat) -> UIColor {
		
		let r:CGFloat = convertToRGB(color).red
		let g:CGFloat = convertToRGB(color).green
		let b:CGFloat = convertToRGB(color).blue
		let a:CGFloat = convertToRGB(color).alpha
		
		return UIColor(red: r, green: g, blue: b, alpha: a*alpha)
			
	}
	
	private func convertToRGB(_ color: UIColor) -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
		var components = color.cgColor.components! // UIColorをCGColorに変換し、RGBとAlphaがそれぞれCGFloatで配列として取得できる
		
		//無彩色の場合、グレースケールとアルファ値しか返ってこないので補完
		if components.count == 2 {
			components.insert(components[0], at: 1)
			components.insert(components[0], at: 2)
		}
		return (red: components[0], green: components[1], blue: components[2], alpha: components[3])
	}
	
	
	private func resizeImage(iconImage:UIImage) -> UIImage {

		let image = iconImage
		var resultImage: UIImage?

		var iconHeight:CGFloat = textHeight()
		iconHeight = iconHeight * self.buttonImageScale

		let rate = iconHeight / image.size.height
		let size = CGSize(width: (image.size.width ) * rate, height: (image.size.height ) * rate)

		UIGraphicsBeginImageContextWithOptions(size, _: false, _: 0)
		image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
		resultImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()

		return resultImage ?? image
	}
	
	
	private func textHeight() -> CGFloat {

		let str = attrTitle(title: "A", color: buttonColor)

		let label = UILabel()
		label.attributedText = str
		label.sizeToFit()

		return label.frame.size.height
	}
	
	private func isDark(color:UIColor) -> Bool {
		
		let r = convertToRGB(color).red
		let g = convertToRGB(color).green
		let b = convertToRGB(color).blue
		
		let gray = 0.299 * r + 0.587 * g + 0.144 * b
		
		return gray < 0.35 ? true : false
	}
	
	
	/// WBButton - ボタンのタイトルを設定します。
	/// - Parameter title: ボタンタイトル
	public func setTitle(title:String) {
		//setTitle
		DispatchQueue.main.async {
			self.buttonTitle = title
			self.titleSetting()
		}
	}
	
	/// WBButton - ボタンのテーマカラーを設定します。
	/// - Parameter color: テーマカラー
	public func setColor(color:UIColor) {
		//setBackgroundColor
		//setTitle
		//iconImage
		DispatchQueue.main.async {
			self.buttonColor = color
			self.titleSetting()
			self.borderSetting()
			self.backGroundImageSetting()
			self.iconImageSetting()
		}
	}
	
	/// WBButton - ボタン枠線の有無を設定します。
	/// - Parameter isBorder: true:白抜きフチありボタン　false:ベタ塗りフチなしボタン
	public func setBorder(isBorder:Bool) {
		//border
		//backgroundImage
		//title
		//iconImage
		
		DispatchQueue.main.async {
			self.buttonIsBorder = isBorder
			self.titleSetting()
			self.backGroundImageSetting()
			self.borderSetting()
			self.iconImageSetting()
		}
	}
	
	/// WBButton - 楕円形状ボタンか否かを設定。角丸のR設定よりこちらが優先されます。
	/// - Parameter isOval: true:楕円ボタン(角丸のR設定は無視), false:通常ボタン(角丸のR設定は反映)
	public func setOval(isOval:Bool) {
		//self.layer.cornerRadius
		DispatchQueue.main.async {
			self.buttonIsOval = isOval
			self.cornerSetting()
		}

	}
	
	/// WBButton - ボタンの角丸設定
	/// - Parameter cornerRadius: 角丸のRを設定
	public func setRound(cornerRadius:CGFloat) {
		//self.layer.cornerRadius
		DispatchQueue.main.async {
			self.buttonRound = cornerRadius
			self.cornerSetting()
		}

	}
	
	/// WBButton - ボタンの画像を設定
	/// - Parameter iconImage: タイトル左のアイコン画像
	public func setImage(iconImage:UIImage?) {
		//iconImage
		DispatchQueue.main.async {
			self.buttonIconImage = iconImage
			self.iconImageSetting()
		}

	}
	
	/// WBButton - ボタンのアイコン画像のサイズ調整
	/// - Parameter scale: アイコン画像の倍率を設定。
	/// タイトル文字列が存在する場合は先ず、文字の高さにアイコン画像の高さを合わせます。その後倍率が適用されます。
	public func setImageScale(scale:CGFloat) {
		//iconImage
		DispatchQueue.main.async {
			self.buttonImageScale = scale
			self.iconImageSetting()
		}

	}
	
	/// WBButton - ボタンタイトルの文字サイズを設定します。(デフォルト値17pt)
	/// - Parameter fontsize: フォントサイズ
	public func setTitleFontSize(fontsize:CGFloat) {
		//settitle
		DispatchQueue.main.async {
			self.buttonTitleFontSize = fontsize
			self.titleSetting()
			self.iconImageSetting()
		}

	}
	
	/// WBButton - ボタンタイトルの文字の太さを設定します
	/// - Parameter isBold: true:太字 W6(default) false:標準フォント W3
	public func setTitleIsBold(isBold:Bool) {
		//settitle
		DispatchQueue.main.async {
			self.buttonTitleFontIsBold = isBold
			self.titleSetting()
			self.iconImageSetting()
		}
	}
}
