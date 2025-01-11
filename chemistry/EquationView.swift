//
//  EquationView.swift
//  chemistry
//
//  Created by Hayes Dombroski on 1/10/25.
//

import SwiftUI
import Elementary

struct EquationView: View {
    var reactants: [AnySubstance]
    var products: [AnySubstance]
    
    var body: some View {
        HStack {
            if reactants.count == 0  && products.count == 0 {
                Text("Enter a chemical equation")
            }
            
            // reactants
            if reactants.count > 0 {
                HStack {
                    ForEach(0..<reactants.count, id: \.self) { i in
                        AnySubstanceInfoView(substance: reactants[i])
                        if i < reactants.count - 1 {
                            Text(" + ")
                        }
                    }
                }
            }
            
            // products
            if products.count > 0 {
                HStack {
                    ForEach(0..<products.count, id: \.self) { i in
                        AnySubstanceInfoView(substance: products[i])
                        if i < products.count - 1 {
                            Text(" + ")
                        }
                    }
                }
            }
        }
    }
    
    init(_ equation: Equation) {
        self.reactants = equation.reactants.map { AnySubstance($0) }
        self.products = equation.products.map { AnySubstance($0) }
    }
}

fileprivate func _EquationView_Preview_Parse(_ text: String) -> Equation {
    do {
        return try EquationParser.parse(text)
    } catch {
        print(error)
        return Equation(reactants: [], products: [])
    }
}

#Preview {
    EquationView(_EquationView_Preview_Parse("H2 + O2 -> H2O"))
        .padding()
}
