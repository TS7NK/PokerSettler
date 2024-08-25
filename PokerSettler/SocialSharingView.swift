//
//  SocialSharingView.swift
//  PokerSettler
//
//  Created by Tingting Min on 6/1/24.
//

import SwiftUI
import UIKit

struct SocialSharingView: View {
    var payouts: [Payout]
    var chipValues: [Int: Double]
    
    var body: some View {
        VStack {
            Text("Share Results")
                .font(.largeTitle)
            
            List(payouts, id: \.id) { payout in
                Text("\(payout.player.name): \(payout.amount >= 0 ? "won" : "lost") $\(abs(payout.amount))")
            }
            
            let transfers = calculateZelleTransfers(payouts: payouts)
            
            Text("Zelle Transactions")
                .font(.headline)
                .padding(.top)
            
            List(transfers, id: \.self) { transfer in
                Text(transfer)
            }
            
            Button(action: shareResults) {
                Text("Share")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
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
    
    func shareResults() {
        let results = payouts.map { "\($0.player.name): \($0.amount >= 0 ? "won" : "lost") $\(abs($0.amount))" }.joined(separator: "\n")
        let transfers = calculateZelleTransfers(payouts: payouts).joined(separator: "\n")
        let totalText = "Game Results:\n\n\(results)\n\nZelle Transactions:\n\n\(transfers)"
        
        let activityVC = UIActivityViewController(activityItems: [totalText], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
        }
    }
}

struct SocialSharingView_Previews: PreviewProvider {
    static var previews: some View {
        SocialSharingView(payouts: [], chipValues: [:])
    }
}
