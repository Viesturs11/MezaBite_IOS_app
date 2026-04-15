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
                .font(.title)
                .bold()
            
            Text(product.description)
                .foregroundColor(.gray)
            
            Text("€\(product.price, specifier: "%.2f")")
                .font(.title2)
                .foregroundColor(.green)
            
            // ➕➖ izvēle (UZLABOTS)
            HStack(spacing: 20) {
                
                Button(action: {
                    if quantity > 1 { quantity -= 1 }
                }) {
                    Image(systemName: "minus")
                        .font(.title2)
                        .frame(width: 44, height: 44)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
                
                Text("\(quantity)")
                    .font(.title2)
                    .frame(minWidth: 40)
                
                Button(action: {
                    quantity += 1
                }) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .frame(width: 44, height: 44)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            
            // 🛒 POGA (uzlabota)
            Button(action: {
                for _ in 0..<quantity {
                    cartVM.addToCart(product)
                }
                showAlert = true
            }) {
                Text("Pievienot grozam")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            
            .alert("Pievienots grozam ✅", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            }
            
            Spacer()
        }
        .padding()
    }
}
