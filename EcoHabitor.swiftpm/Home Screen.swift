//
//  File.swift
//  EcoHabitor
//
//  Created by ARYAN SINGHAL on 10/02/25.
//

import SwiftUI


struct MainTabView: View {
    @StateObject private var historyViewModel = HistoryViewModel()
    var body: some View {
        TabView {
            HomeScreen(historyViewModel: historyViewModel).tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            InfoView()
                .tabItem {
                    Label("Info", systemImage: "info.circle.fill")
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
    @State private var wakeUpEarly: Bool = false
    @State private var waterIntake: Double = 0.0
    @State private var stepsWalkedToday: Int = 0
    
    @State private var avoidedCar: Bool = false
    @State private var transportMode: String = "Public Transport"
    let transportOptions = [
        "bus.fill",       // Public Transport
        "bolt.car",  // Electric Vehicle
        "bicycle",        // Cycle
        "figure.walk"     // Walking
    ]
    @State private var publicTransport: Bool = false
    @State private var cycleTime: Int = 0
    @State private var cycleDistance: Double = 0.0
    @State private var walkTime: Int = 0
    @State private var stepsTaken: Int = 0
    
    @State private var singleUsePlasticAvoided: Bool = false
    @State private var bottlesRecycled: Int = 0
    @State private var reusableItems: Int = 0
    
    @State private var isSmoker: Bool = false
    @State private var cigarettesSmoked: Int = 0
    
    @State private var isVegan: Bool = false
    @State private var vegMeals: Int = 0
    @State private var nonVegMeals: Int = 0
    @State private var showerTimeReduced: Int = 0
    @State private var electricitySaved: Double = 0.0
    
    @State private var devicesTurnedOff: Int = 0
    @State private var reducedACUsage: Bool = false
    @State private var acHoursReduced: Int = 0 // Hours AC was reduced
    

    // State variable for carbon reduction result
    @State private var carbonReduction: Double = 0.0

    @State private var showInfoModal: Bool = false
    
    @State private var isInfoPresented = false
    
    var body: some View {
        ZStack{
            ScrollView {
                VStack(spacing: 30) {
                    Text("Daily Habit Tracker")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                    
                    Text("Enter your daily habits to calculate your carbon emission reductions.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    // MARK:- Wake Up Early Toggle
                    Toggle("Did you wake up early today?", isOn: $wakeUpEarly)
                        .padding()
                        .font(.headline)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    // MARK:- Water Intake Slider
                    VStack(alignment: .leading) {
                        Text("Water Intake (liters): \(String(format: "%.1f", waterIntake)) L")
                            .font(.headline)
                        
                        Slider(value: $waterIntake, in: 0...5, step: 0.1)
                            .accentColor(.green)
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        Text("Steps Walked: \(stepsWalkedToday)")
                            .font(.headline)
                        
                        Stepper(value: $stepsWalkedToday, in: 0...30000, step: 1000) {
                            Text("Steps: \(stepsWalkedToday)")
                        }
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    // Avoid Car Usage
                    Toggle("Did you avoid using a car today?", isOn: $avoidedCar)
                        .font(.headline)
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    if avoidedCar {
                        VStack(alignment: .leading) {
                            Text("Which mode of transport did you use?")
                                .font(.headline)
                            
                            Picker("Mode of Transport", selection: $transportMode) {
                                ForEach(transportOptions, id: \.self) { option in
                                    Image(systemName: option)
                                        .tag(option)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            
                        }
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        
                        // Cycling Inputs
                        if transportMode == "Cycle" {
                            VStack(alignment: .leading) {
                                Text("Time Cycled (minutes): \(cycleTime)")
                                    .font(.headline)
                                
                                Stepper(value: $cycleTime, in: 0...180, step: 5) {
                                    Text("\(cycleTime) min")
                                }
                                .padding(.bottom, 10)
                                
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
                        if transportMode == "Walking" {
                            VStack(alignment: .leading) {
                                Text("Time Walked (minutes): \(walkTime)")
                                    .font(.headline)
                                
                                Stepper(value: $walkTime, in: 0...180, step: 5) {
                                    Text("\(walkTime) min")
                                }
                                .padding(.bottom, 10)
                                
                                Text("Steps Walked: \(stepsTaken)")
                                    .font(.headline)
                                
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
                    Toggle("Did you avoid single-use plastics today?", isOn: $singleUsePlasticAvoided)
                        .padding()
                        .font(.headline)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    // MARK:- If applicable how many bottles recycled today
                    VStack(alignment: .leading) {
                        Text("Bottles Recycled Today: \(bottlesRecycled)")
                            .font(.headline)
                        
                        Stepper("", value: $bottlesRecycled, in: 0...100)
                        
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    // Reusable Product Used
                    VStack(alignment: .leading) {
                        Text("Reusable Items Used: \(reusableItems)")
                            .font(.headline)
                        
                        Stepper(value: $reusableItems, in: 0...10, step: 1) {
                            Text("\(reusableItems) items")
                        }
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    // Smoking Question
                    VStack(alignment: .leading) {
                        Text("Do you smoke?")
                            .font(.headline)
                        
                        Picker("Do you smoke?", selection: $isSmoker) {
                            Text("No").tag(false)
                            Text("Yes").tag(true)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        if isSmoker {
                            VStack(alignment: .leading) {
                                Text("How many cigarettes did you smoke today? \(cigarettesSmoked)")
                                    .font(.headline)
                                
                                Stepper(value: $cigarettesSmoked, in: 0...40, step: 1) {
                                    Text("\(cigarettesSmoked) cigarettes")
                                }
                            }
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    // Vegan Toggle
                    Toggle("Are you vegan?", isOn: $isVegan)
                    
                    // Vegetarian Meals (Enabled only if Vegan)
                    if isVegan {
                        VStack(alignment: .leading) {
                            Text("Vegetarian Meals Eaten: \(vegMeals)")
                                .font(.headline)
                            
                            Stepper(value: $vegMeals, in: 0...10, step: 1) {
                                Text("\(vegMeals) meals")
                            }
                        }
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }
                    
                    // Devices Power Energies
                    VStack(alignment: .leading) {
                        Text("Unused Devices Turned Off: \(devicesTurnedOff)")
                            .font(.headline)
                        
                        Stepper(value: $devicesTurnedOff, in: 0...20, step: 1) {
                            Text("\(devicesTurnedOff) devices")
                        }
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    // Reduction of Shower Bath Time
                    VStack(alignment: .leading) {
                        Text("Minutes Reduced in Shower: \(showerTimeReduced)")
                            .font(.headline)
                        
                        Stepper(value: $showerTimeReduced, in: 0...10, step: 1) {
                            Text("\(showerTimeReduced) min")
                        }
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        Toggle("Did you reduce AC usage today?", isOn: $reducedACUsage)
                            .padding()
                            .font(.headline)
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(10)
                        if reducedACUsage {
                            VStack(alignment: .leading) {
                                Text("Hours of AC Usage Reduced: \(acHoursReduced)")
                                    .font(.headline)
                                
                                Stepper(value: $acHoursReduced, in: 0...24, step: 1) {
                                    Text("Hours Reduced: \(acHoursReduced)")
                                }
                            }
                            .padding()
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Calculate Button
                    Button(action: {
                        calculateCarbonReduction()
                        historyViewModel.addHistoryItem(carbonReduction: carbonReduction)
                    }) {
                        Text("Calculate Carbon Reduction")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal)
                    //                    .disabled(isInputValid)
                    
                    // Result Display
                    Text("Your Total Carbon Reduction:")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .padding(.top)
                    
                    Text("\(String(format: "%.2f", carbonReduction)) kg CO₂")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                        .padding()
                    
                    Spacer()
                }
                .padding(.vertical)
                .navigationBarTitle("EcoHabit Calculator", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    showInfoModal = true
                }) {
                    Image(systemName: "info.circle")
                        .font(.title2)
                        .foregroundColor(.green)
                })
                .sheet(isPresented: $showInfoModal) {
                    InfoView()
                }
                
                .navigationTitle("Home Screen")
            }
        }
        .navigationBarHidden(true)
    }

    // Function to calculate carbon reduction
    private func calculateCarbonReduction() {
        var reduction = 0.0

        // Add values for each habit
        if wakeUpEarly {
            reduction += 0.5 // Example: Waking up early saves 0.5 kg CO₂
        }

        reduction += waterIntake * 0.2 // 1L of water saved = 0.2 kg CO₂ reduction
        reduction += Double(stepsWalkedToday / 1000) * 0.1 // 1000 steps walked = 0.1 kg CO₂ saved
        
        if avoidedCar {
            switch transportMode {
            case "Public Transport":
                reduction += 2.0 // 🚆 Public transport saves ~2.0 kg CO₂ vs. driving

            case "Electric Vehicle":
                reduction += 1.0 // ⚡ EVs reduce emissions but still have battery-related CO₂

            case "Cycle":
                let cycleEmissionsSaved = (cycleDistance * 0.411) // 🚴 1 mile cycling = 411g CO₂ saved
                let timeFactor = Double(cycleTime) * 0.05 // 🚴 Cycling 10 min saves 0.5 kg CO₂
                reduction += max(cycleEmissionsSaved, timeFactor) // Take max of time or distance-based calc
                
            case "Walking":
                let walkEmissionsSaved = Double(stepsTaken / 1000) * 0.1 // 🚶 1000 steps = 0.1 kg CO₂ saved
                let timeFactor = Double(walkTime) * 0.06 // 🚶 Walking 10 min saves 0.6 kg CO₂
                reduction += max(walkEmissionsSaved, timeFactor) // Take max of time or step-based calc

            default:
                break
            }
        }
        
        if publicTransport {
            reduction += 2.0 // Example: Using public transport saves 2.0 kg CO₂
        }

        if singleUsePlasticAvoided {
            reduction += 1.5 // Example: Avoiding single-use plastics saves 1.5 kg CO₂
        }

        reduction += electricitySaved * 0.7 // Example: Every kWh saved = 0.7 kg CO₂

        reduction += Double(bottlesRecycled) * 0.05
        
        if reducedACUsage {
            reduction += Double(acHoursReduced) * 0.8 // Example: Each hour of AC reduction saves 0.8 kg CO₂
        }
        
        if wakeUpEarly {
            reduction += 0.5 // Example: Waking up early saves 0.5 kg CO₂ by reducing electricity use
        }

               
        if publicTransport {
            reduction += 2.0 // Using public transport saves 2.0 kg CO₂ vs. driving
        }

        if singleUsePlasticAvoided {
            reduction += 1.5 // Avoiding single-use plastics saves 1.5 kg CO₂
        }

        reduction += Double(bottlesRecycled) * 0.05 // 1 bottle recycled = 0.05 kg CO₂ saved
                
        if reducedACUsage {
            reduction += Double(acHoursReduced) * 0.8 // 1 hour of AC reduction saves 0.8 kg CO₂
        }
        
        // Smoking Impact Calculation
        if isSmoker {
            let reductionPerCigarette = 0.02 // Example: Each cigarette avoided saves 0.02 kg CO₂
            let maxDailySmokes = 20 // Assume max smoking habit is 20 cigarettes per day
            let avoidedCigarettes = maxDailySmokes - cigarettesSmoked
            if avoidedCigarettes > 0 {
                reduction += Double(avoidedCigarettes) * reductionPerCigarette
            }
        }
        
        if isVegan {
            reduction += Double(vegMeals) * 2.0 // 1 vegetarian meal instead of meat = 2 kg CO₂ saved
        }
        // Update the state to reflect the calculated result
        carbonReduction = reduction
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
