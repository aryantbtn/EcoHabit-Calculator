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

                // Card 1: Eco-Friendly Habits
                InfoCardView(
                    icon: "leaf.circle.fill",
                    iconColor: .green,
                    title: "Track Your Eco Habits",
                    description: """
                                    The EcoHabit Calculator helps you track your daily activities and calculate the reduction in carbon emissions. Simple actions like waking up early, reducing water and electricity consumption, or avoiding single-use plastics can contribute to a greener planet.
                                    """,
                    backgroundColor: Color.green.opacity(0.2)
                )

                // Card 2: Transportation Impact
                InfoCardView(
                    icon: "bus.doubledecker.fill",
                    iconColor: .blue,
                    title: "Transportation & Emissions",
                    description: """
                                    Using sustainable transport choices significantly cuts down emissions:
                                    - **Public Transport**: Reduces emissions by **80%** compared to a car.
                                    - **Electric Vehicles**: Save approximately **70% of CO₂** compared to gasoline cars.
                                    - **Cycling**: Saves **411 g CO₂ per mile**.
                                    - **Walking**: If you walk **30 minutes**, you save the equivalent of **X kg CO₂**.
                                    """,
                    backgroundColor: Color.blue.opacity(0.2)
                )

                // Card 3: Smoking Awareness
                InfoCardView(
                    icon: "lungs.fill",
                    iconColor: .red,
                    title: "Smoking & Carbon Emissions",
                    description: """
                                    Smoking not only harms personal health but also has an environmental impact. Cigarette production, packaging, and transportation contribute to CO₂ emissions.

                                    - A single cigarette emits about **0.02 kg of CO₂** when smoked.
                                    - Reducing cigarette consumption helps lower both **personal health risks** and **environmental pollution**.

                                    Try reducing your cigarette intake daily and track how much CO₂ you can save while improving your well-being!
                                    """,
                    backgroundColor: Color.red.opacity(0.2)
                )

                // Card 4: Energy Conservation
                InfoCardView(
                    icon: "lightbulb.fill",
                    iconColor: .yellow,
                    title: "Energy Conservation",
                    description: """
                                    Reducing energy consumption helps lower your carbon footprint:
                                    - **Saving 1 kWh** of electricity reduces **0.7 kg CO₂**.
                                    - **Reducing AC usage** by 1 hour can save **0.8 kg CO₂**.
                                    - **Turning off unused devices** significantly lowers energy waste.
                                    """,
                    backgroundColor: Color.yellow.opacity(0.2)
                )

                // Card 5: Sustainable Eating
                InfoCardView(
                    icon: "leaf.fill",
                    iconColor: .green,
                    title: "Diet & Plastic Reduction",
                    description: """
                                    Your food choices and plastic usage impact carbon emissions:
                                    - **Skipping 1 meat-based meal** saves **2.0 kg CO₂**.
                                    - **Choosing a vegetarian meal** reduces emissions by **up to 80%**.
                                    - **Avoiding single-use plastics** reduces waste and cuts down emissions.
                                    """,
                    backgroundColor: Color.green.opacity(0.2)
                )

                // Card 6: Water Conservation
                InfoCardView(
                    icon: "drop.fill",
                    iconColor: .blue,
                    title: "Save Water, Save CO₂",
                    description: """
                                    By saving water, recycling bottles, and using public transport, you can save significant amounts of CO₂ emissions. For example:
                                    - Saving 1 kWh of electricity reduces approximately 0.7 kg of CO₂.
                                    - Recycling one bottle saves about 0.05 kg of CO₂.
                                    - Avoiding 1 hour of air conditioning usage can save up to 0.8 kg of CO₂.
                                    """,
                    backgroundColor: Color.blue.opacity(0.2)
                )

                // Card 7: Teamwork in Sustainability
                InfoCardView(
                    icon: "hands.sparkles.fill",
                    iconColor: .orange,
                    title: "Together, We Make a Difference!",
                    description: """
                                    Together, these small changes can lead to a big impact. Track your habits daily and contribute to making the world a better place for everyone. Let’s take a step forward toward sustainability!
                                    """,
                    backgroundColor: Color.orange.opacity(0.2)
                )

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

struct InfoCardView: View {
    var icon: String
    var iconColor: Color
    var title: String
    var description: String
    var backgroundColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(iconColor)
                
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }
            
            Text(description)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
            
        }
        .padding()
        .background(backgroundColor)
        .cornerRadius(12)
        .shadow(radius: 3)
    }
}
