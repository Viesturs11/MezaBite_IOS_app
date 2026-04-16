//
//  SelectedTabEnvironment.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 16/04/2026.
//

import SwiftUI

struct SelectedTabKey: EnvironmentKey {
    static let defaultValue: Binding<Int>? = nil
}

extension EnvironmentValues {
    var selectedTab: Binding<Int>? {
        get { self[SelectedTabKey.self] }
        set { self[SelectedTabKey.self] = newValue }
    }
}
