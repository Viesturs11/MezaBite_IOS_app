//
//  ProductsView.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 14/04/2026.
//

import SwiftUI

struct ProductsView: View {
    
    @StateObject private var viewModel = ProductsViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.products) { product in
                NavigationLink(destination: ProductDetailView(product: product)) {
                    Text(product.name)
                }
            }
            .navigationTitle("Produkti")
            .onAppear {
                viewModel.loadProducts()
            }
        }
    }
}
