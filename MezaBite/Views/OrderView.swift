//
//  OrderView.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 14/04/2026.
//

//
//  CartView.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 14/04/2026.

import SwiftUI

struct OrderView: View {
    
    let order: Order?
    @Environment(\.dismiss) var dismiss   // ✅ PIEVIENOTS
    @Environment(\.selectedTab) var selectedTab
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // 🧾 ID
                Text("Pavadzīme Nr.:\(order?.id ?? 0)")
                    .font(.title)
                    .bold()
                
                // 🏢 Uzņēmuma dati
                VStack(alignment: .leading, spacing: 5) {
                    Text("SIA \"Meža Bite\"")
                    Text("Adrese: Saules, Burtnieku pagasts")
                    Text("Valmiera novads, Latvija, LV-4206")
                    Text("Tālrunis: 26495921")
                    Text("Konts: LV47PARX001912508000")
                }
                .font(.subheadline)
                
                Divider()
                
                // 🛒 Pasūtījuma saturs
                Text("Pasūtījuma saturs")
                    .font(.headline)
                
                ForEach(order?.items ?? []) { item in
                    HStack {
                        Text(item.product.name)
                        Spacer()
                        Text("\(item.quantity)x")
                        Text("€\(item.product.price * Double(item.quantity), specifier: "%.2f")")
                    }
                }
                
                Divider()
                
                // 💰 summa
                Text("Kopā: €\(order?.total ?? 0, specifier: "%.2f")")
                    .font(.title2)
                    .bold()
                
                // ✅ status
                Text("Pasūtījums veiksmīgi nosūtīts ✅")
                    .foregroundColor(.green)
                    .padding(.top)
                
                // 🔙 ATGRIEZTIES (LABOTS)
                Button("Atpakaļ uz sākumu") {
                    selectedTab?.wrappedValue = 0 // 👈 pāriet uz Home
                    dismiss()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(12)
                
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}
