//
//  File.swift
//  EcoHabitor
//
//  Created by ARYAN SINGHAL on 10/02/25.
//

import SwiftUI


struct MainTabView: View {
    
    init() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.green]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        UINavigationBar.appearance().tintColor = .green
        }
    
    @StateObject private var historyViewModel = HistoryViewModel()
    var body: some View {
        TabView {
            HomeScreen(historyViewModel: historyViewModel).tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            HistoryScreen(historyViewModel: historyViewModel)
                .tabItem {
                    Label("History", systemImage: "clock.fill")
            }
        }
    }
}


struct HomeScreen: View {
    
    @ObservedObject var historyViewModel: HistoryViewModel
    
    // State variables for user inputs
    @State private var wakeUp_Early: Bool = false
    @State private var water_Intake: Double = 0.0
    @State private var steps_Walked_Today: Int = 0
    
    @State private var avoid_Using_Car_Today: Bool = false
    @State private var transport_Mode_Used: String = "Public Transport"
    let transportOptions = [
        "bus.fill",       // Public Transport
        "bolt.car",  // Electric Vehicle
        "bicycle",        // Cycle
        "figure.walk"     // Walking
    ]
    @State private var cycleTime: Int = 0
    @State private var cycleDistance: Double = 0.0
    @State private var walkTime: Int = 0
    @State private var stepsTaken: Int = 0
    
    @State private var avoided_Single_Used_Plastic: Bool = false
    @State private var bottles_Recycled: Int = 0
    @State private var reusable_Items: Int = 0
    
    @State private var isSmoker: Bool = false
    @State private var cigarettesSmoked: Int = 0
    
    @State private var isVegan: Bool = false
    @State private var vegMeals: Int = 0
    @State private var shower_Time_Reduced: Int = 0
    
    @State private var device_TurnedOff: Int = 0
    @State private var reducedACUsage: Bool = false
    @State private var acHoursReduced: Int = 0
    

    // State variable for carbon reduction result
    @State private var carbonReduction: Double = 0.0

    @State private var showInfoModal: Bool = false
    
