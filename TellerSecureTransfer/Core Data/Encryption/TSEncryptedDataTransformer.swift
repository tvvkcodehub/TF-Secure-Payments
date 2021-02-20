//
//  TSEncryptedDataTransformer.swift
//  TellerSecureTransfer
//
//  Created by Vamsi Krishna Tirumala on 20/02/21.
//

import UIKit

class TSEncryptedDataTransformer: ValueTransformer {
    
    override class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let date = value as? String else {return nil}
        return date.data(using: .utf8)?.base64EncodedData()
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? String, let decoded = Data(base64Encoded: data) else {return nil}
        return String(data: decoded, encoding: .utf8)
    }
}
