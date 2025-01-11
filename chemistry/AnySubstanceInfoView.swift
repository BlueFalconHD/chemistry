//
//  AnySubstanceInfoView.swift
//  chemistry
//
//  Created by Hayes Dombroski on 1/10/25.
//

import SwiftUI

public struct AnySubstanceInfoView: View {
    var substance: AnySubstance
    
    public var body: some View {
        VStack {
            substance
            Text(substance.name)
            Text("\(substance.molarMass, specifier: "%.2f") g/mol")
        }
    }
}
