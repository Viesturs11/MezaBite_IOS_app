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
    
    // 🔥 ANIMĀCIJAS
    @State private var animateButton = false
    @State private var floatImage = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // 🐝 ATTĒLS AR “FLOAT”
                Image(product.image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 220)
                    .padding()
                    .background(Color("CardColor"))
                    .cornerRadius(16)
                    .offset(y: floatImage ? -5 : 5)
                    .animation(.easeInOut(duration: 2).repeatForever(), value: floatImage)
                    .onAppear {
                        floatImage = true
                    }
                
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
                
                // ➕➖ QUANTITY
                HStack {
                    
                    Text("Daudzums")
                        .foregroundColor(Color("TextPrimary"))
                    
                    Spacer()
                    
                    HStack(spacing: 16) {
                        
                        Button {
                            if quantity > 1 {
                                withAnimation {
                                    quantity -= 1
                                }
                            }
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
                            withAnimation {
                                quantity += 1
                            }
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
                
                // 🛒 POGA AR ANIMĀCIJU
                Button {
                    
                    // 🔥 bounce efekts
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                        animateButton = true
                    }
                    
                    for _ in 0..<quantity {
                        cartVM.addToCart(product)
                    }
                    
                    showAlert = true
                    
                    // reset animāciju
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        animateButton = false
                    }
                    
                } label: {
                    Text("Pievienot grozam")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("PrimaryColor"))
                        .foregroundColor(.white)
                        .cornerRadius(14)
                }
                .scaleEffect(animateButton ? 0.9 : 1.0) // 👈 animācija
                
                .alert("Pievienots grozam ✅", isPresented: $showAlert) {
                    Button("OK", role: .cancel) {}
                }
            }
            .padding()
        }
        .background(Color("BackgroundColor").ignoresSafeArea())
        .navigationTitle("Produkts")
        .navigationBarTitleDisplayMode(.inline)
    }
}
