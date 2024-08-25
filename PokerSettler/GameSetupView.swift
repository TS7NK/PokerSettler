//
//  GameSetupView.swift
//  PokerSettler
//
//  Created by Tingting Min on 6/1/24.
//

import SwiftUI

struct GameSetupView: View {
    @State private var chipValues: [Int: Double] = [:]
    
    var body: some View {
        VStack {
            Text("Game Setup")
                .font(.largeTitle)
                .padding(.top, 50) //Padding space between top of the sceen and the title
                .padding(.bottom,40) //Space between title and first enrty row
            
            ForEach([1, 5, 10, 50, 100], id: \.self) { denomination in
                HStack {
                    Image("chip\(denomination)")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .padding(.trailing, 20)
                    
                    TextField("Value", value: $chipValues[denomination], formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .frame(width: 150) // Limit the width of the text field

                    
                    Spacer() // Pushes the content to the left
                }
                .padding([.leading, .trailing], 40) // Add padding to the sides
                .padding(.bottom, 20) // Add padding between rows
            }
            
            Spacer() // Push everything up
            
            NavigationLink(destination: PlayerManagementView(chipValues: chipValues)) {
                Text("Next")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.bottom, 50) // Add padding at the bottom
        }
        .padding()
    }
}

struct GameSetupView_Previews: PreviewProvider {
    static var previews: some View {
        GameSetupView()
    }
}
