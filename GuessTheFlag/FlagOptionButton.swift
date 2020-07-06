//
//  Flag.swift
//  GuessTheFlag
//
//  Created by Pant, Karun on 05/04/20.
//  Copyright © 2020 Pant, Karun. All rights reserved.
//

import SwiftUI

struct Flag: View {
    var country: String
    var onTap: () -> ()
    var shouldAnimate: Bool = false
    var body: some View {
        Button(action: onTap) {
            Image(country).renderingMode(.original)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(Color(.white), lineWidth: 4))
                .shadow(radius: 4)
        }.animation(shouldAnimate ? .easeInOut : nil)
    }
}
