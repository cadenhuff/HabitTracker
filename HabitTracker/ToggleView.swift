//
//  ToggleView.swift
//  HabitTracker
//
//  Created by Caden Huffman on 8/25/23.
//

import SwiftUI

struct ToggleView: View {
    @State private var toggleOn = true
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: self.toggleOn ? .leading : .trailing) {
                Capsule()
                    .frame(width: geo.size.width * 0.7 + 4, height: geo.size.width * 0.1 + 4, alignment: .center)
                    .foregroundColor(.pink)
                
                Capsule()
                    .frame(width: geo.size.width * 0.35, height: geo.size.width * 0.1, alignment: .center)
                    .overlay(Capsule().stroke(Color.pink, lineWidth: 4))
                    .foregroundColor(.white)
                
            }
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.2)) {
                    self.toggleOn.toggle()
                }
            }
        }
    }
}


struct ToggleView_Previews: PreviewProvider {
    static var previews: some View {
        ToggleView()
    }
}
