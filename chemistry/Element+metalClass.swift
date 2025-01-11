//
//  Element+metalClass.swift
//  chemistry
//
//  Created by Hayes Dombroski on 1/11/25.
//


import Elementary

extension Elementary.Element {
    public var metalClass: MetalClass {
        switch category {
        case .alkaliMetal,
             .alkalineEarthMetal,
             .transitionMetal,
             .postTransitionMetal,
             .lanthanide,
             .actinide:
            return .metal

        case .diatomicNonmetal,
             .nobleGas,
             .polyatomicNonmetal,
             .solid,
             .metalloid,
             .unknown:
            return .nonmetal
        }
    }
    
    public enum MetalClass {
        case metal
        case nonmetal
    }
}
