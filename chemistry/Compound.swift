//
//  Compound.swift
//  chemistry
//
//  Created by Hayes Dombroski on 1/10/25.
//

import SwiftUI
import Elementary

struct Compound: Substance {
    var id: UUID = UUID()
    var elements: [AnySubstance]
    var coefficient: Int = 1
    var formulaSubscript: Int
    var molarMass: Double {
        return elements.reduce(0) { $0 + $1.molarMass } * Double(formulaSubscript)
    }
    var name: String {
        switch elements.count {
        case 1:
            return elements[0].name
        case 2:
            return "\(elements[0].name) \(elements[1].alternateName)"
        default:
            // TODO: LUT for common names
            return elements.reduce("") { $0 + $1.name + " " }
        }
    }
    var alternateName: String {
        // TODO: use this for something possibly?
        return "unimplemented"
    }
    var charge: Charge {
        // TODO: Implement
        return 0
    }

    var body: some View {
        HStack(spacing: 0) {
            Text("\(coefficient.stringIfGreaterThan(1))\(formulaSubscript > 1 ? "(" : "")")
            ForEach(elements) { element in
                element
            }
            Text("\(formulaSubscript > 1 ? ")\(formulaSubscript.subscriptString)" : "")")
        }
    }
}

#Preview {
    Compound(elements: [
        AnySubstance(Element(element: Elementary.Elements.hydrogen, formulaSubscript: 2)),
        AnySubstance(Element(element: Elementary.Elements.oxygen, formulaSubscript: 1))
    ], coefficient: 2, formulaSubscript: 1)
    .padding()
}
