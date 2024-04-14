//
//  MTLoadingCircleView.swift
//  maiimaiiUtilities
//
//  Created by Imai Hiroshi on 2/21/23.
//  Copyright © 2023 CompanyName. All rights reserved.
//

import UIKit


public enum loadingViewBackgroundMode {
	case smoke
	case clear
}
public enum loadingCircleThickness {
	case thin
	case light
	case regular
}


open class MTLoadingCircleView: UIView {
	
	@IBOutlet weak var baseView: UIView!
	@IBOutlet weak var loadingView: UIVisualEffectView!
	@IBOutlet weak var circle: UIImageView!
	
	var color:UIColor = .darkGray
	var backgroundMode: loadingViewBackgroundMode = .clear
	var isBackgroundAccessible: Bool = false
	var loadingCircleThickness: loadingCircleThickness = .thin
	
	
	override init(frame: CGRect){
		super.init(frame: frame)
		loadNib()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)!
		loadNib()
	}
	
	func loadNib(){
		
		if let view = Bundle.module.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
			view.frame = self.bounds
			self.addSubview(view)
		}
		
//		let nib = UINib(nibName: String(describing: type(of: self)), bundle: Bundle.module)
//		guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
//		view.frame = self.bounds
//		self.addSubview(view)

		DispatchQueue.main.async {
			self.initialSetting()
		}
	}
	
	func initialSetting() {
		
//  TODO: カラー系のメソッド
		
		loadingView.layer.cornerRadius = 8.0
		loadingView.layer.masksToBounds = true
		circle.tintColor = self.color
		
		if backgroundMode == .clear {
			// clear
			baseView.backgroundColor = .clear
		}else{
			// smoke
			baseView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
		}
		if isBackgroundAccessible == true {
//			self.baseView.isUserInteractionEnabled = false
			self.isUserInteractionEnabled = false

		}else{
//			self.baseView.isUserInteractionEnabled = true
			self.isUserInteractionEnabled = true
		}
		
		if loadingCircleThickness == .thin {
			circle.image = UIImage(named: "circle_thin", in:Bundle.module, compatibleWith: nil)
		}else if loadingCircleThickness == .light {
			circle.image = UIImage(named: "circle_light", in: Bundle.module, compatibleWith: nil)
		}else{
			circle.image = UIImage(named: "circle_regular", in: Bundle.module, compatibleWith: nil)
		}
		
		
		
		
		// configure rotationAnimation
		let rotationAnimation = CABasicAnimation(keyPath:"transform.rotation.z")
		rotationAnimation.toValue = CGFloat(Double.pi / 180) * 360
		rotationAnimation.duration = 2.0
		
		// greatestFiniteMagnitude will cause the animation to repeat forever.
		rotationAnimation.repeatCount = .greatestFiniteMagnitude
				
		circle.layer.add(rotationAnimation, forKey: "rotationAnimation")
		
	}

}
