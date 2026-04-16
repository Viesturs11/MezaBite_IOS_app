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
        ScrollView {
            VStack(spacing: 20) {
                
                // 🖼️ ATTĒLS
                Image(product.image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 220)
                    .padding()
                    .background(Color("CardColor"))
                    .cornerRadius(16)
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(product.name)
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color("TextPrimary"))
                    
                    Text(product.description)
                        .foregroundColor(Color("TextSecondary"))
                    
                    Text("€\(product.price, specifier: "%.2f")")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color("PrimaryColor"))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // ➕➖ QUANTITY BLOKS
                HStack {
                    
                    Text("Daudzums")
                        .foregroundColor(Color("TextPrimary"))
                    
                    Spacer()
                    
                    HStack(spacing: 16) {
                        
                        Button {
                            if quantity > 1 { quantity -= 1 }
                        } label: {
                            Image(systemName: "minus")
                                .frame(width: 36, height: 36)
                                .background(Color("CardColor"))
                                .foregroundColor(Color("TextPrimary"))
                                .cornerRadius(8)
                        }
                        
                        Text("\(quantity)")
                            .font(.headline)
                            .frame(minWidth: 30)
                            .foregroundColor(Color("TextPrimary"))
                        
                        Button {
                            quantity += 1
                        } label: {
                            Image(systemName: "plus")
                                .frame(width: 36, height: 36)
                                .background(Color("PrimaryColor"))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding()
                .background(Color("CardColor"))
                .cornerRadius(16)
                
                // 🛒 POGA
                Button {
                    for _ in 0..<quantity {
                        cartVM.addToCart(product)
                    }
                    showAlert = true
                } label: {
                    Text("Pievienot grozam")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("PrimaryColor"))
                        .foregroundColor(.white)
                        .cornerRadius(14)
                }
                
                .alert("Pievienots grozam ✅", isPresented: $showAlert) {
                    Button("OK", role: .cancel) {}
                }
            }
            .padding()
        }
        .background(Color("BackgroundColor").ignoresSafeArea()) // 👈 svarīgi
        .navigationTitle("Produkts")
        .navigationBarTitleDisplayMode(.inline)
    }
}
