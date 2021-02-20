//
//  TSCommonFunctions.swift
//  TellerSecureTransfer
//
//  Created by Vamsi Krishna Tirumala on 20/02/21.
//

import UIKit
import QuartzCore
import Foundation

final class TSCommonFunctions: NSObject {

    // MARK: Shared Instance.
    static let shared = TSCommonFunctions()
    private override init() {}
    
    func applyFadeAnimationToLayer(layer : CALayer, duration : CGFloat) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = CFTimeInterval(duration)
        layer.add(animation, forKey: "kCATransitionFade")
    }
}
