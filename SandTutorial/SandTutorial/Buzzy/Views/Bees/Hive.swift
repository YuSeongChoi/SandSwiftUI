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

struct Hive: View {
  let onTap: Binding<Int>
  private let id = TargetModel.hiveID

  var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .top) {
        RoundedRectangle(cornerRadius: 8)
          .fill(LinearGradient(colors: [Color.black.opacity(0.2), Color.brown], startPoint: .top, endPoint: .bottom))
          .frame(width: geometry.size.width * 1.5, height: 20)
          .offset(x: -20, y: 5)

        hivePath(rect: geometry.frame(in: .local))
          .fill(RadialGradient(
            colors: [Color.orange, Color.red, Color.purple],
            center: .top,
            startRadius: 20,
            endRadius: geometry.size.width))
      }
      .anchorPreference(key: TargetPreferenceKey.self, value: .bounds) { anchor in
        [TargetModel(id: id, anchor: anchor)]
      }
      .onTapGesture {
        onTap.wrappedValue = id
      }
    }
  }

  private func hivePath(rect: CGRect) -> Path {
    let margin = rect.width * 0.05
    return Path { path in
      path.move(to: CGPoint(x: rect.minX + margin, y: rect.minY + margin))

      path.addQuadCurve(
        to: CGPoint(x: rect.maxX - margin, y: rect.minY + margin),
        control: CGPoint(x: rect.midX, y: rect.maxY))

      path.addRelativeArc(
        center: CGPoint(x: rect.maxX - (margin * 2), y: rect.minY + margin),
        radius: margin,
        startAngle: .degrees(0),
        delta: .degrees(-90))

      path.addLine(to: CGPoint(x: rect.minX + (margin * 2), y: rect.minY))

      path.addRelativeArc(
        center: CGPoint(x: rect.minX + (margin * 2), y: rect.minY + margin),
        radius: margin,
        startAngle: .degrees(180),
        delta: .degrees(90))

      path.closeSubpath()
    }
  }
}

struct Hive_Previews: PreviewProvider {
  static var previews: some View {
    Hive(onTap: .constant(0))
  }
}
