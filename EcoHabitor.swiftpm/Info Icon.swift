//
//  File.swift
//  EcoHabitor
//
//  Created by ARYAN SINGHAL on 10/02/25.
//

import SwiftUI
struct InfoView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Title
                Text("About EcoHabit Calculator")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top)

                // Subtitle
                Text("Learn how small habits make a big impact on the environment!")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // Image 1: Representing eco-friendly habits
                Image(systemName: "leaf.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.green)
                    .padding()

                // Text Content 1
                Text("""
                        The EcoHabit Calculator helps you track your daily activities and calculate the reduction in carbon emissions. Simple actions like waking up early, reducing water and electricity consumption, or avoiding single-use plastics can contribute to a greener planet.
                    """)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)

                // Image 2: Highlighting a sustainable lifestyle
                Image(systemName: "drop.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.blue)
                    .padding()

                // Text Content 2
                Text("""
                    By saving water, recycling bottles, and using public transport, you can save significant amounts of CO₂ emissions. For example:
                    - Saving 1 kWh of electricity reduces approximately 0.7 kg of CO₂.
                    - Recycling one bottle saves about 0.05 kg of CO₂.
                    - Avoiding 1 hour of air conditioning usage can save up to 0.8 kg of CO₂.
                    """)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)

                // Image 3: Showcasing teamwork in sustainability
                Image(systemName: "hands.sparkles.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .foregroundColor(.orange)
                    .padding()

                // Text Content 3
                Text("""
Together, these small changes can lead to a big impact. Track your habits daily and contribute to making the world a better place for everyone. Let’s take a step forward toward sustainability!
""")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // Close Button
                Button(action: {
                    dismiss()
                }) {
                    Text("Close")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(12)
                }
                .padding()
            }
        }
    }

    @Environment(\.presentationMode) private var presentationMode

    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}
