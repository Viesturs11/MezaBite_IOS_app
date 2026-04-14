//
//  CartItem.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 14/04/2026.
//

import Foundation

struct CartItem: Identifiable {
    let id = UUID()
    let product: Product
    var quantity: Int
}
