//
//  FailMethodSlide.swift
//  MySlides
//
//  Created by Akihiro Matsuyama on 2025/05/11.
//

import SwiftUI
import SlideKit

@Slide
struct FailMethodSlide: View {

    var body: some View {
        HStack{
            Spacer()
            Code(code, fontSize: 28)
                .padding()
                .border(.black, width: 1)
            Spacer()
            FailMethodSubView()
            Spacer()
        }
    }

    var code: String {
        """
        struct ContentView: View {
            @State var progress = 1.0

            var body: some View {
                VStack() {
                    Text("進捗: " + progress.description + " %")

                    Button(action: {
                        withAnimation(.linear(duration: 5)) {
                            progress = 100
                        }
                    }) {
                        Text("開始")
                    }
                }
            }
        }
        """
    }
}

struct FailMethodSubView: View {
    @State var progress: Int = 1

    var body: some View {
        VStack(spacing: 100) {
            Text("進捗: " + progress.description + " %")
                .font(.system(size: 50))
                .fontWeight(.bold)

            Button(action: {
                withAnimation(.linear(duration: 5)) {
                    progress = 100
                }
            }) {
                Text("開始")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
            }
            .frame(width: 200)
            .cornerRadius(10)
            .shadow(radius: 3)
        }
        .frame(width: 500, height: 600)
        .background(Color(.black).opacity(0.2))
        .cornerRadius(15)
        .padding()
    }
}

#Preview {
    FailMethodSlide()
}
