//
//  MTMessengerView.swift
//  MTMessengerSample
//
//  Created by Imai Hiroshi on 3/10/24.
//

import UIKit

@available(iOS 13.0, *)
open class MTMessenger: NSObject {
	
	private override init() {
		super.init()
	}
	public static let shared = MTMessenger()
	fileprivate var messageview = MTMessengerView()
	var displayTime:Double?
	var taskArray: [(message: String, at: Double)] = []
	var isBusy: Bool = false
//	var skip: Int = 0
	var dismissAfter: DispatchWorkItem?

	/// メッセージ表示の設定
	/// - Parameter message: メッセージ
	public func set(message: String) {
		self.set(message: message, at: nil)
	}
	
	/// メッセージ表示の設定　時間指定あり
	/// - Parameter message: メッセージ
	/// - Parameter displayTime: メッセージ表示時間 default:2.0
	public func set(message:String, at displayTime: Double?) {
		DispatchQueue.main.async {
			self.taskArray.append((message: message, at: displayTime ?? 2.0))
			self.action()
		}
	}
	
	func action() {
		
		if taskArray.count > 0 && isBusy == false {
			isBusy = true
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
				self.show(message: self.taskArray[0].message, at: self.taskArray[0].at)
				self.taskArray.removeFirst()
			}
		}
	}
	
	func show(message: String, at displayTime: Double?){
		
		self.displayTime = displayTime
		let safeAreaTop = MTSize.Safearea.top

		/// UIWindowの取得
		let window = MTView.getWindow(level: 1000)
		guard let window = window else {return}
		window.isUserInteractionEnabled = true
		
		//表示するPLMessengerViewのインスタンス化
		self.messageview.messageLabel.text = message
		self.messageview.MTMessengerViewSetting()
		self.messageview.isUserInteractionEnabled = true
		self.messageview.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: safeAreaTop - 100)
		window.addSubview(self.messageview)

		//上スワイプ用のインスタンスを生成する
		let upSwipe = UISwipeGestureRecognizer(
			target: self,
			action: #selector(self.didSwipe(_:))
		)
		upSwipe.direction = .up
		self.messageview.messageLabel.addGestureRecognizer(upSwipe)
		
		
		/// アニメーションの設定
		DispatchQueue.main.async {
			
			UIView.animate(withDuration: 0.4, animations: {
				/// 0.4秒で上から出てくる
				var offset:CGFloat = 0.0
				if safeAreaTop > 20 {
					offset = safeAreaTop - 20.0
				}
				
				self.messageview.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: 15 + (self.messageview.frame.height / 2) + offset)

			}) { finished in
				
				/// default2秒静止
				self.dismissAfter = DispatchQueue.main.cancelableAsyncAfter(deadline: .now() + (self.displayTime ?? 2.0)) {
					self.dismiss()
				}
			}
		}
	}
	
	
	private func dismiss() {
		
		let safeAreaTop = MTSize.Safearea.top
		
		UIView.animate(withDuration: 0.2, animations: {
			/// 0.2秒で上に消える
			self.messageview.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: safeAreaTop - 100)
		}) { finished in
			/// ビューを消去
			self.messageview.removeFromSuperview()
			self.isBusy = false
			self.action()
		}
	}
	
	@objc
	private func didSwipe(_ sender: UISwipeGestureRecognizer) {
		
		//スワイプ方向による実行処理をcase文で指定
		switch sender.direction {
		case .up:
			//上スワイプ時に実行したい処理
			self.dismissAfter?.cancel()
			self.dismiss()
			
//		case .right:
//			//右スワイプ時に実行したい処理
//		case .down:
//			//下スワイプ時に実行したい処理
//		case .left:
//			//左スワイプ時に実行したい処理
		default:
			break
		}
	}
}


private class MTMessengerView: UIView {

	@IBOutlet weak var messageLabel: PLMessageLabel!
	
	override init(frame: CGRect){
		super.init(frame: frame)
		loadNib()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)!
		loadNib()
	}
	
	func loadNib(){
		
		if let view = Bundle.module.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
			view.frame = self.bounds
			self.addSubview(view)
		}
		
		DispatchQueue.main.async {
//			self.MTMessengerViewSetting()
		}
	}
	
	/// 表示サイズの調整と、シャドウの設定
	fileprivate func MTMessengerViewSetting() {
		
		self.messageLabel.frame = CGRectZero
		self.messageLabel.sizeToFit()
		self.messageLabel.isUserInteractionEnabled = true
		
		var MTMessengerWidth:CGFloat = messageLabel.frame.size.width
		if MTMessengerWidth >  (UIScreen.main.bounds.size.width - 80){
			MTMessengerWidth = UIScreen.main.bounds.size.width - 80
		}
		
		self.messageLabel.frame = CGRect(x: 0, y: 0, width: MTMessengerWidth, height: messageLabel.frame.size.height + 12)
		
		messageLabel.layer.cornerRadius = ( messageLabel.frame.height + 12 ) / 2
		messageLabel.layer.masksToBounds = true

		self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: MTMessengerWidth + 40, height: messageLabel.frame.size.height + 12)
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowRadius = 30
		self.layer.shadowOpacity = 0.25
		self.layer.shadowOffset = CGSize(width: 0, height: 10)
		
	}
}


/// 表示領域、左右に20ptのマージンがあるUILabel
private class PLMessageLabel: UILabel {
	
	override func drawText(in rect: CGRect) {
		let insets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
		super.drawText(in: rect.inset(by: insets))
	}
}
