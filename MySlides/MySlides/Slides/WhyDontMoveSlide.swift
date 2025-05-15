//
//  WhyDontMoveSlide.swift
//  MySlides
//
//  Created by Akihiro Matsuyama on 2025/05/15.
//

import SwiftUI
import SlideKit

@Slide
struct WhyDontMoveSlide: View {
    var body: some View {
        HeaderSlide("なぜAnimatableがないとアニメーションされないのか？") {
            Item("SwiftUIのViewは、状態が変化したときに新しいViewを生成して表示する仕組みになっている")
            Item("そのため、状態が変化したときに新しいViewを生成するための情報が必要")
            Item("Animatableは、SwiftUIに「この値はアニメーションできます」と伝えるプロトコル")
            Item("animatableDataを通じて補間の途中値が渡される → それを元にViewを更新すれば「数字がヌルッと動く」")
            Item("SwiftUIは、animatableDataを使ってアニメーションを実現している")
            Item("animatableDataがないと、SwiftUIはアニメーションを実現できない")
            Item("progress が @State であるため、アニメーション対象にならない。")
            Item("withAnimation は状態変化にアニメーションをつけるだけで、progress = 100 という ステップ関数的な変更 に対しては途中経過（1→2→3→...→100）を自動で補完しません。")
            
        }
    }
}

#Preview {
    WhyDontMoveSlide()
}
