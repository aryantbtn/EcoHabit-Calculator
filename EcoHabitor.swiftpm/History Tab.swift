//
//  File.swift
//  EcoHabitor
//
//  Created by ARYAN SINGHAL on 12/02/25.
//

import Foundation
import SwiftUICore
import SwiftUI

struct HistoryScreen: View {
    @ObservedObject var historyViewModel: HistoryViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(groupedHistory().sorted(by: { $0.key > $1.key }), id: \.key) { (date, items) in // <-- Fix here
                    Section(header: Text(formatDate(date))) {
                        ForEach(items) { item in
                            VStack(alignment: .leading) {
                                Text("Carbon Reduction: \(String(format: "%.2f", item.carbonReduction)) kg CO₂")
                                .font(.headline)
                                Text("Time: \(formatTime(item.date))")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("History")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func groupedHistory() -> [Date: [HistoryItem]] {
        Dictionary(grouping: historyViewModel.historyItems) { item in
            Calendar.current.startOfDay(for: item.date)
        }
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }

    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}


