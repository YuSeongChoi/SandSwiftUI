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

struct Flower: View {
  let onTap: Binding<Int>
  let id: Int
  let color: Color
  let petals: [PetalProperties]

  init(onTap: Binding<Int>, properties: FlowerProperties) {
    self.onTap = onTap
    self.id = properties.id
    self.color = properties.color
    self.petals = properties.petals
  }

  var body: some View {
    ZStack {
      ForEach(petals) {
        FlowerPetal(properties: $0)
      }
      Circle()
        .fill(Color.yellow)
        .scaleEffect(0.25)
    }
    .onTapGesture {
      onTap.wrappedValue = id
    }
    .anchorPreference(key: TargetPreferenceKey.self, value: .bounds) { anchor in
      return [TargetModel(id: id, anchor: anchor)]
    }
  }
}

struct FlowerView_Previews: PreviewProvider {
  static var previews: some View {
    let flowers = FlowersModel(count: 3)
    VStack {
      Flower(onTap: .constant(0), properties: flowers.properties[0])
        .frame(width: 150, height: 150)
      Flower(onTap: .constant(0), properties: flowers.properties[1])
        .frame(width: 75, height: 75)
      Flower(onTap: .constant(0), properties: flowers.properties[2])
        .frame(width: 200, height: 200)
    }
  }
}
