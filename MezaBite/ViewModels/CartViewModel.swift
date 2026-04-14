//
//  CartViewModel.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 14/04/2026.
//
import Combine
import Foundation

class CartViewModel: ObservableObject {
    
    @Published var items: [CartItem] = []
    
    func addToCart(_ product: Product) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(product: product, quantity: 1))
        }
    }
    
    func increaseQuantity(at index: Int) {
        guard items.indices.contains(index) else { return }
        items[index].quantity += 1
    }
    
    func decreaseQuantity(at index: Int) {
        guard items.indices.contains(index) else { return }
        
        if items[index].quantity > 1 {
            items[index].quantity -= 1
        } else {
            items.remove(at: index)
        }
    }
    
    func removeFromCart(at index: Int) {
        guard items.indices.contains(index) else { return }
        items.remove(at: index)
    }
    
    var totalPrice: Double {
        items.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
}
