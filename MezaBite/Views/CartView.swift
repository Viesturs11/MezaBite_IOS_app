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
                            
                            VStack(alignment: .leading) {
                                Text(item.product.name)
                                Text("€\(item.product.price, specifier: "%.2f")")
                            }
                            
                            Spacer()
                            
                            HStack(spacing: 10) {
                                
                                Button(action: {
                                    cartVM.decreaseQuantity(at: index)
                                }) {
                                    Text("-")
                                }
                                .buttonStyle(.borderless)
                                
                                Text("\(item.quantity)")
                                    .frame(minWidth: 30)
                                
                                Button(action: {
                                    cartVM.increaseQuantity(at: index)
                                }) {
                                    Text("+")
                                }
                                .buttonStyle(.borderless)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            cartVM.removeFromCart(at: index)
                        }
                    }
                }
                
                // 💰 summa
                Text("Kopā: €\(cartVM.totalPrice, specifier: "%.2f")")
                    .font(.title2)
                    .bold()
                    .padding()
            }
            .navigationTitle("Grozs")
        }
    }
}
