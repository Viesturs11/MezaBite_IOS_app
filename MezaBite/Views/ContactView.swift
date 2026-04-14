//
//  ContactView.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 14/04/2026.
//

import SwiftUI

struct ContactView: View {
    
    @State private var message = ""
    
    var body: some View {
        VStack {
            Text("Kontakti")
                .font(.title)
            
            TextField("Ziņa", text: $message)
                .textFieldStyle(.roundedBorder)
            
            Button("Nosūtīt") {
                print("Ziņa nosūtīta: \(message)")
            }
        }
        .padding()
    }
}
