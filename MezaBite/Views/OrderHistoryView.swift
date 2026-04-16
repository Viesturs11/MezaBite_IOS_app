//
//  OrderHistoryView.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 16/04/2026.
//

//
//  OrderHistoryView.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 16/04/2026.
//

import SwiftUI

struct OrderHistoryView: View {
    
    @State private var orders: [Order] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    ForEach(Array(orders.reversed())) { order in
                        OrderCardView(order: order)
                    }
                    
                    if orders.isEmpty {
                        Text("Nav pasūtījumu vēl")
                            .foregroundColor(Color("TextSecondary"))
                            .padding(.top, 50)
                    }
                }
                .padding()
            }
            .background(Color("BackgroundColor").ignoresSafeArea())
            .navigationTitle("Mani pasūtījumi")
        }
        .onAppear {
            loadOrders()
        }
    }
    
    func loadOrders() {
        guard let data = UserDefaults.standard.data(forKey: "savedOrders"),
              let decoded = try? JSONDecoder().decode([Order].self, from: data) else {
            return
        }
        
        orders = decoded
    }
}

struct OrderCardView: View {
    
    let order: Order
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            // 🧾 HEADER
            Text("Pavadzīme Nr. \(order.id)")
                .font(.headline)
                .foregroundColor(Color("TextPrimary"))
            
            // 👤 KLIENTS
            VStack(alignment: .leading, spacing: 4) {
                Text("Klients: \(order.name)")
                Text("Telefons: \(order.phone)")
                Text("Adrese: \(order.address)")
            }
            .font(.subheadline)
            .foregroundColor(Color("TextSecondary"))
            
            Divider()
            
            // 🛒 PRODUKTI
            ForEach(order.items) { item in
                HStack {
                    Text(item.product.name)
                    
                    Spacer()
                    
                    Text("x\(item.quantity)")
                    
                    Text("€\(item.product.price * Double(item.quantity), specifier: "%.2f")")
                }
                .foregroundColor(Color("TextPrimary"))
            }
            
            Divider()
            
            // 💰 SUMMA
            HStack {
                Text("Kopā:")
                    .bold()
                
                Spacer()
                
                Text("€\(order.total, specifier: "%.2f")")
                    .bold()
                    .foregroundColor(Color("PrimaryColor"))
            }
            
            Divider()
            
            // 💳 MAKSĀJUMS
            VStack(alignment: .leading, spacing: 4) {
                Text("Maksājuma rekvizīti:")
                    .bold()
                
                Text("SIA Meža Bite")
                Text("Konts: LV47PARX001912508000")
                Text("Mērķis: Pavadzīme Nr.: \(order.id)")
            }
            .font(.footnote)
            .foregroundColor(Color("TextSecondary"))
            
        }
        .padding()
        .background(Color("CardColor"))
        .cornerRadius(16)
    }
}


