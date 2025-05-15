//
//  DenaEventSlide.swift
//  MySlides
//
//  Created by Akihiro Matsuyama on 2025/05/15.
//

import SwiftUI
import SlideKit

@Slide
struct DenaEventSlide: View {
    let shapeDocURL = URL(string: "https://developer.apple.com/documentation/swiftui/shape")!

    var body: some View {
        VStack {
            Spacer()
            
            Text("3月7日 とあるイベントにて、、、")
                .font(.system(size: 100))
                .frame(alignment: .center)
                .fontWeight(.bold)

            HStack(spacing: 100) {
                Image("dena")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 400)
                VStack {
                    Spacer()
                    Image("koshimizu-san")
                    Text("with Koshimizu-san")
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                }
            }
            .frame(maxHeight: 400)
            
            Spacer()
        }
    }
}

#Preview {
    DenaEventSlide()
}
