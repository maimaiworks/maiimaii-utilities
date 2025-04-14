//
//  UILabelWithPadding.swift
//  maiimaiiUtilities
//
//  Created by Imai Hiroshi on 4/14/25.
//

import UIKit

class UILabelWithPadding: UILabel {

	@IBInspectable var topPadding: CGFloat = 10
	@IBInspectable var bottomPadding: CGFloat = 10
	@IBInspectable var leftPadding: CGFloat = 10
	@IBInspectable var rightPadding: CGFloat = 10
	
	override func drawText(in rect: CGRect) {
		super.drawText(in: rect.inset(by: UIEdgeInsets.init(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding)))
	}
	
	override var intrinsicContentSize: CGSize {
		var size = super.intrinsicContentSize
		size.height += (topPadding + bottomPadding)
		size.width += (leftPadding + rightPadding)
		return size
	}
}
