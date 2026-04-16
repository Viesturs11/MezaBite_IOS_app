//
//  ProductCardView.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 14/04/2026.
//

import SwiftUI

struct ProductCardView: View {
    
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Image(product.image)
                .resizable()
                .scaledToFill()
                .frame(height: 120)
                .clipped()
                .cornerRadius(12)
            
            Text(product.name)
                .font(.headline)
                .foregroundColor(Color("TextPrimary"))
                .lineLimit(2)
            
            Text("€\(product.price, specifier: "%.2f")")
                .font(.subheadline)
                .foregroundColor(Color("PrimaryColor"))
        }
        .padding()
        .background(Color("CardColor")) // 👈 tava krāsa
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 6)
    }
}
