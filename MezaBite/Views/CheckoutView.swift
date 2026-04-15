//
//  CheckoutView.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 15/04/2026.
//

import SwiftUI

struct CheckoutView: View {
    
    @EnvironmentObject var cartVM: CartViewModel
    
    @State private var name = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var address = ""
    
    @State private var createdOrder: Order?
    @State private var navigateToOrder = false
    
    var orderID: Int {
        UserDefaults.standard.integer(forKey: "orderID") + 1
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    Text("Pasūtījuma noformēšana")
                        .font(.title)
                        .bold()
                    
                    // 👤 klienta dati
                    Group {
                        TextField("Vārds", text: $name)
                        TextField("Telefons", text: $phone)
                        TextField("E-pasts", text: $email)
                        TextField("Adrese", text: $address)
                    }
                    .textFieldStyle(.roundedBorder)
                    
                    Divider()
                    
                    // 🛒 grozs
                    Text("Pasūtījums")
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
                        .bold()
                    
                    // ✅ POGA
                    Button("Apstiprināt pasūtījumu") {
                        submitOrder()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isValid ? Color.green : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .disabled(!isValid)
                }
                .padding()
                
                // 👉 automātiska pāreja uz OrderView
                NavigationLink(
                    destination: OrderView(order: createdOrder),
                    isActive: $navigateToOrder
                ) {
                    EmptyView()
                }
            }
        }
    }
    
    // ✅ validācija
    var isValid: Bool {
        !name.isEmpty && !phone.isEmpty && !address.isEmpty
    }
    
    // 🚀 submit
    func submitOrder() {
        
        // 🧾 saglabā kopiju PIRMS dzēšanas
        let itemsCopy = cartVM.items
        let totalCopy = cartVM.totalPrice
        
        let itemsText = itemsCopy.map {
            "\($0.product.name) x\($0.quantity)"
        }.joined(separator: ", ")
        
        let orderData: [String: Any] = [
            "id": orderID,
            "name": name,
            "phone": phone,
            "email": email,
            "address": address,
            "items": itemsText,
            "total": totalCopy
        ]
        
        guard let url = URL(string: "https://script.google.com/macros/s/AKfycbzGP4YbBhHVgecTOlLjpnJV7VZCGQAOukfBTmXnJrmLIEURsV5ZKmGdNlEBXYUk-d7MJQ/exec") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: orderData)
        
        URLSession.shared.dataTask(with: request) { _, _, error in
            
            if let error = error {
                print("Error:", error)
                return
            }
            
            DispatchQueue.main.async {
                
                // 🧾 izveido order snapshot
                createdOrder = Order(
                    id: orderID,
                    items: itemsCopy,
                    total: totalCopy
                )
                
                // 💾 saglabā ID
                UserDefaults.standard.set(orderID, forKey: "orderID")
                
                // 🧹 iztīra grozu
                cartVM.items.removeAll()
                
                // 👉 pāriet uz OrderView
                navigateToOrder = true
            }
            
        }.resume()
    }
}
