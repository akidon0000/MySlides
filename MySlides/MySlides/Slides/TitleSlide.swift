//
//  title.swift
//  MySlides
//
//  Created by Akihiro Matsuyama on 2025/05/11.
//

import SlideKit
import SwiftUI

@Slide
struct TitleSlide: View {
    var body: some View {
        
        VStack(alignment: .leading, spacing: 50) {
            titleText
        }
        .padding(.leading, 80)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .overlay {
            HStack(alignment: .center) {
                Image("akidon0000")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .scaledToFit()
                    .overlay(
                        Circle()
                            .stroke(Color.accentColor, lineWidth: 2)
                    )
                    .padding(30)
                
                Text("@akidon0000")
                    .fontWeight(.semibold)
                    .font(.system(size: 60))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 40)
            
            VStack(alignment: .trailing) {
                Text("2025/5/13")
                    .fontWeight(.semibold)
                    .font(.system(size: 40))
                Text("Mobile LT")
                    .fontWeight(.semibold)
                    .font(.system(size: 50))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(.top, 40)
            .padding(.trailing, 40)
        }
    }
    
    var titleText: Text {
        Text("Animatable")
            .font(.system(size: 150))
            .fontWeight(.heavy)
            .foregroundColor(.accentColor)
        + Text(" って何者？\n")
            .font(.system(size: 100))
            .fontWeight(.heavy)
        + Text("アニメーションの落とし穴")
            .font(.system(size: 100))
            .fontWeight(.heavy)
    }
    
    var script: String {
        """
        「iPhoneシミュレーターに目を生やす」というタイトルで発表します。
        ちなみにこのスライドは「まつじ」さんのSlideKitを使ってSwiftUIで作ってます。
        """
    }
}


#Preview {
    TitleSlide()
}