    private var hasUserInput: Bool {
        wakeUp_Early || water_Intake > 0 || steps_Walked_Today > 0 || avoid_Using_Car_Today || avoided_Single_Used_Plastic || bottles_Recycled > 0 || reusable_Items > 0 || (isSmoker && cigarettesSmoked >= 0) || (isVegan && vegMeals > 0) || shower_Time_Reduced > 0 || device_TurnedOff > 0 || (reducedACUsage && acHoursReduced > 0)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    VStack(spacing: 17) {
                        Text("Enter your daily habits to calculate your carbon emission reductions.")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(LinearGradient(colors: [.green, .blue.opacity(0.7)], startPoint:.topLeading, endPoint: .bottomTrailing))
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                            .background(RoundedRectangle(cornerRadius: 15).fill(LinearGradient(colors: [.white, Color.green.opacity(0.15)], startPoint: .topLeading, endPoint: .bottomTrailing)).shadow(color: .green.opacity(0.2), radius: 8, x: 0, y: 4)).padding(.horizontal).animation(.easeInOut(duration: 0.5), value: showInfoModal)
                        }
                        .padding(.top, 10)
                
                        // MARK:- Wake Up Early Toggle
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "sunrise.fill")
                                    .font(.title2)
                                    .foregroundColor(.orange)
                                Toggle("Did you wake up early today?", isOn: $wakeUp_Early)
                                    .font(.headline)
                            }
                        }
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)
                
                    // MARK:- Water Intake Slider
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "drop.fill").font(.title2).foregroundColor(.blue)
                            Text("Water Intake (liters)").font(.headline)
                        }
                        Text("\(String(format: "%.1f", water_Intake)) L").font(.title2).fontWeight(.bold).foregroundColor(.green)
                        Slider(value: $water_Intake, in: 0...5, step: 0.1).accentColor(.green)
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                    
                    // Walking Stepper
                    CustomStepperView(
                        icon: "figure.walk",
                        iconColor: .green,
                        title: "Steps Walked Today",
                        value: $steps_Walked_Today,
                        range: 0...30000,
                        step: 1000
                    )
                
                    
                    // Avoid Car Usage
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "car.fill")
                                .font(.title2)
                                .foregroundColor(.red)
                            Toggle("Did you avoid using a car today?", isOn: $avoid_Using_Car_Today)
                                .font(.headline)
                        }
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                    if avoid_Using_Car_Today {
                        VStack(alignment: .leading) {
                            Text("Which mode of transport did you use?")
                                .font(.headline)
                            Picker("Transport Mode", selection: $transport_Mode_Used) {
                                ForEach(transportOptions, id: \.self) { option in
                                    Image(systemName: option)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)

                        // Cycling Inputs
                        if transport_Mode_Used == "Cycle" {
                            VStack(alignment: .leading) {
                                Text("Time Cycled (minutes): \(cycleTime)").font(.headline)
                                Stepper(value: $cycleTime, in: 0...180, step: 5) {
                                    Text("\(cycleTime) min")
                                }.padding(.bottom, 10)

                                Text("Distance Cycled (miles): \(String(format: "%.1f", cycleDistance))")
                                    .font(.headline)

                                Slider(value: $cycleDistance, in: 0...50, step: 0.5)
                                    .accentColor(.green)
                            }
                            .padding()
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(10)
                            .padding(.horizontal)
                        }
                        
                        // Walking Inputs
                        if transport_Mode_Used == "Walking" {
                            VStack(alignment: .leading) {
                                Text("Time Walked (minutes): \(walkTime)").font(.headline)
                                Stepper(value: $walkTime, in: 0...180, step: 5) {
                                    Text("\(walkTime) min")
                                }.padding(.bottom, 10)

                                Text("Steps Walked: \(stepsTaken)").font(.headline)

                                Stepper(value: $stepsTaken, in: 0...30000, step: 1000) {
                                    Text("\(stepsTaken) steps")
                                }
                            }
                            .padding()
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(10)
                            .padding(.horizontal)
                        }
                    }
                
                    // MARK:- Avoid Single-Use Plastic Toggle
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "xmark.circle.fill").font(.title2).foregroundColor(.red)
                            Toggle("Did you avoid single-use plastics today?", isOn: $avoided_Single_Used_Plastic).font(.headline)
                        }
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                
                    // Bottles Recycled Stepper
                    CustomStepperView(
                        icon: "arrow.3.trianglepath",
                        iconColor: .blue,
                        title: "Bottles Recycled Today",
                        value: $bottles_Recycled,
                        range: 1...100,
                        step: 1
                    )
                    
                
                    // Reusable Product Used
                    CustomStepperView(
                        icon: "leaf.fill",
                        iconColor: .green,
                        title: "Reusable Items Used",
                        value: $reusable_Items,
                        range: 0...20,
                        step: 1
                    )
                    
                
                    // Smoking Stepper Controls
                    VStack(alignment: .leading) {
                        HStack {
                            Image("smoking").resizable().scaledToFit().frame(width: 25, height: 25)
                            Toggle("Do you smoke?", isOn: $isSmoker).font(.headline)
                        }
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                                        
                    if isSmoker {
                        CustomStepperView(
                            icon: "smoke.fill",
                            iconColor: .red,
                            title: "Cigarettes Smoked Today",
                            value: $cigarettesSmoked,
                            range: 0...40,
                            step: 1
                        )
                    }
                
                    
                    // Vegetarian or not
                    VStack(alignment: .leading) {
                        HStack {
                            Image("vegan").resizable().scaledToFit().frame(width: 25, height: 25)
                            Toggle("Are you vegan?", isOn: $isVegan).font(.headline)
                        }
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                    // Vegetarian Meals (Enabled only if Vegan)
                    if isVegan {
                        CustomStepperView(
                            icon: "leaf.fill",
                            iconColor: .green,
                            title: "Vegetarian Meals Eaten",
                            value: $vegMeals,
                            range: 0...10,
                            step: 1
                        )
                    }
                
                    
                    // Devices Power Energies
                    CustomStepperView(
                        icon: "power",
                        iconColor: .orange,
                        title: "Unused Devices Turned Off",
                        value: $device_TurnedOff,
                        range: 0...100,
                        step: 1
                    )
                       
                    
                    // Shower Time with Icon
                    CustomStepperView(
                        icon: "shower.fill",
                        iconColor: .blue,
                        title: "Minutes Reduced in Shower",
                        value: $shower_Time_Reduced,
                        range: 0...10,
                        step: 1
                    )
                                        
                    // AC Usage with Icon
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "thermometer.sun.fill").font(.title2).foregroundColor(.orange)
                            Toggle("Did you reduce AC usage today?", isOn: $reducedACUsage).font(.headline)
                        }
                        
                        if reducedACUsage {
                            CustomStepperView(
                                icon: "thermometer.sun.fill",
                                iconColor: .orange,
                                title: "Hours of AC Usage Reduced",
                                value: $acHoursReduced,
                                range: 0...24,
                                step: 1
                            )
                        }
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    // Calculate Carbon Emission Reduction Button
                    Button(action: {
                        
                        calculateCarbonReduction()
                        historyViewModel.addHistoryItem(carbonReduction: carbonReduction)})
                        {
                            Text("Calculate Carbon Reduction").font(.headline).foregroundColor(.white).padding().frame(maxWidth: .infinity).background(Color.green).cornerRadius(12).shadow(radius: 5)
                        }
                        .disabled(!hasUserInput)
                        .padding(.horizontal)
                        .opacity(hasUserInput ? 1.0 : 0.7)
                    
                        Text("Your Total Carbon Reduction:").font(.headline).foregroundColor(.secondary).padding(.top)
                        
                        Text("\(String(format: "%.2f", carbonReduction)) kg CO₂").font(.title2).fontWeight(.bold).foregroundColor(.green).padding()
                        
                    Spacer()
                }
                    
            }
            .navigationTitle("Daily Habit Tracker")
            .navigationBarTitleDisplayMode(.large)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation {
                            showInfoModal = true
                        }})
                    {
                        Image(systemName: "info.circle").font(.title2).foregroundColor(.green)
                    }
                }
            }
            .navigationViewStyle(.stack)
            .sheet(isPresented: $showInfoModal) {
                InfoView()
            }
        }
    }

    // Function to calculate carbon reduction
    private func calculateCarbonReduction() {
        var reduction = 0.0

        // Add values for each habit
        if wakeUp_Early {
            reduction += 0.5
        }

        reduction += water_Intake * 0.2
        reduction += Double(steps_Walked_Today / 1000) * 0.1
    
        if avoid_Using_Car_Today {
            switch transport_Mode_Used {
                
            case "Public Transport":
                reduction += 2.0

            case "Electric Vehicle":
                reduction += 1.0

            case "Cycle":
                let cycleEmissionsSaved = (cycleDistance * 0.411)
                let timeFactor = Double(cycleTime) * 0.05
                reduction += max(cycleEmissionsSaved, timeFactor)
            
            case "Walking":
                let walkEmissionsSaved = Double(stepsTaken / 1000) * 0.1
                let timeFactor = Double(walkTime) * 0.06
                reduction += max(walkEmissionsSaved, timeFactor)

            default:
                break
            }
        }

        if avoided_Single_Used_Plastic {
            reduction += 1.5
        }

        reduction += Double(bottles_Recycled) * 0.05
        reduction += Double(reusable_Items) * 0.08
        
        if isSmoker {
            let reductionPerCigarette = 0.02
            let maxDailySmokes = 20
            let avoidedCigarettes = maxDailySmokes - cigarettesSmoked
            if avoidedCigarettes > 0 {
                reduction += Double(avoidedCigarettes) * reductionPerCigarette
            }
        }
    
        if isVegan {
            reduction += Double(vegMeals) * 2.0
        }
        reduction += Double(shower_Time_Reduced) * 0.09
        
        reduction += Double(device_TurnedOff) * 0.5
        if reducedACUsage {
            reduction += Double(acHoursReduced) * 0.8
        }
        
        carbonReduction = reduction
    }
}
