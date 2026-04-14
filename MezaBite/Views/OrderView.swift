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
//

import SwiftUI

struct OrderView: View {
    
    @EnvironmentObject var cartVM: CartViewModel
    
    var orderID: Int {
        UserDefaults.standard.integer(forKey: "orderID") + 1
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Pasūtījums #\(orderID)")
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
                
                // 🛒 Groza saturs
                Text("Pasūtījuma saturs")
                    .font(.headline)
                
                ForEach(cartVM.items) { item in
                    HStack {
                        Text(item.product.name)
                        Spacer()
                        Text("\(item.quantity)x")
                        Text("€\(item.product.price * Double(item.quantity), specifier: "%.2f")")
                    }
                }
                
                Divider()
                
                Text("Kopā: €\(cartVM.totalPrice, specifier: "%.2f")")
                    .font(.title2)
                    .bold()
                
                // 📧 Nosūtīt email
                Button("Nosūtīt pasūtījumu") {
                    sendEmail()
                    saveOrderID()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
                
            }
            .padding()
        }
    }
    
    // 📧 email funkcija
    func sendEmail() {
        let subject = "Jauns pasūtījums #\(orderID)"
        
        var body = "Pasūtījums:\n\n"
        
        for item in cartVM.items {
            body += "\(item.product.name) - \(item.quantity)x\n"
        }
        
        body += "\nKopā: €\(cartVM.totalPrice)"
        
        let urlString = "mailto:info@mezabite.lv?subject=\(subject)&body=\(body)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    // 🧾 saglabā ID
    func saveOrderID() {
        UserDefaults.standard.set(orderID, forKey: "orderID")
    }
}
