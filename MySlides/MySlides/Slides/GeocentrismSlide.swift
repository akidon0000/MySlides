//
//  GeocentrismSlide.swift
//  MySlides
//
//  Created by Akihiro Matsuyama on 2025/05/15.
//

import SwiftUI
import SlideKit

@Slide
struct GeocentrismSlide: View {
    @State private var onTaped: Bool = false
    
    var body: some View {
        ZStack {
            HStack {
                GeocentrismView()
                    .scaleEffect(2.0)

                Image("chi")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 1200)
                    .opacity(onTaped ? 1 : 0)
            }

            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    onTaped.toggle()
                }
        }
    }
}

#Preview {
    GeocentrismSlide()
}
enum GeocentrismPlanetarySystem {
    case sun
    case earth
    case moon
    case mars
    case mercury
    case venus
    
    var color: Color {
        switch self {
        case .sun: return .orange
        case .mercury: return .cyan
        case .venus: return .yellow
        case .earth: return .blue
        case .moon: return .gray
        case .mars: return .red
        }
    }
    
    var bodySize: Double {
        switch self {
        case .sun: return 50
        case .earth: return 20
        case .moon: return 8
        case .mars: return 12
        case .mercury: return 8
        case .venus: return 10
        }
    }
    
    /// 1周するのにかかる秒数
    var orbitDuration: Double {
        switch self {
        case .sun: return 30
        case .earth: return 0      // 地球は固定
        case .moon: return 10
        case .mars: return 150
        case .mercury: return 5
        case .venus: return 10
        }
    }
    
    /// 天動説における地球(中心)からの軌道半径
    var orbitRadius: Double {
        switch self {
        case .sun: return 100     // 太陽は地球の周りを回ると仮定
        case .earth: return 0
        case .moon: return 30
        case .mars: return 120
        case .mercury: return 60
        case .venus: return 80
        }
    }
}

struct EarthView: View {
    let planet = GeocentrismPlanetarySystem.earth
    var body: some View {
        Circle()
            .fill(planet.color)
            .frame(width: planet.bodySize)
    }
}

struct CircularMotion: View, Animatable {
    var planet: GeocentrismPlanetarySystem
    var progress: Double
    var showPath: Bool
    var influPlanetPos: CGPoint
    var onPositionChange: ((CGPoint) -> Void)? = nil
    let steps = 5000 // Pathの精細度
    
    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }
    var position: CGPoint {
        let radian = progress * 2 * Double.pi
        let x = influPlanetPos.x + planet.orbitRadius * cos(radian)
        let y = influPlanetPos.y + planet.orbitRadius * sin(radian)
        return CGPoint(x: x, y: y)
    }
    
    @State private var pathPositions: [CGPoint] = []
    
    var body: some View {
        ZStack {
            Circle()
                .fill(planet.color)
                .frame(width: planet.bodySize)
                .position(x: position.x,
                          y: position.y)
            
            if showPath {
                Path { path in
                    for i in 0..<pathPositions.count {
                        let point = CGPoint(x: pathPositions[i].x, y: pathPositions[i].y)
                        if i == 0 {
                            path.move(to: point)
                        } else {
                            path.addLine(to: point)
                        }
                    }
                }
                .stroke(planet.color, lineWidth: 1)
            }
        }
        .onChange(of: progress) { _ in
            onPositionChange?(position)
            // Pathの描画のために、ポジションを配列に保存する
            if pathPositions.count > steps {
                pathPositions.removeAll()
            }
                pathPositions.append(position)
        }
    }
}

struct MarsAnimationView: View, Animatable {
    var progress: Double
    var isPath: Bool = true
    
    var animatableData: Double {
        get { progress }
        set { progress = newValue * 2 * .pi * loopCount }
    }

    /// 軌道パラメータ
    let R: CGFloat = 100    // 大きい円の半径
    let r: CGFloat = 30     // 小さい円の半径
    let d: CGFloat = 80     // ペン先のオフセット
    let duration: Double = 25.0  // アニメーションの期間
    let loopCount: CGFloat = 3  // 何周分回転させるか
    let steps = 1000 // Pathの精細度

    // 天体の相対座標を計算(※天動説)
    func currentPosition(at angle: Double) -> CGPoint {
        let x = (R + r) * cos(angle) - d * cos(((R + r) / r) * angle)
        let y = (R + r) * sin(angle) - d * sin(((R + r) / r) * angle)
        return CGPoint(x: x, y: y)
    }

    var body: some View {
        VStack {
            GeometryReader { geometry in
                let center = CGPoint(x: geometry.size.width / 2,
                                     y: geometry.size.height / 2)
                let position = currentPosition(at: progress)
                ZStack {
                    // アニメーションする天体(点)
                    Circle()
                        .fill(GeocentrismPlanetarySystem.mars.color)
                        .frame(width: 12, height: 12)
                        .position(x: center.x + position.x,
                                  y: center.y + position.y)

                    if isPath {
                        Path { path in
                            for i in 0...steps {
                                let t = Double(i) / Double(steps) * progress
                                let pathPosition = currentPosition(at: t)
                                let point = CGPoint(x: center.x + pathPosition.x,
                                                    y: center.y + pathPosition.y)
                                if i == 0 {
                                    path.move(to: point)
                                } else {
                                    path.addLine(to: point)
                                }
                            }
                        }
                        .stroke(GeocentrismPlanetarySystem.mars.color, lineWidth: 1)
                    }
                }
            }
            .frame(width: 300, height: 300)
        }
    }
}


struct GeocentrismView: View {
    @State private var progress: CGFloat = 0.0
    @State private var sunPosition: CGPoint = .zero
    
    @State private var sunProgress: CGFloat = 0.0
    @State private var moonProgress: CGFloat = 0.0
    @State private var marsProgress: CGFloat = 0.0
    @State private var mercuryProgress: CGFloat = 0.0
    @State private var venusProgress: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            let center = CGPoint(x: geometry.size.width / 2,
                                 y: geometry.size.height / 2)
            ZStack {
                
                EarthView()
                
                CircularMotion(planet: .moon,
                               progress: moonProgress,
                               showPath: true,
                               influPlanetPos: center)
                
                CircularMotion(planet: .sun,
                               progress: sunProgress,
                               showPath: true,
                               influPlanetPos: center,
                               onPositionChange: { pos in
                    sunPosition = pos
                })
                
                
                CircularMotion(planet: .mercury,
                               progress: mercuryProgress,
                               showPath: true,
                               influPlanetPos: sunPosition)
                
                CircularMotion(planet: .venus,
                               progress: venusProgress,
                               showPath: true,
                               influPlanetPos: sunPosition)
                
                MarsAnimationView(progress: marsProgress, isPath: true)

            }
            .onAppear {
                let planet = GeocentrismPlanetarySystem.self
                withAnimation(.linear(duration: planet.moon.orbitDuration).repeatForever(autoreverses: false)) {
                    moonProgress = 1
                }
                withAnimation(.linear(duration: planet.sun.orbitDuration).repeatForever(autoreverses: false)) {
                    sunProgress = 1
                }
                withAnimation(.linear(duration: planet.mercury.orbitDuration).repeatForever(autoreverses: false)) {
                    mercuryProgress = 1
                }
                withAnimation(.linear(duration: planet.venus.orbitDuration).repeatForever(autoreverses: false)) {
                    venusProgress = 1
                }
                withAnimation(.linear(duration: planet.mars.orbitDuration).repeatForever(autoreverses: false)) {
                    marsProgress = 1
                }
            }
        }
    }
}
