//
//  CartView.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 14/04/2026.
//

import SwiftUI

struct CartView: View {
    
    @StateObject private var viewModel = CartViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.cartItems) { item in
                Text(item.name)
            }
            .navigationTitle("Grozs")
        }
    }
}
