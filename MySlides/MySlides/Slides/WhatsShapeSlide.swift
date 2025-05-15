//
//  WhatsShapeSlide.swift
//  MySlides
//
//  Created by Akihiro Matsuyama on 2025/05/15.
//

import SwiftUI
import SlideKit

@Slide
struct WhatsShapeSlide: View {
    let shapeDocURL = URL(string: "https://developer.apple.com/documentation/swiftui/shape")!

    var body: some View {
        HeaderSlide("Shapeとは") {
            ZStack {
                HStack {
                    WebView(url: shapeDocURL)
                        
                    VStack {
                        Item("Shape は Animatable 準拠している")
                        Item("つまり、animatableData を 実装すれば...")
                    }
                }
            }
        }

    }
}

#Preview {
    WhatsShapeSlide()
}
