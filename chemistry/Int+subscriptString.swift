//
//  Int+subscriptString.swift
//  chemistry
//
//  Created by Hayes Dombroski on 1/10/25.
//

import Foundation

extension Int {
    var subscriptString: String {
        let subscriptDigits: [String] = ["₀", "₁", "₂", "₃", "₄", "₅", "₆", "₇", "₈", "₉"]
        let digits = String(self).compactMap { Int(String($0)) }
        return digits.map { subscriptDigits[$0] }.joined()
    }
}
