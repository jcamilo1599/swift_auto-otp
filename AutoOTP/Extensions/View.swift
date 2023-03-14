//
//  View.swift
//  AutoOTP
//
//  Created by Juan Camilo Marín Ochoa on 13/03/23.
//

import SwiftUI

extension View {
    func disableWithOpacity(_ condition: Bool) -> some View{
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
}
