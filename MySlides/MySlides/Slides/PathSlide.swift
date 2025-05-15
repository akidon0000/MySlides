//
//  PathSlide.swift
//  MySlides
//
//  Created by Akihiro Matsuyama on 2025/05/15.
//

import SwiftUI
import SlideKit

@Slide
struct PathSlide: View {
    @State private var toggle = false
    
    var body: some View {
        HStack {
            Spacer()
            Code(code, fontSize: 28)
                .padding()
                .border(.black, width: 1)
            Spacer()
            VStack(spacing: 100) {
                
                NonAnimatedBar(width: toggle ? 550 : 100)
                    .frame(height: 30)
                
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 2)) {
                        toggle.toggle()
                    }
                }) {
                    Text("切り替え")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                }
                .frame(width: 300)
                .cornerRadius(10)
                .shadow(radius: 3)
            }
            .frame(width: 600)
            Spacer()
        }
    }

    var code: String {
        """
        struct ContentView: View {
            @State private var toggle = false

            var body: some View {
                VStack() {
                    NonAnimatedBar(width: toggle ? 550 : 100)

                    Button(action: {
                        withAnimation(.easeInOut(duration: 2)) {
                            toggle.toggle()
                        }
                    }) {
                        Text("切り替え")
                    }
                }
            }
        }
        struct NonAnimatedBar: Shape {
            var width: CGFloat
            
            func path(in rect: CGRect) -> Path {
                var path = Path()
                let barRect = CGRect(x: 0,
                                     y: 0,
                                     width: width,
                                     height: rect.height)
                path.addRoundedRect(in: barRect,
                                    cornerSize: CGSize(width: 8, height: 8))
                return path
            }
        }
        """
    }
}

// MARK: - Animatableなし
struct NonAnimatedBar: Shape {
    var width: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let barRect = CGRect(x: 0, y: 0, width: width, height: rect.height)
        path.addRoundedRect(in: barRect, cornerSize: CGSize(width: 8, height: 8))
        return path
    }
}


#Preview {
    PathSlide()
}
