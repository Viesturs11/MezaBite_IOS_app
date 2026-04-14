//
//  RootView.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 14/04/2026.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            ProductsView()
                .tabItem {
                    Label("Produkti", systemImage: "leaf")
                }
            
            CartView()
                .tabItem {
                    Label("Grozs", systemImage: "cart")
                }
            
            ContactView()
                .tabItem {
                    Label("Kontakti", systemImage: "phone")
                }
        }
    }
}
