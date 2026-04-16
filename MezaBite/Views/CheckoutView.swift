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
    @State private var isLoading = false
    
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
                        .foregroundColor(Color("TextPrimary"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 12) {
                        TextField("Vārds", text: $name)
                            .textInputAutocapitalization(.words)
                        
                        TextField("Telefons", text: $phone)
                            .keyboardType(.phonePad)
                        
                        TextField("E-pasts", text: $email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                        
                        TextField("Adrese", text: $address)
                            .textInputAutocapitalization(.words)
                    }
                    .padding()
                    .background(Color("CardColor"))
                    .cornerRadius(16)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Pasūtījums")
                            .font(.headline)
                            .foregroundColor(Color("TextPrimary"))
                        
                        ForEach(cartVM.items) { item in
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
                            .padding(.vertical, 4)
                            
                            Divider()
                        }
                        
                        HStack {
                            Text("Kopā")
                                .font(.title3)
                                .bold()
                                .foregroundColor(Color("TextPrimary"))
                            
                            Spacer()
                            
                            Text("€\(cartVM.totalPrice, specifier: "%.2f")")
                                .font(.title3)
                                .bold()
                                .foregroundColor(Color("PrimaryColor"))
                        }
                    }
                    .padding()
                    .background(Color("CardColor"))
                    .cornerRadius(16)
                    
                    Button {
                        submitOrder()
                    } label: {
                        if isLoading {
                            ProgressView()
                                .tint(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                        } else {
                            Text("Apstiprināt pasūtījumu")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                    }
                    .background(isValid ? Color("PrimaryColor") : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(14)
                    .disabled(!isValid || isLoading)
                }
                .padding()
            }
            .background(Color("BackgroundColor").ignoresSafeArea())
            .navigationTitle("Checkout")
            .navigationBarTitleDisplayMode(.inline)
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
        
        guard !isLoading else { return }
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
                    isLoading = false
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
                isLoading = false
                navigateToOrder = true
            }
            
        }.resume()
    }
}
