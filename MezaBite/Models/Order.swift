//
//  Order.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 15/04/2026.
//
import Foundation

struct Order: Identifiable, Codable {
    let id: Int
    let items: [CartItem]
    let total: Double
    
    let name: String
    let phone: String
    let address: String
}
