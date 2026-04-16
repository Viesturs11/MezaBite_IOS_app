//
//  CartItem.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 14/04/2026.
//

import Foundation

struct CartItem: Identifiable, Codable {
    let id: UUID
    let product: Product
    var quantity: Int
    
    init(id: UUID = UUID(), product: Product, quantity: Int) {
        self.id = id
        self.product = product
        self.quantity = quantity
    }
}
