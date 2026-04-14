//
//  CartViewModel.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 14/04/2026.
//
import Combine
import Foundation

class CartViewModel: ObservableObject {
    
    
    @Published var items: [CartItem] = [] {
        didSet {
            objectWillChange.send()
        }
    }
    
    // ➕ pievienošana ar quantity
    func addToCart(_ product: Product) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity += 1
        } else {
            let item = CartItem(id: product.id, product: product, quantity: 1)
            items.append(item)
        }
    }
    
    // ➖ noņemšana
    func removeFromCart(_ item: CartItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
        }
    }
    
    // ➕➖ mainīt daudzumu
    func increaseQuantity(_ item: CartItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].quantity += 1
        }
    }
    
    func decreaseQuantity(_ item: CartItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            if items[index].quantity > 1 {
                items[index].quantity -= 1
            } else {
                removeFromCart(item)
            }
        }
    }
    
    // 💰 kopējā summa
    var totalPrice: Double {
        items.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
}
