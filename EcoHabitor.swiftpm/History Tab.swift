//
//  File.swift
//  EcoHabitor
//
//  Created by ARYAN SINGHAL on 12/02/25.
//

import Foundation
import SwiftUICore
import SwiftUI

/*
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
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        historyViewModel.deleteAllItems()
                    }) {
                        Image(systemName: "trash")
                    }
                }
            }
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
*/


struct HistoryScreen: View {
    @ObservedObject var historyViewModel: HistoryViewModel
    @State private var showingDeleteAlert = false
    @State private var selectedItem: HistoryItem?
    @State private var showingDetail = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(groupedHistory().sorted(by: { $0.key > $1.key }), id: \.key) { (date, items) in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(formatDate(date))
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [.green, .blue.opacity(0.7)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .padding(.horizontal)
                            
                            ForEach(items) { item in
                                HistoryItemCard(item: item)
                                    .onTapGesture {
                                        withAnimation {
                                            selectedItem = item
                                            showingDetail = true
                                        }
                                    }
                            }
                            .transition(.scale.combined(with: .opacity))
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("History")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                        .foregroundColor(.green)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation {
                            historyViewModel.deleteAllItems()
                        }
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
            }
            .alert("Delete History", isPresented: $showingDeleteAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Delete", role: .destructive) {
                    withAnimation {
                        historyViewModel.deleteAllItems()
                    }
                }
            } message: {
                Text("Are you sure you want to delete the entire history? This action cannot be undone.")
            }
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
    // Your existing helper functions remain the same
}

// Add new HistoryItemCard view
struct HistoryItemCard: View {
    let item: HistoryItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "leaf.circle.fill")
                    .font(.title2)
                    .foregroundColor(.green)
                
                Text("\(String(format: "%.2f", item.carbonReduction)) kg CO₂")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Text(formatTime(item.date))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            ProgressBar(value: min(item.carbonReduction / 10.0, 1.0))
                .frame(height: 6)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(
                    LinearGradient(
                        colors: [.white, Color.green.opacity(0.1)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
        )
        .padding(.horizontal)
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct ProgressBar: View {
    var value: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .cornerRadius(5)
                
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [.green, .blue.opacity(0.7)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: geometry.size.width * value)
                    .cornerRadius(5)
            }
        }
    }
}
