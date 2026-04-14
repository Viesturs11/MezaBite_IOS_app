//
//  CartViewModel.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 14/04/2026.
//
import Combine
import Foundation

class CartViewModel: ObservableObject {
    
    @Published var cartItems: [Product] = []
    
    private let repository = ProductRepository()
    
    init() {
        loadCart()
    }
    
    func addToCart(_ product: Product) {
        cartItems.append(product)
        repository.saveCart(cartItems)
    }
    
    func loadCart() {
        cartItems = repository.loadCart()
    }
}
