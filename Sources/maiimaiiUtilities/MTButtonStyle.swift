//
//  MTButtonStyle.swift
//  LocapoManager
//
//  Created by Imai Hiroshi on 1/16/25.
//

import SwiftUI


/// buttonWidth, buttonHeightは32.0以上を指定
@available(iOS 13.0, *)
public struct MTBasicButtonStyle: ButtonStyle {
	var color: Color
	var borderedMode: Bool
	var cornerRadius: CGFloat
	var isOval: Bool
	var icon: Image?
	var buttonWidth: CGFloat?
	var buttonHeight: CGFloat?

	public init(color: Color, borderedMode: Bool, cornerRadius: CGFloat, isOval: Bool, icon: Image? = nil, buttonWidth: CGFloat? = nil, buttonHeight: CGFloat? = nil) {
		self.color = color
		self.borderedMode = borderedMode
		self.cornerRadius = cornerRadius
		self.isOval = isOval
		self.icon = icon
		self.buttonWidth = buttonWidth
		self.buttonHeight = buttonHeight
	}
	
	public func makeBody(configuration: Configuration) -> some View {
		
		let adjustedWidth = (buttonWidth ?? 0) >= 32 ? (buttonWidth! - 32) : nil
		let adjustedHeight = (buttonHeight ?? 0) >= 32 ? (buttonHeight! - 32) : nil

		if let width = buttonWidth, width < 32 {
			print("Warning: buttonWidth must be at least 32.0pt")
		}

		if let height = buttonHeight, height < 32 {
			print("Warning: buttonHeight must be at least 32.0pt")
		}

		return HStack {
			if let icon = icon {
				icon
					.foregroundColor(
						borderedMode ? (configuration.isPressed ? .white : color) : 
						(configuration.isPressed ? color : .white)
					)
			}
			configuration.label
		}
		.frame(width: adjustedWidth, height: adjustedHeight)
		.padding()
		.foregroundColor(
			borderedMode ? (configuration.isPressed ? .white : color) : 
			(configuration.isPressed ? color : .white)
		)
		.background(
			borderedMode ? (configuration.isPressed ? color : Color.white) : 
			(configuration.isPressed ? Color.white : color)
		)
		.cornerRadius(isOval ? 500 : cornerRadius)
		.overlay(
			RoundedRectangle(cornerRadius: isOval ? 500 : cornerRadius)
				.stroke(
					(borderedMode && !configuration.isPressed) ? color : 
					(!borderedMode && configuration.isPressed ? color : Color.clear), 
					lineWidth: 2
				)
		)
	}
}


// 拡張例
@available(iOS 13.0, *)
struct CustomButtonStyle: ButtonStyle {
	var icon: Image?
	var buttonWidth: CGFloat
	
	func makeBody(configuration: Configuration) -> some View {
		MTBasicButtonStyle(
			color: .red, 
			borderedMode: true, 
			cornerRadius: 8, 
			isOval: true, 
			icon: icon, 
			buttonWidth: buttonWidth
		).makeBody(configuration: configuration)
		.shadow(color: .gray, radius: 5)
	}
}
