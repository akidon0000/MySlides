//
//  SuccessMethodSlide.swift
//  MySlides
//
//  Created by Akihiro Matsuyama on 2025/05/14.
//

import SwiftUI
import SlideKit

@Slide
struct SuccessMethodSlide: View {

    var body: some View {
        HStack {
            Spacer()
            Code(code, fontSize: 28)
                .padding()
                .border(.black, width: 1)
            Spacer()
            SuccessMethodSubView()
            Spacer()
        }
    }

    var code: String {
        """
        struct SubView: View, Animatable {
            var number: Double

            var animatableData: Double {
                get { number }
                set { number = newValue }
            }

            var body: some View {
                Text("進捗: " + Int(number).description + " %")
            }
        }
        struct ContentView: View {
            @State var progress = 1.0

            var body: some View {
                VStack() {
                    SubView(number: progress)

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

struct SuccessMethodSubView: View {
    @State private var progress: Double = 1.0

    var body: some View {
        VStack(spacing: 100) {
            AnimatingNumber(number: progress)
                .font(.system(size: 50))

            Button(action: {
                withAnimation(.linear(duration: 5)) {
                    progress = 100.0
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

struct AnimatingNumber: View, Animatable {
    var number: Double

    var animatableData: Double {
        get { number }
        set { number = newValue }
    }

    var body: some View {
        Text("進捗: " + Int(number).description + " %")
    }
}

#Preview {
    SuccessMethodSlide()
}
