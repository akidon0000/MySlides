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
                Text("2024/11/3")
                    .fontWeight(.semibold)
                    .font(.system(size: 40))
                Text("Kanagawa.swift #1")
                    .fontWeight(.semibold)
                    .font(.system(size: 50))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(.top, 40)
            .padding(.trailing, 40)
        }
    }
    
    var titleText: Text {
        Text("iPhone Simulator")
            .font(.system(size: 150))
            .fontWeight(.heavy)
            .foregroundColor(.accentColor)
        + Text(" に\n")
            .font(.system(size: 100))
            .fontWeight(.heavy)
        + Text("目を生やす")
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


struct TitleSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            TitleSlide()
        }
    }
}
