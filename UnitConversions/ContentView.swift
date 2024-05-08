//
//  ContentView.swift
//  UnitConversions
//
//  Created by Leo Torres Neyra on 3/10/23.
//

import SwiftUI

struct ContentView: View {
    @State private var firstTemperature = "Celsius"
    @State private var secondTemperature = "Fahrenheit"
    @State private var temperature = 0.0
    @FocusState private var temperatureIsFocused: Bool
    
    let temperatures = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var result: Double {
        let unit: UnitTemperature
        
        switch firstTemperature {
            case "Celsius":
                unit = UnitTemperature.celsius
            case "Fahrenheit":
                unit = UnitTemperature.fahrenheit
            default:
                unit = UnitTemperature.kelvin
        }
        
        let t = Measurement(value: temperature, unit: unit)
        
        switch secondTemperature {
            case "Celsius":
                return t.converted(to: .celsius).value
            case "Fahrenheit":
                return t.converted(to: .fahrenheit).value
            default:
                return t.converted(to: .kelvin).value
            
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Temperatures", selection: $firstTemperature) {
                        ForEach(temperatures, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("From: ")
                }
                
                Section {
                    Picker("Temperatures", selection: $secondTemperature) {
                        ForEach(temperatures, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("To: ")
                }
                
                Section {
                    TextField("Temperature to convert", value: $temperature, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($temperatureIsFocused)
                    
                } header: {
                    Text("Enter the temperature that you want to convert")
                }
                
                Section {
                    Text("\(result.formatted())")
                } header: {
                    Text("Result:")
                }
            }
            .navigationTitle("Unit Conversions")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        temperatureIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
