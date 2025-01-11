//
//  EquationParser.swift
//  chemistry
//
//  Created by Hayes Dombroski on 1/10/25.
//

import SwiftUI
import Foundation
import Elementary

enum EquationParseError: Error {
    case invalidFormat
    case invalidElementSymbol(String)
}

struct EquationParser {
    
    static func parse(_ input: String) throws -> Equation {
        // Normalize the input to handle different formats
        let normalizedInput = normalizeInput(input)
        
        // Split the equation into reactants and products
         var sides = normalizedInput.components(separatedBy: "->")
//        guard sides.count == 2 else {
//            throw EquationParseError.invalidFormat
//        }
        
        // Add an extra side array element to prevent out of bounds error
        if sides.count == 1 {
            sides.append("")
        }
        
        let reactantsString = sides[0]
        let productsString = sides[1]
        
        // Parse reactants and products into Substance arrays
        let reactants = try parseSubstances(reactantsString)
        let products = try parseSubstances(productsString)
        
        // Create and return an Equation object
        let equation = Equation(
            reactants: reactants.map { AnySubstance($0) },
            products: products.map { AnySubstance($0) }
        )
        
        return equation
    }
    
    private static func normalizeInput(_ input: String) -> String {
        var output = input
        
        // Replace unicode arrows with ASCII '->'
        output = output.replacingOccurrences(of: "→", with: "->")
        
        // Remove whitespaces
        output = output.replacingOccurrences(of: " ", with: "")
        
        // Replace Unicode subscript characters with regular digits
        output = replaceUnicodeSubscripts(in: output)
        
        // Replace dot notation (e.g., H.2) with standard notation (H2)
        output = replaceDotSubscripts(in: output)
        
        // Replace LaTeX-style subscripts (e.g., H_{2}) with standard notation (H2)
        output = replaceUnderscoreSubscripts(in: output)
        
        return output
    }
    
    private static func replaceUnicodeSubscripts(in input: String) -> String {
        var output = ""
        let unicodeSubscriptMap: [Character: Character] = [
            "₀": "0",
            "₁": "1",
            "₂": "2",
            "₃": "3",
            "₄": "4",
            "₅": "5",
            "₆": "6",
            "₇": "7",
            "₈": "8",
            "₉": "9"
        ]
        
        for char in input {
            if let digit = unicodeSubscriptMap[char] {
                output.append(digit)
            } else {
                output.append(char)
            }
        }
        return output
    }
    
    private static func replaceDotSubscripts(in input: String) -> String {
        // Replace occurrences of '.' followed by digits (e.g., H.2 -> H2)
        let pattern = "\\.(\\d+)"
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(input.startIndex..., in: input)
        let result = regex?.stringByReplacingMatches(
            in: input,
            options: [],
            range: range,
            withTemplate: "$1"
        )
        return result ?? input
    }
    
    private static func replaceUnderscoreSubscripts(in input: String) -> String {
        // Replace occurrences of '_{digits}' (e.g., H_{2} -> H2)
        let pattern = "_\\{(\\d+)\\}"
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(input.startIndex..., in: input)
        let result = regex?.stringByReplacingMatches(
            in: input,
            options: [],
            range: range,
            withTemplate: "$1"
        )
        return result ?? input
    }
    
    private static func parseSubstances(_ input: String) throws -> [AnySubstance] {
        // Split the input into individual substances based on '+'
        let components = input.components(separatedBy: "+")
        var substances: [AnySubstance] = []
        
        for component in components {
            if let substance = try parseSubstance(component) {
                substances.append(AnySubstance(substance))
            }
        }
        return substances
    }
    
    private static func parseSubstance(_ input: String) throws -> AnySubstance? {
        // Match optional coefficient and formula
        let pattern = "^(\\d+)?(.*)$"
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(input.startIndex..., in: input)
        
        guard let match = regex?.firstMatch(in: input, options: [], range: range) else {
            return nil
        }
        
        // Extract coefficient if present
        var coefficient = 1
        if let coeffRange = Range(match.range(at: 1), in: input),
           !coeffRange.isEmpty {
            coefficient = Int(input[coeffRange]) ?? 1
        }
        
        // Extract formula and parse it
        if let formulaRange = Range(match.range(at: 2), in: input) {
            let formula = String(input[formulaRange])
            if var compound = try parseFormula(formula) {
                compound.coefficient = coefficient
                return AnySubstance(compound)
            }
        }
        return nil
    }
    
    private static func parseFormula(_ formula: String) throws -> Compound? {
        // Pattern to match elements, coefficients, and their optional subscripts
        // old pattern for only subscripts: let pattern = "([A-Z][a-z]?)(\\d*)"
        let pattern = "([A-Z][a-z]?)(\\d*)"
        
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(formula.startIndex..., in: formula)
        let matches = regex?.matches(in: formula, options: [], range: range) ?? []
        
        var elements: [AnySubstance] = []
        for match in matches {
            // Extract element symbol
            if let elementRange = Range(match.range(at: 1), in: formula) {
                let symbol = String(formula[elementRange])
                // Extract subscript if present
                let subscriptString = (match.range(at: 2).location != NSNotFound) ?
                    String(formula[Range(match.range(at: 2), in: formula)!]) : ""
                let subscriptValue = Int(subscriptString) ?? 1
                // Get the Element from the symbol
                if let element = Elements.allElements.first(where: { $0.symbol == symbol }) {
                    let elementSubstance = Element(element: element, formulaSubscript: subscriptValue)
                    elements.append(AnySubstance(elementSubstance))
                } else {
                    throw EquationParseError.invalidElementSymbol(symbol)
                }
            }
        }
        
        if elements.isEmpty {
            return nil
        }
        
        // Create a Compound with the parsed elements
        let compound = Compound(elements: elements, formulaSubscript: 1)
        return compound
    }
}
