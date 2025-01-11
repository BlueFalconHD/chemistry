//
//  Int+toPrefix.swift
//  chemistry
//
//  Created by Hayes Dombroski on 1/10/25.
//

extension Int {
    func toPrefix() -> String {
        let knownPrefixes: [Int: String] = [
            1: "mono",
            2: "di",
            3: "tri",
            4: "tetra",
            5: "penta",
            6: "hexa",
            7: "hepta",
            8: "octa",
            9: "nona",
            10: "deca",
            11: "undeca",
            12: "dodeca",
            13: "trideca",
            14: "tetradeca",
            15: "pentadeca",
            16: "hexadeca",
            17: "heptadeca",
            18: "octadeca",
            19: "nonadeca",
            20: "icosa"
        ]
        
        if let prefix = knownPrefixes[self] {
            return prefix
        } else {
            // compound rarely has subscripts larger than 20, but if they do return number
            return "\(self)"
        }
    }
}
