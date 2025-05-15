//
//  WhatsAnimatableSlide.swift
//  MySlides
//
//  Created by Akihiro Matsuyama on 2025/05/15.
//

import SwiftUI
import SlideKit
import WebKit


struct WebView: NSViewRepresentable {
    let url: URL

    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
        // 更新の必要がある場合に実装
    }
}

@Slide
struct WhatsAnimatableSlide: View {
    let animatableDocURL = URL(string: "https://developer.apple.com/documentation/swiftui/animatable")!

    var body: some View {
        HeaderSlide("Animatableとは") {
            ZStack {
                HStack {
                    WebView(url: animatableDocURL)
                        
                    VStack {
                        Item("Animatable は SwiftUI に「この値はアニメーションできます」と伝えるプロトコル")
                        Item("animatableData を通じて補間の途中値が渡される → それを元に View を更新すれば「数字がヌルッと動く」")
                    }
                }
            }
        }

    }
}

#Preview {
    WhatsAnimatableSlide()
}
