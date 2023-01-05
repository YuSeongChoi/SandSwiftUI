//
//  GeometryView2.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/14.
//

import SwiftUI

struct GeometryView2: View {
    
    @Namespace var namespace
    @Namespace var empty_namespace
    @Namespace var namespace1
    @Namespace var namespace2
    @Namespace var namespace3
    @State private var namespaceInUse = 0
    @State private var matched: Bool = false
    @State private var anchorIdx = 0
    
    let anchors: [UnitPoint] = [.topLeading, .top, .topTrailing, .trailing, .bottomTrailing, .bottom, .bottomLeading, .leading, .center]
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    let colors: [Color] = [.purple, .green, .yellow, .red]
    let direction: [Triangle2.Direction] = [.up, .down, .left, .right]
    
    var body: some View {
//        timerView
        exampleView2
    }
    
    @ViewBuilder
    private var timerView: some View {
        VStack(spacing: 50) {
                    ZStack(alignment: .topLeading) {
                            Triangle2(.down, .blue)
                                .overlay(Circle().fill(Color.red).frame(width: 10, height: 10).offset(UnitPoint.topLeading.dotOffset), alignment: .topLeading)
                                .matchedGeometryEffect(id: "id1", in: namespace, anchor: .topLeading)
                                .frame(width: 75, height: 75)
                            
                            Triangle2(.right, .green)
                                .overlay(
                                    Circle()
                                        .fill(Color.yellow)
                                        .frame(width: 10, height: 10)
                                        .offset(anchors[anchorIdx].dotOffset)
                                    , alignment: anchors[anchorIdx].alignment)
                                .matchedGeometryEffect(id: matched ? "id1" : "", in: namespace, anchor: anchors[anchorIdx], isSource: false)
                                .frame(width: 75, height: 75)
                                .offset(y: matched ? 0 : -100)
                        
                                        
                    }

                    Text("\(anchors[anchorIdx].anchorName)")
                    
                }.onReceive(timer) { _ in
                    withAnimation(.spring()) {
                        self.matched = false
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                // cycle through the array indefenitely
                                anchorIdx = (anchorIdx + 1) % anchors.count

                                self.matched = true
                            }
                        }
                    }
                }
            }
    
    @ViewBuilder
    private var exampleView1: some View {
        VStack(spacing: 50) {
            HStack {
                Triangle2(.down, .purple)
                    .matchedGeometryEffect(id: "id1", in: namespace)
                    .frame(width: 50, height: 50)
                    .border(Color.gray)
                
                Triangle2(.right, .green)
                    .matchedGeometryEffect(id: matched ? "id1" : "unpair1", in: namespace, isSource: false)
                    .frame(width: 50, height: 50)
                    .border(Color.gray)
                
                Triangle2(.up, .yellow)
                    .matchedGeometryEffect(id: "id2", in: namespace)
                    .frame(width: 50, height: 50)
                    .border(Color.gray)
                
                Triangle2(.left, .red)
                    .matchedGeometryEffect(id: matched ? "id2" : "unpair2", in: namespace, isSource: false)
                    .frame(width: 50, height: 50)
                    .border(Color.gray)
                
                Triangle2(.down, .orange)
                    .matchedGeometryEffect(id: matched ? "id2" : "unpair3", in: namespace, isSource: false)
                    .frame(width: 50, height: 50)
                    .border(Color.gray)
            }
        }
        Toggle(isOn: $matched.animation(.easeInOut)) {
            Text("Matched")
                .frame(width: 140)
        }
    }
    
    @ViewBuilder
    private var exampleView2: some View {
        VStack(spacing: 30) {
            HStack {
                // Namespace 1
                Rectangle().fill(Color.green.opacity(0.2)).frame(width: 50, height: 50)
                    .matchedGeometryEffect(id: 0, in: namespace1)
                    .matchedGeometryEffect(id: 1, in: namespace1)
                
                Rectangle().fill(Color.green.opacity(0.2)).frame(width: 50, height: 50)
                    .matchedGeometryEffect(id: 2, in: namespace1)
                    .matchedGeometryEffect(id: 3, in: namespace1)
                
                // Namespace 2
                Rectangle().fill(Color.blue.opacity(0.2)).frame(width: 50, height: 50)
                    .matchedGeometryEffect(id: 0, in: namespace2)
                    .matchedGeometryEffect(id: 2, in: namespace2)
                
                Rectangle().fill(Color.blue.opacity(0.2)).frame(width: 50, height: 50)
                    .matchedGeometryEffect(id: 1, in: namespace2)
                    .matchedGeometryEffect(id: 3, in: namespace2)
                
                // Namespace 3
                Rectangle().fill(Color.red.opacity(0.2)).frame(width: 50, height: 50)
                    .matchedGeometryEffect(id: 0, in: namespace3)
                    .matchedGeometryEffect(id: 1, in: namespace3)
                    .matchedGeometryEffect(id: 2, in: namespace3)
                    .matchedGeometryEffect(id: 3, in: namespace3)
            }
            
            HStack {
                ForEach(0..<4) { idx in
                    Triangle2(direction[idx], colors[idx])
                        .matchedGeometryEffect(id: idx, in: activeNamespace(), isSource: false)
                        .frame(width: 50, height: 50)
                }
            }
            
            HStack(spacing: 30) {
                Button("Match namespace1") { withAnimation { namespaceInUse = 1 }}
                Button("Match namespace2") { withAnimation { namespaceInUse = 2 }}
                Button("Match namespace3") { withAnimation { namespaceInUse = 3 }}
            }
            Button("Unmatch") { withAnimation { namespaceInUse = 0 }}
        }
    }
    
    func activeNamespace() -> Namespace.ID {
        if namespaceInUse == 1 {
            return namespace1
        } else if namespaceInUse == 2 {
            return namespace2
        } else if namespaceInUse == 3 {
            return namespace3
        } else {
            return empty_namespace
        }
    }
    
}

struct GeometryView2_Previews: PreviewProvider {
    static var previews: some View {
        GeometryView2()
    }
}

struct Triangle2: View {
    
    let direction: Direction
    let color: Color
    
    init(_ direction: Direction = .down, _ color: Color = .black) {
        self.direction = direction
        self.color = color
    }
    
    var body: some View {
        TriangleShape()
            .fill(color)
            .border(Color.black)
            .rotationEffect(Angle.degrees(direction.rawValue))
    }
    
    struct TriangleShape: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: rect.maxX, y: 0))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
            path.closeSubpath()
            
            return path
        }
    }
    
    enum Direction: Double {
        case down = 0
        case left = 90
        case up = 180
        case right = 270
    }
    
}

extension UnitPoint {
    var anchorName: String {
        switch self {
        case .topLeading: return ".topLeading"
        case .top: return ".top"
        case .topTrailing: return ".topTrailing"
        case .trailing: return ".trailing"
        case .bottomTrailing: return ".bottomTrailing"
        case .bottom: return ".bottom"
        case .bottomLeading: return ".bottomLeading"
        case .leading: return ".leading"
        case .center: return ".center"
        default: return ""
        }
    }
    
    var alignment: Alignment {
        switch self {
        case .topLeading: return .topLeading
        case .top: return .top
        case .topTrailing: return .topTrailing
        case .trailing: return .trailing
        case .bottomTrailing: return .bottomTrailing
        case .bottom: return .bottom
        case .bottomLeading: return .bottomLeading
        case .leading: return .leading
        case .center: return .center
        default: return .center
        }
    }
    
    var dotOffset: CGSize { CGSize(width: (x - 0.5) * 2 * 5.0, height: (y - 0.5) * 2 * 5.0) }
}
