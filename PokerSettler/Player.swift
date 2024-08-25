//
//  Player.swift
//  PokerSettler
//
//  Created by Tingting Min on 6/1/24.
//

//import Foundation
//
//struct Player: Identifiable {
//    var id = UUID()
//    var name: String
//    var initialBuyIn: Double
//    var finalChipCounts: [Int: Int]
//    
//    func finalChipCountDescription(chipValues: [Int: Double]) -> String {
//        return finalChipCounts.map {
//            let chipValue = chipValues[$0.key] ?? 0
//            let totalValue = chipValue * Double($0.value)
//            return "\($0.key): \($0.value) (\(String(format: "%.2f", totalValue)))"
//        }.joined(separator: ", ")
//    }
//}

//import Foundation
//
//struct Player: Identifiable {
//    let id = UUID()
//    let name: String
//    let initialBuyIn: Double
//    let finalChipCounts: [Int: Int]
//    
//    var finalChipCountDescription: String {
//        finalChipCounts.map { "\($0.key): \($0.value)" }.joined(separator: ", ")
//    }
//}

//struct Player: Identifiable {
//    let id = UUID()
//    let name: String
//    let initialBuyIn: Double
//    let finalChipCounts: [Int: Int]
//    
//    func totalChipValue(chipValues: [Int: Double]) -> Double {
//        return finalChipCounts.reduce(0) { $0 + (Double($1.value) * (chipValues[$1.key] ?? 0)) }
//    }
//    
//    var finalChipCountDescription: String {
//        finalChipCounts.map { "\($0.key): \($0.value)" }.joined(separator: ", ")
//    }
//}
