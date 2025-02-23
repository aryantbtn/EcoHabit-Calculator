//
//  File.swift
//  EcoHabitor
//
//  Created by ARYAN SINGHAL on 12/02/25.
//


import Foundation
struct HistoryItem: Identifiable {
    let id = UUID()
    let date: Date
    let carbonReduction: Double
}

class HistoryViewModel: ObservableObject {
    
    @Published var historyItems: [HistoryItem] = []
    
    func addHistoryItem(carbonReduction: Double) {
        let newItem = HistoryItem(date: Date(), carbonReduction: carbonReduction)
        historyItems.append(newItem)
    }
    
    func deleteAllItems() {
        historyItems.removeAll()
    }
    
    
}
