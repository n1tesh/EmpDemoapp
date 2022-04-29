//
//  StringExtensions.swift
//  EmpDemoApp
//
//  Created by Nitesh on 29/04/22.
//

import Foundation

extension String {
    
    var isWhitespace: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

}
public extension SignedNumeric {

    /// SwifterSwift: String.
    var string: String {
        return String(describing: self)
    }

}
