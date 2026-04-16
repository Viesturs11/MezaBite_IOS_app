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
    
    @State private var isLoading = false // 👈 JAUNS
    
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
                    
                    Group {
                        TextField("Vārds", text: $name)
                        TextField("Telefons", text: $phone)
                        TextField("E-pasts", text: $email)
                        TextField("Adrese", text: $address)
                    }
                    .textFieldStyle(.roundedBorder)
                    
                    Divider()
                    
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
                    
                    // ✅ UZLABOTA POGA
                    Button {
                        submitOrder()
                    } label: {
                        if isLoading {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                                .padding()
                        } else {
                            Text("Apstiprināt pasūtījumu")
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                    }
                    .background(isValid ? Color.green : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .disabled(!isValid || isLoading) // 👈 bloķē klikus
                }
                .padding()
            }
        }
        .navigationDestination(isPresented: $navigateToOrder) {
            OrderView(order: createdOrder)
        }
    }
    
    var isValid: Bool {
        !name.isEmpty &&
        !address.isEmpty &&
        email.contains("@") &&
        phone.filter { $0.isNumber }.count >= 8
    }
    
    func submitOrder() {
        
        guard !isLoading else { return } // 👈 anti double click
        isLoading = true
        
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
            isLoading = false
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: orderData)
        
        URLSession.shared.dataTask(with: request) { _, _, error in
            
            if let error = error {
                print("Error:", error)
                
                DispatchQueue.main.async {
                    isLoading = false // 👈 svarīgi
                }
                return
            }
            
            DispatchQueue.main.async {
                
                createdOrder = Order(
                    id: orderID,
                    items: itemsCopy,
                    total: totalCopy
                )
                
                UserDefaults.standard.set(orderID, forKey: "orderID")
                
                cartVM.items.removeAll()
                
                isLoading = false // 👈 atslēdz loading
                
                navigateToOrder = true
            }
            
        }.resume()
    }
}
