//
//  MTScrollingStackView.swift
//  maiimaiiUtility
//
//  Created by Imai Hiroshi on 3/27/24.
//

import UIKit

public class MTScrollingStackView: UIView {

	@IBOutlet public weak var stack: UIStackView!

	override init(frame: CGRect){
		super.init(frame: frame)
		loadNib()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)!
		loadNib()
	}
	
	func loadNib(){
		
		// 直接プロジェクトに打ち込む場合はこちら
		// if let view = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView
		
		if let view = Bundle.module.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
			view.frame = self.bounds
			self.addSubview(view)
		}
		DispatchQueue.main.async {
			self.initialSetting()
		}
	}
	
	func initialSetting() {
		
	}

}
