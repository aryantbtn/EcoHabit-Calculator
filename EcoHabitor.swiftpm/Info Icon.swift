//
//  File.swift
//  EcoHabitor
//
//  Created by ARYAN SINGHAL on 10/02/25.
//

import SwiftUI
struct InfoView: View {
    @State private var isAnimating = false
    var body: some View {
        NavigationView{
            ScrollView {
                VStack(spacing: 20) {
                    
                    // Subtitle
                    Text("Learn how small habits make a big impact on the environment!")
                                            .font(.system(.title3, design: .rounded))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(
                                                LinearGradient(
                                                    colors: [.green, .blue],
                                                    startPoint: .leading,
                                                    endPoint: .trailing
                                                )
                                            )
                                            .multilineTextAlignment(.center)
                                            .padding(.horizontal, 24)
                                            .padding(.vertical, 12)
                                            .background(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(.white)
                                                    .shadow(color: .black.opacity(0.1), radius: 8)
                                            )
                                            .scaleEffect(isAnimating ? 1 : 0.9)
                                            .opacity(isAnimating ? 1 : 0)
                                            .onAppear {
                                                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                                    isAnimating = true
                                                }
                                            }
                    
                    // Card 1: Eco-Friendly Habits
                    InfoCardView(
                        icon: "leaf.circle.fill",
                        iconColor: .green,
                        title: "Track Your Eco Habits",
                        description: """
                                    The EcoHabit Calculator helps you track your daily activities and calculate the reduction in carbon emissions. Simple actions like waking up early, reducing water and electricity consumption, or avoiding single-use plastics can contribute to a greener planet.
                                    """, backgroundColor: .white
                        
                    )
                    
                    // Card 2: Transportation Impact
                    InfoCardView(
                        icon: "bus.doubledecker.fill",
                        iconColor: .blue,
                        title: "Transportation & Emissions",
                        description: """
                                    Using sustainable transport choices significantly cuts down emissions:
                                                • Public Transport: Reduces emissions by **80%** compared to a car.
                                                • Electric Vehicles: Save approximately **70% of CO₂** compared to gasoline cars.
                                                • Cycling: Saves **411 g CO₂ per mile**.
                                                • Walking: If you walk **30 minutes**, you save the equivalent of **X kg CO₂**.
                                    """,
                        backgroundColor: .white
                    )
                    
                    // Card 3: Smoking Awareness
                    InfoCardView(
                        icon: "lungs.fill",
                        iconColor: .red,
                        title: "Smoking & Carbon Emissions",
                        description: """
                                    Smoking not only harms personal health but also has an environmental impact. Cigarette production, packaging, and transportation contribute to CO₂ emissions.
                                    
                                                • A single cigarette emits about 0.02 kg of CO₂ when smoked.
                                                • Reducing cigarette consumption helps lower both personal health risks** and environmental pollution**.
                                    
                                    Try reducing your cigarette intake daily and track how much CO₂ you can save while improving your well-being!
                                    """,
                        backgroundColor: .white
                    )
                    
                    // Card 4: Energy Conservation
                    InfoCardView(
                        icon: "lightbulb.fill",
                        iconColor: .yellow,
                        title: "Energy Conservation",
                        description: """
                                    Reducing energy consumption helps lower your carbon footprint:
                                                • Saving 1 kWh of electricity reduces **0.7 kg CO₂**.
                                                • Reducing AC usage** by 1 hour can save **0.8 kg CO₂**.
                                                • Turning off unused devices significantly lowers energy waste.
                                    """,
                        backgroundColor: .white
                    )
                    
                    // Card 5: Sustainable Eating
                    InfoCardView(
                        icon: "leaf.fill",
                        iconColor: .green,
                        title: "Diet & Plastic Reduction",
                        description: """
                                    Your food choices and plastic usage impact carbon emissions:
                                                • Skipping 1 meat-based meal** saves 2.0 kg CO₂.
                                                • Choosing a vegetarian meal** reduces emissions by **up to 80%.
                                                • Avoiding single-use plastics** reduces waste and cuts down emissions.
                                    """,
                        backgroundColor: .white
                    )
                    
                    // Card 6: Water Conservation
                    InfoCardView(
                        icon: "drop.fill",
                        iconColor: .blue,
                        title: "Save Water, Save CO₂",
                        description: """
                                    By saving water, recycling bottles, and using public transport, you can save significant amounts of CO₂ emissions. For example:
                                                • Saving 1 kWh of electricity reduces approximately 0.7 kg of CO₂.
                                                • Recycling one bottle saves about 0.05 kg of CO₂.
                                                • Avoiding 1 hour of air conditioning usage can save up to 0.8 kg of CO₂.
                                    """,
                        backgroundColor: .white
                    )
                    
                    // Card 7: Teamwork in Sustainability
                    InfoCardView(
                        icon: "hands.sparkles.fill",
                        iconColor: .orange,
                        title: "Together, We Make a Difference!",
                        description: """
                                    Together, these small changes can lead to a big impact. Track your habits daily and contribute to making the world a better place for everyone. Let’s take a step forward toward sustainability!
                                    """,
                        backgroundColor: .white
                    )
                    
                }
            }
            .background(Color(.green).opacity(0.1))
            .navigationTitle("About Eco-Habitor 🌍")
            .navigationBarTitleDisplayMode(.large)
        }
        .navigationBarBackButtonHidden(true)
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
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(iconColor)
                    .padding(16)
                    .background(
                        Circle()
                            .fill(iconColor.opacity(0.1))
                    )
                
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(description)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, 8)
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(backgroundColor)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 4)
                .shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 8)
        )
        .padding(.horizontal, 16)
    }
}
