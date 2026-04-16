//
//  RootView.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 14/04/2026.
//

import SwiftUI

struct RootView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)
            
            ProductsView()
                .tabItem {
                    Label("Produkti", systemImage: "leaf")
                }
                .tag(1)
            
            CartView()
                .tabItem {
                    Label("Grozs", systemImage: "cart")
                }
                .tag(2)
            
            ContactView()
                .tabItem {
                    Label("Kontakti", systemImage: "phone")
                }
                .tag(3)
        }
        .environment(\.selectedTab, $selectedTab) // padod uz leju
    }
}
