//
//  Selfintroduction.swift
//  MySlides
//
//  Created by Akihiro Matsuyama on 2025/05/11.
//

import SwiftUI
import SlideKit

@Slide
struct SelfIntroSlide: View {

    var body: some View {
        HeaderSlide("自己紹介") {
            item(name: "所属", content: "Sansan EU Mobile")
            item(name: "名前", content: "あきどん")
            item(name: "Times", content: "times-akidon")
            item(name: "X", content: "@akidon0000")
            item(name: "最近の出来事", content: "ボルダリングにハマりました")
        }
        .overlay {
            HStack {
                Spacer()
                .frame(maxWidth: .infinity)
                
                Spacer()
                    .frame(maxWidth: 300)
                
                VStack {
                    Image("akidon0000")
                        .resizable()
                        .frame(width: 400, height: 400)
                        .clipShape(Circle())
                        .scaledToFit()
                        .overlay(
                            Circle()
                                .stroke(Color.blue, lineWidth: 5)
                        )
                        .padding(10)

                    Image("bouldering")
                        .resizable()
                        .scaledToFit()
                        .padding(10)
                }
                .frame(maxWidth: .infinity)


            }
            .padding(.trailing, 50)
        }
    }
    
    private func item(name: String, content: String) -> some View {
        HStack(spacing: 32) {
            Text(name)
                .fontWeight(.bold)
            Capsule()
                .foregroundColor(.accentColor)
                .frame(width: 20, height: 10)
            Text(content)
        }
        .fixedSize()
    }
}

#Preview {
    SelfIntroSlide()
}
