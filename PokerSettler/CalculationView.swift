//
//  CalculationView.swift
//  PokerSettler
//
//  Created by Tingting Min on 6/1/24.
//

//import SwiftUI
//
//struct CalculationView: View {
//    var players: [Player]
//    var chipValues: [Int: Double]
//    
//    var body: some View {
//        VStack {
//            Text("Calculation")
//                .font(.largeTitle)
//            
//            let payouts = calculatePayouts()
//            
//            List(payouts, id: \.id) { payout in
//                Text("\(payout.player.name): \(payout.amount >= 0 ? "won" : "lost") $\(abs(payout.amount))")
//            }
//            
//            Text("Zelle Transactions")
//                .font(.headline)
//                .padding(.top)
//            
//            List(calculateZelleTransfers(payouts: payouts), id: \.self) { transfer in
//                Text(transfer)
//            }
//            
//            NavigationLink(destination: SocialSharingView(payouts: payouts, chipValues: chipValues)) {
//                Text("Share Results")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
//        }
//        .padding()
//    }
//    
//    func calculatePayouts() -> [Payout] {
//        return players.map { player in
//            let finalValue = chipValues.reduce(0.0) { total, chip in
//                total + (chip.value * Double(player.finalChipCounts[chip.key] ?? 0))
//            }
//            let amount = finalValue - player.initialBuyIn
//            return Payout(player: player, amount: amount)
//        }
//    }
//    
//    func calculateZelleTransfers(payouts: [Payout]) -> [String] {
//        var winners = payouts.filter { $0.amount > 0 }
//        let losers = payouts.filter { $0.amount < 0 }
//        
//        var transfers: [String] = []
//        var totalWinnings = winners.reduce(0) { $0 + $1.amount }
//        
//        for loser in losers {
//            var amountOwed = abs(loser.amount)
//            for winner in winners {
//                if amountOwed == 0 {
//                    break
//                }
//                if winner.amount == 0 {
//                    continue
//                }
//                
//                let transferAmount = min(amountOwed, winner.amount)
//                amountOwed -= transferAmount
//                totalWinnings -= transferAmount
//                
//                transfers.append("\(loser.player.name) should Zelle $\(transferAmount) to \(winner.player.name)")
//                
//                if let winnerIndex = winners.firstIndex(where: { $0.id == winner.id }) {
//                    winners[winnerIndex].amount -= transferAmount
//                }
//            }
//        }
//        
//        if totalWinnings > 0 {
//            transfers.append("There is an unbalanced amount of $\(totalWinnings) that could not be settled.")
//        }
//        
//        return transfers
//    }
//}
//
//struct CalculationView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalculationView(players: [], chipValues: [:])
//    }
//}
//
//struct Payout: Identifiable {
//    var id = UUID()
//    var player: Player
//    var amount: Double
//}


import SwiftUI

struct CalculationView: View {
    var players: [Player]
    var chipValues: [Int: Double]
    
    var body: some View {
        VStack {
            Text("Calculation")
                .font(.largeTitle)
            
            let payouts = calculatePayouts()
            
            List(payouts, id: \.id) { payout in
                Text("\(payout.player.name): \(payout.amount >= 0 ? "won" : "lost") $\(String(format: "%.2f", abs(payout.amount)))")
            }
            
            Text("Zelle Transactions")
                .font(.headline)
                .padding(.top)
            
            List(calculateZelleTransfers(payouts: payouts), id: \.self) { transfer in
                Text(transfer)
            }
            
            NavigationLink(destination: SocialSharingView(payouts: payouts, chipValues: chipValues)) {
                Text("Share Results")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
    
    func calculatePayouts() -> [Payout] {
        return players.map { player in
            let finalValue = player.totalChipValue(chipValues: chipValues)
            let amount = finalValue - player.initialBuyIn
            return Payout(player: player, amount: amount)
        }
    }
    
    func calculateZelleTransfers(payouts: [Payout]) -> [String] {
        var winners = payouts.filter { $0.amount > 0 }
        let losers = payouts.filter { $0.amount < 0 }
        
        var transfers: [String] = []
        var totalWinnings = winners.reduce(0) { $0 + $1.amount }
        
        for loser in losers {
            var amountOwed = abs(loser.amount)
            for winner in winners {
                if amountOwed == 0 {
                    break
                }
                if winner.amount == 0 {
                    continue
                }
                
                let transferAmount = min(amountOwed, winner.amount)
                amountOwed -= transferAmount
                totalWinnings -= transferAmount
                
                transfers.append("\(loser.player.name) should Zelle $\(transferAmount) to \(winner.player.name)")
                
                if let winnerIndex = winners.firstIndex(where: { $0.id == winner.id }) {
                    winners[winnerIndex].amount -= transferAmount
                }
            }
        }
        
        if totalWinnings > 0 {
            transfers.append("There is an unbalanced amount of $\(totalWinnings) that could not be settled.")
        }
        
        return transfers
    }
}

struct CalculationView_Previews: PreviewProvider {
    static var previews: some View {
        CalculationView(players: [], chipValues: [1: 1.0, 5: 5.0, 10: 10.0, 50: 50.0, 100: 100.0])
    }
}

struct Payout: Identifiable {
    var id = UUID()
    var player: Player
    var amount: Double
}
