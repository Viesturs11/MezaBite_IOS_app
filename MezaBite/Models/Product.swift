//
//  Product.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 14/04/2026.
//
import Foundation

struct Product: Identifiable, Codable {
    let id: String
    let name: String
    let description: String
    let price: Double
    let image: String
}
