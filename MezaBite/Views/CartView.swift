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
                    ForEach(cartVM.items) { item in
                        HStack {
                            
                            VStack(alignment: .leading) {
                                Text(item.product.name)
                                Text("€\(item.product.price, specifier: "%.2f")")
                            }
                            
                            Spacer()
                            
                            HStack(spacing: 10) {
                                Button("-") {
                                    cartVM.decreaseQuantity(item)
                                }
                                
                                Text("\(item.quantity)")
                                    .frame(minWidth: 30)
                                
                                Button("+") {
                                    cartVM.increaseQuantity(item)
                                }
                            }
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            cartVM.removeFromCart(cartVM.items[index])
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
