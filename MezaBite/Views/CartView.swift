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
            VStack(spacing: 0) {
                
                if cartVM.items.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "cart")
                            .font(.system(size: 50))
                            .foregroundColor(Color("TextSecondary"))
                        
                        Text("Grozs ir tukšs")
                            .font(.title3)
                            .bold()
                            .foregroundColor(Color("TextPrimary"))
                        
                        Text("Pievienojiet produktus, lai noformētu pasūtījumu.")
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("TextSecondary"))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                } else {
                    List {
                        ForEach(Array(cartVM.items.enumerated()), id: \.element.id) { index, item in
                            HStack(spacing: 12) {
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.product.name)
                                        .font(.headline)
                                        .foregroundColor(Color("TextPrimary"))
                                    
                                    Text("€\(item.product.price, specifier: "%.2f")")
                                        .foregroundColor(Color("TextSecondary"))
                                }
                                
                                Spacer()
                                
                                HStack(spacing: 12) {
                                    
                                    Button(action: {
                                        cartVM.decreaseQuantity(at: index)
                                    }) {
                                        Image(systemName: "minus")
                                            .font(.system(size: 14, weight: .bold))
                                            .frame(width: 32, height: 32)
                                            .background(Color("CardColor"))
                                            .foregroundColor(Color("TextPrimary"))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color("TextSecondary").opacity(0.2), lineWidth: 1)
                                            )
                                            .cornerRadius(8)
                                    }
                                    .buttonStyle(.borderless)
                                    
                                    Text("\(item.quantity)")
                                        .font(.headline)
                                        .foregroundColor(Color("TextPrimary"))
                                        .frame(minWidth: 30)
                                    
                                    Button(action: {
                                        cartVM.increaseQuantity(at: index)
                                    }) {
                                        Image(systemName: "plus")
                                            .font(.system(size: 14, weight: .bold))
                                            .frame(width: 32, height: 32)
                                            .background(Color("PrimaryColor"))
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                    }
                                    .buttonStyle(.borderless)
                                }
                            }
                            .padding(.vertical, 8)
                            .listRowBackground(Color("CardColor"))
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                cartVM.removeFromCart(at: index)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color("BackgroundColor"))
                    
                    VStack(spacing: 12) {
                        Divider()
                        
                        Text("Kopā: €\(cartVM.totalPrice, specifier: "%.2f")")
                            .font(.title2)
                            .bold()
                            .foregroundColor(Color("TextPrimary"))
                        
                        NavigationLink(destination: CheckoutView()) {
                            Text("Pasūtīt")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color("PrimaryColor"))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                    }
                    .padding()
                    .background(Color("BackgroundColor"))
                }
            }
            .background(Color("BackgroundColor").ignoresSafeArea())
            .navigationTitle("Grozs")
        }
    }
}
