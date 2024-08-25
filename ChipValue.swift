//
//  ChipValue.swift
//  PokerSettler
//
//  Created by Tingting Min on 6/1/24.
//

import Foundation

struct ChipValue: Identifiable {
    var id = UUID()
    var denomination: Int
    var value: Double
}
