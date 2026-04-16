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
    @Environment(\.dismiss) var dismiss
    @Environment(\.selectedTab) var selectedTab
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // ✅ HEADER
                VStack(spacing: 8) {
                    Text("Pasūtījums nosūtīts")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color("TextPrimary"))
                    
                    Text("Pavadzīme Nr. \(order?.id ?? 0)")
                        .foregroundColor(Color("TextSecondary"))
                }
                
                // 🏢 UZŅĒMUMA BLOKS
                VStack(alignment: .leading, spacing: 6) {
                    Text("SIA \"Meža Bite\"")
                        .font(.headline)
                        .foregroundColor(Color("TextPrimary"))
                    
                    Text("Adrese: Saules, Burtnieku pagasts")
                    Text("Valmiera novads, Latvija, LV-4206")
                    Text("Tālrunis: 26495921")
                    Text("Konts: LV47PARX001912508000")
                }
                .font(.subheadline)
                .foregroundColor(Color("TextSecondary"))
                .padding()
                .background(Color("CardColor"))
                .cornerRadius(16)
                
                // 🛒 PASŪTĪJUMA BLOKS
                VStack(alignment: .leading, spacing: 12) {
                    Text("Pasūtījuma saturs")
                        .font(.headline)
                        .foregroundColor(Color("TextPrimary"))
                    
                    ForEach(order?.items ?? []) { item in
                        HStack(alignment: .top) {
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.product.name)
                                    .foregroundColor(Color("TextPrimary"))
                                
                                Text("Daudzums: \(item.quantity)")
                                    .font(.subheadline)
                                    .foregroundColor(Color("TextSecondary"))
                            }
                            
                            Spacer()
                            
                            Text("€\(item.product.price * Double(item.quantity), specifier: "%.2f")")
                                .foregroundColor(Color("TextPrimary"))
                        }
                        
                        Divider()
                    }
                    
                    HStack {
                        Text("Kopā")
                            .font(.title3)
                            .bold()
                            .foregroundColor(Color("TextPrimary"))
                        
                        Spacer()
                        
                        Text("€\(order?.total ?? 0, specifier: "%.2f")")
                            .font(.title3)
                            .bold()
                            .foregroundColor(Color("PrimaryColor"))
                    }
                }
                .padding()
                .background(Color("CardColor"))
                .cornerRadius(16)
                
                // ✅ STATUS
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(Color("PrimaryColor"))
                    
                    Text("Pasūtījums veiksmīgi nosūtīts")
                        .foregroundColor(Color("TextPrimary"))
                }
                .padding(.top, 10)
                
                // 🔙 POGA
                Button("Atpakaļ uz sākumu") {
                    selectedTab?.wrappedValue = 0
                    dismiss()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color("PrimaryColor"))
                .foregroundColor(.white)
                .cornerRadius(14)
                
            }
            .padding()
        }
        .background(Color("BackgroundColor").ignoresSafeArea()) // 👈 svarīgi
        .navigationBarBackButtonHidden(true)
    }
}
