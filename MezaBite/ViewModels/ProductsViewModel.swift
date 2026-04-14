//
//  ProductsViewModel.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 14/04/2026.
//
import Combine
import Foundation

class ProductsViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    
    private let repository = ProductRepository()
    
    func loadProducts() {
        products = repository.getProducts()
        print(products) // pārbaude
    }
}
