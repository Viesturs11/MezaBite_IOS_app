//
//  CartItem.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 14/04/2026.
//

import Foundation

struct CartItem: Identifiable, Codable {
    let id: String
    let product: Product
    var quantity: Int
}
