//
//  textFieldWithPadding.swift
//  Oncology
//
//  Created by Imai Hiroshi on 10/25/22.
//  Copyright © 2022 CompanyName. All rights reserved.
//

import UIKit

open  class textFieldWithPadding: UITextField {

	/// テキストの内側の余白
	@IBInspectable var topPadding: CGFloat = 0.0
	@IBInspectable var leftPadding: CGFloat = 0.0
	@IBInspectable var bottomPadding: CGFloat = 0.0
	@IBInspectable var rightPadding: CGFloat = 0.0


	open override func textRect(forBounds bounds: CGRect) -> CGRect {
		// テキストの内側に余白を設ける
		return bounds.inset(by: UIEdgeInsets(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding))
	}

	open override func editingRect(forBounds bounds: CGRect) -> CGRect {
		// 入力中のテキストの内側に余白を設ける
		return bounds.inset(by: UIEdgeInsets(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding))
	}

	open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
		// プレースホルダーの内側に余白を設ける
		return bounds.inset(by: UIEdgeInsets(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding))
	}

}
