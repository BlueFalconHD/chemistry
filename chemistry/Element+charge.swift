//
//  Element+charge.swift
//  chemistry
//
//  Created by Hayes Dombroski on 1/11/25.
//

import Elementary

enum Charge {
    case known(Int)
    case unknown
}

extension Elementary.Element {
    var charge: Charge {
        // x starts left
        // x = 1: +1
        // x = 2: +2
        // x = 13: +3
        // x = 15: -3
        // x = 16: -2
        // x = 17: -1
        // x = 18: 0
        // Zn, Cd: +2
        // Ag: +1
        // anything else: unknown, other ion subscript -> charge
        
        var c: Charge = .unknown
        
        if position.y > 8 {
            return c
        }
        
        switch position.x {
        case 1:
            c = .known(1)
        case 2:
            c = .known(2)
        case 13:
            c = .known(3)
        case 15:
            c = .known(-3)
        case 16:
            c = .known(-2)
        case 17:
            c = .known(-1)
        case 18:
            c = .known(0)
        default:
            switch symbol {
            case "Zn", "Cd":
                c = .known(2)
            case "Ag":
                c = .known(1)
            default:
                c = .unknown
            }
        }
        
        return c
    }
}
