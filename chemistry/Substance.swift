//
//  Substance.swift
//  chemistry
//
//  Created by Hayes Dombroski on 1/10/25.
//

import SwiftUI

protocol Substance: Identifiable, View {
    var id: UUID { get }
    var coefficient: Int { get set }
    var formulaSubscript: Int { get set }
    var molarMass: Double { get }
    var name: String { get }
    var alternateName: String { get }
    var charge: Charge { get }
}

