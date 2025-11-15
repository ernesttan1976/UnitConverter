//
//  ContentView.swift
//  UnitConverter
//
//  Created by Ernest Tan on 14/11/25.
//

import SwiftUI

func convert(selectedFromUnit: String, selectedToUnit: String, fromValueString: String)-> Double {
    let fromValue = Double(fromValueString) ?? 0.0
    switch selectedFromUnit+selectedToUnit {
        case "CelsiusFahrenheit":
            return fromValue * 9/5 + 32
        case "CelsiusKelvin":
            return fromValue + 273.15
        case "FahrenheitKelvin":
            return (fromValue - 32) * 5/9 + 273.15
        case "FahrenheitCelsius":
            return (fromValue - 32) * 5/9
        case "KelvinFahrenheit":
            return (fromValue - 273.15) * 9/5 + 32
        case "KelvinCelsius":
            return fromValue - 273.15
        case "MetersInches":
            return fromValue * 39.3701
        case "MetersFeet":
            return fromValue / 0.3048
        case "MetersYards":
            return fromValue / 0.9144
        case "MetersMiles":
            return fromValue / 1609.34
        case "InchesMeters":
            return fromValue / 39.3701
        case "InchesFeet":
            return fromValue / 12.0
        case "InchesYards":
            return fromValue / 36.0
        case "InchesMiles":
            return fromValue / 63360.0
        case "FeetMeters":
            return fromValue * 0.3048
        case "FeetInches":
            return fromValue * 12.0
        case "FeetYards":
            return fromValue / 3
        case "FeetMiles":
            return fromValue / 5280.0
        case "YardsMeters":
            return fromValue * 0.9144
        case "YardsInches":
            return fromValue * 36.0
        case "YardsFeet":
            return fromValue * 3.0
        case "YardsMiles":
            return fromValue / 1760.0
        case "MilesMeters":
            return fromValue * 1609.34
        case "MilesFeet":
            return fromValue * 5280.0
        case "MilesYards":
            return fromValue * 1760.0
        case "MilesInches":
            return fromValue * 63360.0
        case "Sq.MetersSq.Inches":
            return fromValue * 1550.03
        case "Sq.MetersSq.Feet":
            return fromValue * 10.7639
        case "Sq.MetersSq.Yards":
            return fromValue * 1.19599
        case "Sq.MetersSq.Miles":
            return fromValue / 2589988.11
        case "Sq.InchesSq.Meters":
            return fromValue / 1550.03
        case "Sq.InchesSq.Feet":
            return fromValue / 144.0
        case "Sq.InchesSq.Yards":
            return fromValue / 1296.0
        case "Sq.InchesSq.Miles":
            return fromValue / 4014489600.0
        case "Sq.FeetSq.Meters":
            return fromValue / 10.7639
        case "Sq.FeetSq.Inches":
            return fromValue * 144.0
        case "Sq.FeetSq.Yards":
            return fromValue / 9.0
        case "Sq.FeetSq.Miles":
            return fromValue / 27878400.0
        case "Sq.YardsSq.Meters":
            return fromValue / 1.19599
        case "Sq.YardsSq.Inches":
            return fromValue * 1296.0
        case "Sq.YardsSq.Feet":
            return fromValue * 9.0
        case "Sq.YardsSq.Miles":
            return fromValue / 3097600.0
        case "Sq.MilesSq.Meters":
            return fromValue * 2589988.11
        case "Sq.MilesSq.Inches":
            return fromValue * 4014489600.0
        case "Sq.MilesSq.Feet":
            return fromValue * 27878400.0
        case "Sq.MilesSq.Yards":
            return fromValue * 3097600.0
        case "LitresOunces":
            return fromValue * 33.814
        case "LitresPints":
            return fromValue * 2.11338
        case "LitresBarrels":
            return fromValue / 119.240471
        case "OuncesLitres":
            return fromValue / 33.814
        case "OuncesPints":
            return fromValue / 16.0
        case "OuncesBarrels":
            return fromValue / 5376.0
        case "PintsLitres":
            return fromValue / 2.11338
        case "PintsOunces":
            return fromValue * 16.0
        case "PintsBarrels":
            return fromValue / 336.0
        case "BarrelsLitres":
            return fromValue * 119.240471
        case "BarrelsOunces":
            return fromValue * 5376.0
        case "BarrelsPints":
            return fromValue * 336.0
        default:
            return 0.0
    }
}

func swap(a: inout String, b: inout String) {
    let temp = a
    a = b
    b = temp
}

struct ContentView: View {
    @FocusState private var numberFieldFocused: Bool

    let conversionTypes = ["Temperature","Length","Area","Volume"]
    @State private var selectedConversionType = "Temperature"
    let units: [[String]] = [
        ["Celsius","Fahrenheit","Kelvin"],
        ["Meters","Inches","Feet","Yards","Miles"],
        ["Sq.Meters","Sq.Inches","Sq.Feet","Sq.Yards","Sq.Miles"],
        ["Litres","Ounces","Pints","Barrels"]
    ]
    @State private var selectedFromUnit = "Celsius"
    @State private var selectedToUnit = "Celsius"
    @State private var fromValue = "0.0"

    var toValue: Double {
        return convert(selectedFromUnit: selectedFromUnit, selectedToUnit: selectedToUnit, fromValueString: fromValue)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Type of conversion", selection: $selectedConversionType) {
                        ForEach(conversionTypes, id: \.self){
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    HStack {
                        TextField("From",  text: $fromValue)
                            .frame(width: 120, alignment: .init(horizontal: .trailing, vertical: .center))
                            .keyboardType(.decimalPad)
                            .focused($numberFieldFocused)
                            
                            Picker("", selection: $selectedFromUnit) {
                                ForEach(units[conversionTypes.firstIndex(of: selectedConversionType) ?? 0], id: \.self){
                                    Text("\($0)")
                                }
                            }.pickerStyle(.menu)
                    }
                    .frame(width: 300)

                    HStack {
                        Text("\(toValue.formatted())").frame(width: 120, alignment: .init(horizontal: .center, vertical: .center))
                        Picker("", selection: $selectedToUnit) {
                            ForEach(units[conversionTypes.firstIndex(of: selectedConversionType) ?? 0], id: \.self){
                                Text("\($0)")
                            }
                        }.pickerStyle(.menu)
                    }
                    .frame(width: 300)

                    HStack {
                        Spacer()
                        Button("Swap") {
                            swap(a: &selectedFromUnit, b: &selectedToUnit)
                        }
                    }.frame(width: 300)
                    
                    
                }
            }
            .navigationTitle("Unit Converter")
            .navigationBarTitleDisplayMode(.large)
            .toolbar{
                if numberFieldFocused {
                    Button("Done") {
                        numberFieldFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
