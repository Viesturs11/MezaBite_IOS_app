//
//  ProductsDetailView.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 14/04/2026.
//

import SwiftUI

struct ProductDetailView: View {
    
    let product: Product
    @StateObject private var cartVM = CartViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text(product.name)
                .font(.title)
            
            Text(product.description)
            
            Text("€\(product.price, specifier: "%.2f")")
            
            Button("Pievienot grozam") {
                cartVM.addToCart(product)
            }
        }
        .padding()
    }
}
