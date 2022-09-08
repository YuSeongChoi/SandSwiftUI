
import SwiftUI

struct BuzzyView: View {
  @State var beePosition = CGPoint(x: 75, y: 100)
  @State var selectedTargetID = -1
  @State var targets: [TargetModel] = []
  let miniMapScale: CGFloat = 0.25

  var body: some View {
    GeometryReader { geometry in
      ZStack {
        VStack {
          Hive(onTap: $selectedTargetID)
            .frame(width: 150, height: 250)
            .position(x: 75, y: geometry.size.height * 0.3)

          Spacer()

          FlowerField(onTap: $selectedTargetID)
        }

        Bee()
          .frame(width: 90, height: 115)
          .position(beePosition)
          .animation(beeMoveAnimation, value: beePosition)
      }
      .onChange(of: selectedTargetID) { newValue in
        // 1.
        guard let target = targets.first(where: { $0.id == newValue }) else {
          return
        }
        // 2.
        let targetFrame = geometry[target.anchor]
        // 3.
        beePosition = CGPoint(x: targetFrame.midX, y: targetFrame.midY)
      }
      .onPreferenceChange(TargetPreferenceKey.self) { value in
        targets = value
      }
      .miniMap(geometry: geometry)
    }
  }

  var beeMoveAnimation: Animation {
    Animation.spring(
      response: 1.5,
      dampingFraction: 0.455,
      blendDuration: 0)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
