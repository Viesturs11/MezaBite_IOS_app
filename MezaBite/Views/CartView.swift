//
//  CartView.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 14/04/2026.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var cartVM: CartViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                
                List {
                    ForEach(Array(cartVM.items.enumerated()), id: \.element.id) { index, item in
                        
                        HStack {
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.product.name)
                                    .font(.headline)
                                
                                Text("€\(item.product.price, specifier: "%.2f")")
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            // ➕➖ pogas (UZLABOTAS)
                            HStack(spacing: 12) {
                                
                                Button(action: {
                                    cartVM.decreaseQuantity(at: index)
                                }) {
                                    Image(systemName: "minus")
                                        .frame(width: 32, height: 32)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(8)
                                }
                                .buttonStyle(.borderless)
                                
                                Text("\(item.quantity)")
                                    .font(.headline)
                                    .frame(minWidth: 30)
                                
                                Button(action: {
                                    cartVM.increaseQuantity(at: index)
                                }) {
                                    Image(systemName: "plus")
                                        .frame(width: 32, height: 32)
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .buttonStyle(.borderless)
                            }
                        }
                        .padding(.vertical, 6)
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            cartVM.removeFromCart(at: index)
                        }
                    }
                }
                
                // 💰 summa
                VStack(spacing: 10) {
                    Text("Kopā: €\(cartVM.totalPrice, specifier: "%.2f")")
                        .font(.title2)
                        .bold()
                    
                    // 🛒 POGA
                    NavigationLink(destination: CheckoutView()) {
                        Text("Pasūtīt")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding()
            }
            .navigationTitle("Grozs")
        }
    }
}
