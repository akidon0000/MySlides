//
//  KoshimizuSanSlide.swift
//  MySlides
//
//  Created by Akihiro Matsuyama on 2025/05/11.
//

import SwiftUI
import SlideKit

@Slide
struct KoshimizuSanSlide: View {
    @State private var glowAmount = 0.0
    @State private var scale = 1.0
    @State private var showSpeechBubble = false

    var body: some View {
        ZStack {
            VStack {
                if showSpeechBubble {
                    SpeechBubble(text: "Animatable\nを使いましょう")
                        .frame(width: 400, height: 180)
                        .transition(.scale.combined(with: .opacity))
                }

                Image("koshimizu-san")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 400)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(
                                LinearGradient(
                                    colors: [.yellow, .orange, .red],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 3
                            )
                    )
                    .shadow(color: .yellow.opacity(glowAmount), radius: 20, x: 0, y: 0)
                    .scaleEffect(scale)
                    .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: scale)
                    .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: glowAmount)
                    .onAppear {
                        glowAmount = 0.8
                        scale = 1.05

                        // 少し遅れて吹き出しを表示
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            withAnimation(.spring()) {
                                showSpeechBubble = true
                            }
                        }
                    }
            }
        }
    }
}

struct SpeechBubble: View {
    var text: String

    var body: some View {
        ZStack {
            // 吹き出しの背景
            BubbleShape()
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)

            // テキスト
            Text(text)
                .font(.system(size: 40))
                .foregroundColor(.black)
                .padding()
        }
    }
}

struct BubbleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // 吹き出しの本体（角丸長方形）
        path.addRoundedRect(
            in: CGRect(x: 0, y: 0, width: rect.width, height: rect.height - 20),
            cornerSize: CGSize(width: 16, height: 16)
        )

        // 吹き出しの尖った部分
        path.move(to: CGPoint(x: rect.width / 2 - 10, y: rect.height - 20))
        path.addLine(to: CGPoint(x: rect.width / 2, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width / 2 + 10, y: rect.height - 20))

        return path
    }
}


#Preview {
    KoshimizuSanSlide()
}
