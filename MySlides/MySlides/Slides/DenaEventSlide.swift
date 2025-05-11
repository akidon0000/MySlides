//
//  DenaEventSlide.swift
//  MySlides
//
//  Created by Akihiro Matsuyama on 2025/05/11.
//

import SlideKit
import SwiftUI

@Slide
struct DenaEventSlide: View {
    @State var isActive: Bool
    @State var progress: Double = 0
    @State var isAnimatable: Bool
    let size: CGFloat = 3
    
    init(isActive: Bool, isAnimatable: Bool = false) {
        self.isActive = isActive
        self.isAnimatable = isAnimatable
    }
    
    var body: some View {
        ZStack {
            // 背景
            VStack {
                VStack(spacing: 0) {
                    ForEach(0..<10) { i in
                        Color.blue
                            .opacity(1-Double(i)/10)
                    }
                }
                VStack(spacing: 5)  {
                    Color.brown
                        .frame(height: 10 * size)
                    Color.brown
                        .frame(height: 20 * size)
                    Color.brown
                        .frame(height: 30 * size)
                }
            }
            
            // 表面
            VStack {
                // Mission Complete
                ZStack {
                    Text("Mission Complete")
                        .font(.system(size: 50 * size))
                        .foregroundStyle(.white)
                        .stroke(color: .black, width: 1 * size)
                }
                // 画像
                HStack {
                    Group {
                        ZStack {
                            Circle()
                                .frame(width: 60 * size, height: 60 * size)
                                .foregroundStyle(.red)
                            Image(systemName: "star.fill")
                                .foregroundStyle(.white)
                                .font(.system(size: 30 * size))
                        }
                        ZStack {
                            Circle()
                                .frame(width: 60 * size, height: 60 * size)
                                .foregroundStyle(.blue)
                            Image(systemName: "star.fill")
                                .foregroundStyle(.white)
                                .font(.system(size: 30 * size))
                        }
                        VStack(alignment: .leading) {
                            ZStack {
                                Circle()
                                    .frame(width: 60 * size, height: 60 * size)
                                    .foregroundStyle(.yellow)
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 30 * size))
                            }
                            Text("ポイント 10,000pt")
                                .fontWeight(.bold)
                                .font(.system(size: 30))
                                .stroke(color: .white, width: 3)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                .frame(width: 500 * size, height: 100 * size)
                ZStack {
                    Capsule()
                        .frame(width: 500 * size, height: 50 * size)
                        .foregroundStyle(.white)
                    Capsule()
                        .frame(width: 490 * size, height: 40 * size)
                        .foregroundStyle(.green)
                        .mask {
                            Rectangle()
                                .frame(width: 3000 * progress, height: 40 * size)
                                .offset(x: -750)
                        }
                    if isAnimatable {
                        SubView(num: progress)
                    }else{
                        ThirdView(num: progress)
                    }
                }
            }
            .onAppear {
                if isActive {
                    withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
                        progress = 1
                    }
                }
            }
        }
        .onTapGesture {
            withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
                progress = 1
            }
        }
    }
}

struct SubView: View, Animatable {
    var animatableData: Double {
        get { num }
        set { num = newValue }
    }
    var num: Double
    var body: some View {
        Text("\(Int(num * 100))%")
            .fontWeight(.bold)
            .font(.system(size: 30))
    }
}

struct ThirdView: View {
    var num: Double
    var body: some View {
        Text("\(Int(num * 100))%")
            .fontWeight(.bold)
            .font(.system(size: 30))
    }
}

// 参考：https://qiita.com/SNQ-2001/items/00d9cbae4de2440168ec
struct StrokeBackground: ViewModifier {
    private let id = UUID()

    private var strokeSize: CGFloat

    private var strokeColor: Color

    init(strokeSize: CGFloat, strokeColor: Color) {
        self.strokeSize = strokeSize
        self.strokeColor = strokeColor
    }

    func body(content: Content) -> some View {
        if strokeSize > 0 {
            strokeBackgroundView(content: content)
        } else {
            content
        }
    }

    private func strokeBackgroundView(content: Content) -> some View {
        content
            .padding(strokeSize * 2)
            .background(strokeView(content: content))
    }

    private func strokeView(content: Content) -> some View {
        Rectangle()
            .foregroundColor(strokeColor)
            .mask(maskView(content: content))
    }

    private func maskView(content: Content) -> some View {
        Canvas { context, size in
            context.addFilter(.alphaThreshold(min: 0.01))
            context.drawLayer { ctx in
                if let resolvedView = context.resolveSymbol(id: id) {
                    ctx.draw(resolvedView, at: .init(x: size.width / 2, y: size.height / 2))
                }
            }
        } symbols: {
            content
                .tag(id)
                .blur(radius: strokeSize)
        }
    }
}

extension View {
    public func stroke(color: Color, width: CGFloat = 1) -> some View {
        modifier(StrokeBackground(strokeSize: width, strokeColor: color))
    }
}

#Preview {
    DenaEventSlide(isActive: true)
}
