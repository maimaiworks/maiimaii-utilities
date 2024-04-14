//
//  MTLoadingView.swift
//  maiimaiiUtilities
//
//  Created by Imai Hiroshi on 2/21/23.
//  Copyright © 2023 CompanyName. All rights reserved.
//

import UIKit

open class MTLoadingView: NSObject {

	private override init() {
		super.init()
	}
	public static let shared = MTLoadingView()
	
	var loading:MTLoadingCircleView?
//	var window:UIWindow?
	private var cnt: Int = 0
	public var backgroundMode:loadingViewBackgroundMode = .clear
	public var isBackgroundAccessible:Bool = false
	public var color:UIColor = .darkGray
	public var circleThicknness:loadingCircleThickness = .thin
	
	
	public func show() {
		
		MTLoadingView.shared.cnt += 1
		
		if MTLoadingView.shared.cnt == 1 {
			
			if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
				window.frame = UIScreen.main.bounds
				window.windowLevel = UIWindow.Level.normal + 1000
				window.isUserInteractionEnabled = true
				
				MTLoadingView.shared.loading = MTLoadingCircleView()
				guard let loading = MTLoadingView.shared.loading else { return }
				loading.backgroundMode = self.backgroundMode
				loading.isBackgroundAccessible = self.isBackgroundAccessible
				loading.color = self.color
				loading.loadingCircleThickness = self.circleThicknness
				loading.alpha = 0.0
				loading.frame = window.frame
				window.addSubview(loading)
				
				UIView.animate(withDuration: 0.25) { 
					// ここに処理を書く
					self.loading?.alpha = 1.0
				}
			}
		}
	}
	
	
	public func dismiss() {
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			
			MTLoadingView.shared.cnt -= 1
			
			if MTLoadingView.shared.cnt == 0 {
				
				UIView.animate(withDuration: 0.25) {
					// ここに処理を書く
					MTLoadingView.shared.loading?.alpha = 0.0
				}
			}
		}
	}
}
