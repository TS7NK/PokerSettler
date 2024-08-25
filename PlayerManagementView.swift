//
//  PlayerManagementView.swift
//  PokerSettler
//
//  Created by Tingting Min on 6/1/24.
//

import SwiftUI

struct PlayerManagementView: View {
    @State private var players: [Player] = []
    @State private var name: String = ""
    @State private var initialBuyIn: String = ""
    @State private var finalChipCounts: [Int: Int] = [1: 0, 5: 0, 10: 0, 50: 0, 100: 0]
    
    var chipValues: [Int: Double]
    
    var body: some View {
        VStack {
            Text("Player Management")
                .font(.largeTitle)
            
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Initial Buy-In", text: $initialBuyIn)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .padding()
            
            VStack {
                Text("Final Chip Count")
                    .font(.headline)
                
                ForEach([1, 5, 10, 50, 100], id: \.self) { denomination in
                    HStack {
                        Image("chip\(denomination)")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding(.trailing, 10)
                        
                        TextField("Count", value: $finalChipCounts[denomination], formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                            .frame(width: 100)
                        
                        Spacer()
                        
                        Text("Value: $\(chipValues[denomination] ?? 0, specifier: "%.2f")")
                    }
                    .padding([.leading, .trailing], 20) // Add padding to the sides
                    .padding(.vertical, 5) // Decrease vertical padding between rows
                }
            }
            
            Button(action: addPlayer) {
                Text("Add Player")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            List(players) { player in
                Text("\(player.name): $\(player.initialBuyIn) - \(player.finalChipCountDescription(chipValues: chipValues))")
            }
            
            NavigationLink(destination: CalculationView(players: players, chipValues: chipValues)) {
                Text("Calculate")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
    
    func addPlayer() {
        if let initial = Double(initialBuyIn) {
            let newPlayer = Player(name: name, initialBuyIn: initial, finalChipCounts: finalChipCounts)
            players.append(newPlayer)
            name = ""
            initialBuyIn = ""
            finalChipCounts = [1: 0, 5: 0, 10: 0, 50: 0, 100: 0]
        }
    }
}

struct PlayerManagementView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerManagementView(chipValues: [1: 1.0, 5: 5.0, 10: 10.0, 50: 50.0, 100: 100.0])
    }
}
