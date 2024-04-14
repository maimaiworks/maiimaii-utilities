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
