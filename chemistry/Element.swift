//
//  Element.swift
//  chemistry
//
//  Created by Hayes Dombroski on 1/10/25.
//

import Elementary
import SwiftUI

import Elementary
import SwiftUI

struct Element: Substance {
    var id: UUID = UUID()
    var element: Elementary.Element
    var coefficient: Int = 1
    var formulaSubscript: Int
    var molarMass: Double {
        return element.mass * Double(formulaSubscript)
    }
    var name: String {
        return element.name
    }
    var alternateName: String {
        // add prefix and suffix
        let prefix = formulaSubscript.toPrefix()
        var name = name.lowercased()
        
        // common remappings
        let remappings: [String: String] = [
            "fluorine": "fluoride",
            "chlorine": "chloride",
            "bromine": "bromide",
            "iodine": "iodide",
            "carbon": "carbide",
            "nitrogen": "nitride",
            "oxygen": "oxide",
            "phosphorus": "phosphide",
            "sulfur": " sulfide",
            "selenium": "selenide",
            "tellurium": "telluride",
            "arsenic": "arsenide",
            "antimony": "antimonide",
            "polonium": "polonide",
            "hydrogen": "hydride",
            "boron": "boride",
            "silicon": "silicide",
            "germanium": "germanide",
            "tin": "stannide",
            "lead": "plumbide",
        ]
        
        if let remapped = remappings[name] {
            name = remapped
        }
        
        for (i, char) in name.enumerated() {
            // get character from mono string, with i=0 starting at end of string
            let prefixChar = name[name.index(name.endIndex, offsetBy: -i - 1)]
            // if the character is the same as the prefix character, remove it
            if char == prefixChar {
                name.remove(at: name.index(name.endIndex, offsetBy: -i - 1))
            } else {
                // non-contiguous match
                break
            }
            
        }
        
        return "\(prefix)\(name)"
    }
    var charge: Charge {
        return element.charge
    }

    var body: some View {
        Text("\(coefficient.stringIfGreaterThan(1))\(element.symbol)\(formulaSubscript > 1 ? formulaSubscript.subscriptString : "")")
    }
}

#Preview {
    Element(element: Elementary.Elements.hydrogen, coefficient: 2, formulaSubscript: 2)
    .padding()
}
