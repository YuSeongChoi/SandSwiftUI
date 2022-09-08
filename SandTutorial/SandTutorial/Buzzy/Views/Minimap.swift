/// Copyright (c) 2021 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

extension View {
  func miniMap(geometry: GeometryProxy) -> some View {
    self.modifier(MiniMap(geometry: geometry))
  }
}

struct MiniMap: ViewModifier {
  let geometry: GeometryProxy
  let miniMapScale: CGFloat = 0.25

  func body(content: Content) -> some View {
    content.overlayPreferenceValue(TargetPreferenceKey.self) { mapTargets in
      // 2.
      ZStack {
        RoundedRectangle(cornerRadius: 8, style: .circular)
          .stroke(Color.black)
        // 1.
        ForEach(mapTargets) { target in
          // 2.
          let targetFrame = geometry[target.anchor]
          // 3.
          let mapTargetFrame = targetFrame.applying(
            CGAffineTransform(scaleX: miniMapScale, y: miniMapScale))

          // 4.
          switch target.id {
          // 5.
          case TargetModel.hiveID:
            Image(systemName: "house.fill")
              .foregroundColor(.purple)
              .frame(width: mapTargetFrame.width, height: mapTargetFrame.height)
              .position(x: mapTargetFrame.midX, y: mapTargetFrame.midY)
          case TargetModel.beeID:
            Image(systemName: "circle.fill")
              .foregroundColor(.orange)
              .frame(width: mapTargetFrame.width, height: mapTargetFrame.height)
              .position(x: mapTargetFrame.midX, y: mapTargetFrame.midY)
          // 6.
          default:
            Image(systemName: "seal.fill")
              .foregroundColor(.yellow)
              .frame(width: mapTargetFrame.width, height: mapTargetFrame.height)
              .position(x: mapTargetFrame.midX, y: mapTargetFrame.midY)
          }
        }
      }
      // 3.
      .frame(
        width: geometry.size.width * miniMapScale,
        height: geometry.size.height * miniMapScale)
      .position(x: geometry.size.width - 80, y: 100)
    }
  }
}
