//
//  ProductsDetailView.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 14/04/2026.
//



import SwiftUI

struct ProductDetailView: View {
    
    let product: Product
    @EnvironmentObject var cartVM: CartViewModel
    @State private var showAlert = false
    @State private var quantity = 1
    
    var body: some View {
        VStack(spacing: 20) {
            
            Image(product.image)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            
            Text(product.name)
                .font(.largeTitle)
            
            Text(product.description)
            
            Text("€\(product.price, specifier: "%.2f")")
                .foregroundColor(.green)
            
            // ➕➖ izvēle
            HStack {
                Button("-") {
                    if quantity > 1 { quantity -= 1 }
                }
                
                Text("\(quantity)")
                
                Button("+") {
                    quantity += 1
                }
            }
            .font(.title2)
            
            Button("Pievienot grozam") {
                for _ in 0..<quantity {
                    cartVM.addToCart(product)
                }
                showAlert = true
            }
            .buttonStyle(.borderedProminent)
            .alert("Pievienots grozam ✅", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            }
            Spacer()
        }
        .padding()
    }
}
