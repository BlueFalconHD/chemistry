//
//  Int+superscriptString.swift
//  chemistry
//
//  Created by Hayes Dombroski on 1/10/25.
//

import Foundation

extension Int {
    var superscriptString: String {
        let superscriptDigits: [String] = ["⁰", "¹", "²", "³", "⁴", "⁵", "⁶", "⁷", "⁸", "⁹"]
        let digits = String(self).compactMap { Int(String($0)) }
        return digits.map { superscriptDigits[$0] }.joined()
    }
}
