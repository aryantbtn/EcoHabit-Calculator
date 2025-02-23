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
    @State private var selectedItem: HistoryItem?
    @State private var showingDetail = false
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                LazyVStack(spacing: 20) {
                    
                    ForEach(groupedHistory().sorted(by: { $0.key > $1.key }), id: \.key) { (date, items) in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(formatDate(date)).font(.title2).fontWeight(.bold).foregroundStyle(LinearGradient(colors: [.green, .blue.opacity(0.7)], startPoint: .leading, endPoint: .trailing)
                                ).padding(.horizontal)
                            
                            ForEach(items) { item in
                                HistoryItemCard(item: item).onTapGesture {
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
                    Button(action: { withAnimation {
                            historyViewModel.deleteAllItems()
                    }}) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
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
    
    
} //End of the History Screen Structure




struct HistoryItemCard: View {
    let item: HistoryItem
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "leaf.circle.fill").font(.title2).foregroundColor(.green)
                
                Text("\(String(format: "%.2f", item.carbonReduction)) kg CO₂").font(.headline).foregroundColor(.primary)
                
                
                Spacer()
                
                Text(timeFormat(item.date))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            ProgressBar(progressValue: min(item.carbonReduction / 10.0, 1.0))
                .frame(height: 6)
            
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(LinearGradient(colors: [.white, Color.green.opacity(0.1)],startPoint: .topLeading,endPoint: .bottomTrailing)).shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)).padding(.horizontal)
    } //Close the var body of HistryItmCard
    
    private func timeFormat(_ date: Date) -> String {
        let timerStyle = DateFormatter()
        timerStyle.timeStyle = .short
        return timerStyle.string(from: date)
    }
}

struct ProgressBar: View {
    var progressValue: Double
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().fill(Color.gray.opacity(0.3)).cornerRadius(5)
                
                Rectangle().fill(LinearGradient(colors: [.green, .blue.opacity(0.7)],startPoint: .leading,endPoint: .trailing)).frame(width: geometry.size.width * progressValue).cornerRadius(5)
            }
        }
    }
}
