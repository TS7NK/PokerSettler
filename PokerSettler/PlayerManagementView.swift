//
//  PlayerManagementView.swift
//  PokerSettler
//
//  Created by Tingting Min on 6/1/24.
//
//import SwiftUI
//
//struct PlayerManagementView: View {
//    @State private var players: [Player] = []
//    @State private var name: String = ""
//    @State private var initialBuyIn: String = ""
//    @State private var finalChipCounts: [Int: Int] = [1: 0, 5: 0, 10: 0, 50: 0, 100: 0]
//    
//    var chipValues: [Int: Double]
//    
//    var body: some View {
//        VStack {
//            Text("Player Management")
//                .font(.largeTitle)
//                .padding(.top, 50)
//            
//            TextField("Name", text: $name)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding(.bottom, 10)
//            
//            TextField("$ Initial Buy-In", text: $initialBuyIn)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .keyboardType(.decimalPad)
//                .padding(.bottom, 10)
//            
//            VStack {
//                Text("Final Chip Count")
//                    .font(.headline)
//                    .padding(.top, 10)
//                
//                ForEach([1, 5, 10, 50, 100], id: \.self) { denomination in
//                    HStack {
//                        Image("chip\(denomination)")
//                            .resizable()
//                            .frame(width: 40, height: 40)
//                            .padding(.trailing, 10)
//                        
//                        TextField("Count", value: $finalChipCounts[denomination], formatter: NumberFormatter())
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                            .keyboardType(.numberPad)
//                            .frame(width: 100)
//                        
//                        Spacer()
//                    }
//                    .padding(.bottom)
//                }
//            }
//            
//            Button(action: addPlayer) {
//                Text("Add Player")
//                    .padding()
//                    .background(Color.green)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            
//            List(players) { player in
//            Text("\(player.name): $\(player.initialBuyIn) - \(player.finalChipCountDescription)")
//            }
//            
//            NavigationLink(destination: CalculationView(players: players, chipValues: chipValues)) {
//                Text("Calculate")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .padding()
//        }
//        .padding()
//    }
//    
//    func addPlayer() {
//        if let initial = Double(initialBuyIn) {
//            let newPlayer = Player(name: name, initialBuyIn: initial, finalChipCounts: finalChipCounts)
//            players.append(newPlayer)
//            // Reset the input fields
//            name = ""
//            initialBuyIn = ""
//            finalChipCounts = [1: 0, 5: 0, 10: 0, 50: 0, 100: 0]
//        }
//    }
//}
//
//struct PlayerManagementView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerManagementView(chipValues: [:])
//    }
//}


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
                .padding(.top, 50)
            
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
            
            TextField("$ Initial Buy-In", text: $initialBuyIn)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .padding(.bottom, 10)
            
            VStack {
                Text("Final Chip Count")
                    .font(.headline)
                    .padding(.top, 10)
                
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
                    }
                    .padding(.bottom)
                }
            }
            
            Button(action: addPlayer) {
                Text("Add Player")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            List(players) { player in
                Text("\(player.name): $\(player.initialBuyIn) - \(player.finalChipCountDescription)")
            }
            
            NavigationLink(destination: CalculationView(players: players, chipValues: chipValues)) {
                Text("Calculate")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
    
    func addPlayer() {
        if let initial = Double(initialBuyIn) {
            let newPlayer = Player(name: name, initialBuyIn: initial, finalChipCounts: finalChipCounts)
            players.append(newPlayer)
            // Reset the input fields
            name = ""
            initialBuyIn = ""
            finalChipCounts = [1: 0, 5: 0, 10: 0, 50: 0, 100: 0]
        }
    }
}

struct Player: Identifiable {
    let id = UUID()
    let name: String
    let initialBuyIn: Double
    let finalChipCounts: [Int: Int]
    
    func totalChipValue(chipValues: [Int: Double]) -> Double {
        return finalChipCounts.reduce(0) { $0 + (Double($1.value) * (chipValues[$1.key] ?? 0)) }
    }
    
    var finalChipCountDescription: String {
        finalChipCounts.map { "\($0.key): \($0.value)" }.joined(separator: ", ")
    }
}

struct PlayerManagementView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerManagementView(chipValues: [1: 1.0, 5: 5.0, 10: 10.0, 50: 50.0, 100: 100.0])
    }
}



