//
//  EquationEditorView.swift
//  chemistry
//
//  Created by Hayes Dombroski on 1/10/25.
//

import SwiftUI

struct EquationEditorView: View {
    
    @State var enteredEquation: String = ""
    @State var equation: Equation?
    
    @State var errorMessage: String = ""
    
    var body: some View {
        VStack {
            HStack {
                if let equation = equation {
                    EquationView(equation)
                }
            }
            .padding()
            TextField("Enter equation", text: $enteredEquation)
                .textFieldStyle(.roundedBorder)
                .onChange(of: enteredEquation) { newValue in
                    do {
                        equation = try EquationParser.parse(newValue)
                        errorMessage = ""
                    } catch EquationParseError.invalidFormat {
                        equation = nil
                        errorMessage = "Invalid format for equation, please try again"
                    } catch EquationParseError.invalidElementSymbol(let symbol) {
                        equation = nil
                        errorMessage = "Invalid element symbol: \(symbol)"
                    } catch {
                        equation = nil
                        errorMessage = "An unknown error occurred"
                    }
                }
                .padding()
            if errorMessage != "" {
                HStack {
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundColor(.red)
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
            }
        }
        .padding()
    }
}

#Preview {
    EquationEditorView()
}
