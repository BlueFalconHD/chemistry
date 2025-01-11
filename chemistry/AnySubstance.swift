//
//  AnySubstance.swift
//  chemistry
//
//  Created by Hayes Dombroski on 1/10/25.
//

import SwiftUI

struct AnySubstance: Substance {
    var id: UUID
    var coefficient: Int
    var formulaSubscript: Int
    var molarMass: Double
    var name: String
    var alternateName: String
    var charge: Charge
    private let _body: AnyView

    init<S: Substance>(_ substance: S) {
        self.id = substance.id
        self.coefficient = substance.coefficient
        self.formulaSubscript = substance.formulaSubscript
        self.molarMass = substance.molarMass
        self.name = substance.name
        self.alternateName = substance.alternateName
        self.charge = substance.charge
        self._body = AnyView(substance.body)
    }

    var body: some View {
        _body
    }
}
