//
//  TSExtensions.swift
//  TellerSecureTransfer
//
//  Created by Vamsi Krishna Tirumala on 20/02/21.
//

import UIKit
import Foundation

extension UIColor {
  static let TFBrandColor = UIColor(red: 135.0/255.0, green: 175.0/255.0, blue: 78.0/255.0, alpha: 1.0)
}

extension UIView {
    func cornerRadius(radius : Int) {
        self.layer.cornerRadius = CGFloat(radius)
        self.layer.masksToBounds = true
    }
    
    func shake(count : Float? = nil, for duration : TimeInterval? = nil, withTranslation translation : Float? = nil) {
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        animation.repeatCount = count ?? 5
        animation.duration = 1.5
        animation.speed = 30.0
        animation.autoreverses = true
        animation.byValue = translation ?? -12
        layer.add(animation, forKey: "shake")
    }
}

extension UIViewController {
    /******** creates and presents 2 kinds of alert views from any View Controller. *******/
    /******** 1. If completion handler has one item inside array, then it shows Default alert view. *******/
    /******** 2. If completion handler has two items inside array, then it shows confirmation alert view. *******/
    func presentSystemAlert(title: String?, message: String?, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension UIButton {
    func underlineHyperlink() {
        guard let text = self.titleLabel?.text else { return }
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        
        self.setAttributedTitle(attributedString, for: .normal)
    }
}

extension String {
    var data: Data { Data(utf8) }
    var base64Encoded: Data { data.base64EncodedData() }
    var base64Decoded: Data? { Data(base64Encoded: self) }
}

extension Data {
    var base64Decoded: Data? { Data(base64Encoded: self) }
    var string: String? { String(data: self, encoding: .utf8) }
}
