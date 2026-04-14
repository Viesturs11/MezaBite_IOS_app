//
//  ProductRepository.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 14/04/2026.
//

import Foundation

class ProductRepository {
    
    // Load products from JSON
    func getProducts() -> [Product] {
        
        // 🔍 DEBUG pārbaude
        if let url = Bundle.main.url(forResource: "products", withExtension: "json") {
            print("FOUND JSON:", url)
        } else {
            print("JSON NOT FOUND ❌")
        }
        
        // 🔹 Reālā ielāde
        guard let url = Bundle.main.url(forResource: "products", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let products = try? JSONDecoder().decode([Product].self, from: data)
        else {
            print("FAILED TO LOAD PRODUCTS ❌")
            return []
        }
        
        print("LOADED PRODUCTS:", products)
        return products
    }
    
    // Save cart
    func saveCart(_ items: [Product]) {
        let data = try? JSONEncoder().encode(items)
        UserDefaults.standard.set(data, forKey: "cart")
    }
    
    // Load cart
    func loadCart() -> [Product] {
        guard let data = UserDefaults.standard.data(forKey: "cart"),
              let items = try? JSONDecoder().decode([Product].self, from: data)
        else {
            return []
        }
        return items
    }
}
