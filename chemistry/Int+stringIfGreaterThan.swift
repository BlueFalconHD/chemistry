//
//  Int+stringIfGreaterThan.swift
//  chemistry
//
//  Created by Hayes Dombroski on 1/10/25.
//

extension Int {
    /// Returns a string representation of the integer if it is greater than the threshold, otherwise returns an empty string.
    func stringIfGreaterThan(_ threshold: Int) -> String {
        return self > threshold ? "\(self)" : ""
    }
}
