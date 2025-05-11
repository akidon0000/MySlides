//
//  CenterSlide.swift
//  MySlides
//
//  Created by Akihiro Matsuyama on 2025/05/11.
//

import SwiftUI
import SlideKit

@Slide
struct CenterSlide<Title> where Title: View {


    let title: () -> Title

    init(_ text: String) where Title == Text{
        self.title = {
            Text(text)
                .bold()
        }
    }

    init(_ title: @escaping () -> Title) {
        self.title = title
    }

    var body: some View {
        title()
            .font(.system(size: 100))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
            .allowsHitTesting(false)
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            CenterSlide("iPhoneと外部ディスプレイは\n同じデザインを表示していても実際は別のView🧐")
        }
    }
}
