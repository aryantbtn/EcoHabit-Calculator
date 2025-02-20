//
//  File.swift
//  EcoHabitor
//
//  Created by ARYAN SINGHAL on 20/02/25.
//

import Foundation
import SwiftUICore
import SwiftUI

// Used this Custom stepper view in the Home Screen

struct CustomStepperView: View {
    let icon: String
    let iconColor: Color
    let title: String
    @Binding var value: Int
    let range: ClosedRange<Int>
    let step: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(iconColor)
                    .frame(width: 30)
                
                Text(title)
                    .font(.headline)
                
                Spacer()
                
                Text("\(value)")
                    .padding(.trailing, 8)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
            }
            
            HStack {
                Spacer()
                Button(action: { if value > range.lowerBound { value -= step } }) {
                    Image(systemName: "minus.circle.fill")
                        .font(.title)
                        .foregroundColor(.green)
                }
                .disabled(value <= range.lowerBound)
                
                Button(action: { if value < range.upperBound { value += step } }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                        .foregroundColor(.green)
                }
                .disabled(value >= range.upperBound)
            }
            .padding(.top, 8)
        }
        .padding()
        .background(Color.green.opacity(0.1))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}
