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

struct Bee: View {
  @State var wingRotation: Double = 20

  var body: some View {
    GeometryReader { geometry in
      beeBody(rect: geometry.frame(in: .local))
        .anchorPreference(key: TargetPreferenceKey.self, value: .bounds) { anchor in
          [TargetModel(id: TargetModel.beeID, anchor: anchor)]
        }
    }.onAppear {
      wingRotation = 10
    }
  }

  private func beeBody(rect: CGRect) -> some View {
    ZStack {
      beeWingPath(rect: rect)
        .fill(Color.yellow)
        .rotationEffect(.degrees(wingRotation))
        .animation(Animation.easeInOut(duration: 0.18).repeatForever(autoreverses: true), value: wingRotation)
      beeBodyPath(rect: rect)
        .fill(LinearGradient(
          colors: [Color.orange, Color.yellow],
          startPoint: .leading,
          endPoint: .trailing))

      beeBodyStripePath(rect: rect, radius: 15)
      beeBodyStripePath(rect: rect, radius: 25)


      beeBodyPath(rect: rect)
        .stroke(Color.orange, style: StrokeStyle(lineWidth: 4, lineJoin: .round))
      beeface(rect: rect)

      beeWingPath(rect: rect)
        .fill(Color.yellow)
        .rotationEffect(.degrees(-wingRotation))
        .animation(Animation.easeInOut(duration: 0.15).repeatForever(autoreverses: true), value: wingRotation)
    }
  }

  private func beeBodyPath(rect: CGRect) -> Path {
    Path { path in
      path.move(to: CGPoint(x: rect.minX, y: rect.midY))

      path.addQuadCurve(
        to: CGPoint(x: rect.maxX * 0.91, y: rect.maxY * 0.4),
        control: CGPoint(x: rect.midX, y: rect.maxY * 0.1))

      path.addQuadCurve(
        to: CGPoint(x: rect.maxX * 0.91, y: rect.maxY * 0.6),
        control: CGPoint(x: rect.maxX * 1.04, y: rect.midY))

      path.addQuadCurve(
        to: CGPoint(x: rect.minX, y: rect.midY),
        control: CGPoint(x: rect.midX, y: rect.maxY * 0.9))

      path.closeSubpath()
    }
  }

  private func beeBodyStripePath(rect: CGRect, radius: CGFloat) -> some View {
    Path { path in
      path.addRelativeArc(
        center: CGPoint(x: rect.minX, y: rect.midY),
        radius: radius,
        startAngle: .degrees(320),
        delta: .degrees(80))
    }
    .stroke(Color.black.opacity(0.3), lineWidth: 4)
  }

  private func beeface(rect: CGRect) -> some View {
    let width = 10.0
    let height = 10.0

    return ZStack {
      Path { path in
        path.addEllipse(
          in: CGRect(
            origin: CGPoint(x: rect.maxX - width * 3.5, y: rect.midY - height),
            size: CGSize(width: width, height: height)))
      }.fill(Color.black.opacity(0.7))

      Path { path in
        path.addEllipse(
          in: CGRect(
            origin: CGPoint(x: rect.maxX - width * 2.25, y: rect.midY - height),
            size: CGSize(width: width, height: height)))
      }.fill(Color.black.opacity(0.7))
    }
  }

  private func beeWingPath(rect: CGRect) -> Path {
    let width = rect.width * 0.4
    let height = rect.height * 0.6

    return Path { path in
      path.addEllipse(
        in: CGRect(
          origin: CGPoint(x: rect.midX - width / 2, y: rect.midY - height * 1.5),
          size: CGSize(width: width, height: height)))
    }
  }
}

struct Bee_Previews: PreviewProvider {
  static var previews: some View {
    Bee().frame(width: 90, height: 115)
  }
}
