//
//  MezaBiteApp.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 14/04/2026.
//

import SwiftUI

@main
struct MezaBiteApp: App {
    
    @StateObject var cartVM = CartViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(cartVM)
                .tint(Color("PrimaryColor"))
        }
    }
}
