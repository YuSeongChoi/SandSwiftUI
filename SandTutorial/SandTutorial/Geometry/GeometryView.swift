//
//  GeometryView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/14.
//

import SwiftUI

/**
 - matched Geometry
    1. 삽입되는 보기는 제거되는 보기의 크기와 위치로 시작됩니다. 그러나 전환하는 동안 그 크기와 위치는 원래 있어야 했던 위치에 도달하기 위해 움직입니다.
    2. 제거되는 뷰는 반대입니다. 자체 크기와 위치로 시작하여 전환하는 동안 삽입되는 뷰의 최종 크기와 위치에 애니메이션이 적용됩니다.
    3. 기본적으로 들어오는 보기는 페이드인되고 나가는 보기는 페이드 아웃됩니다.
 */

struct GeometryView: View {
    
    @Namespace var nspace
    @State private var flag: Bool = true
    
    var body: some View {
        VStack {
//            view1
            view2
        }
    }
    
    @ViewBuilder
    private var view1: some View {
        HStack {
            if flag {
                Rectangle()
                    .fill(Color.green)
                    .matchedGeometryEffect(id: "geoeffect1", in: nspace)
                    .frame(width: 100, height: 100)
            }
            
            Spacer()
            
            Button("Switch") {
                withAnimation(.easeInOut(duration: 1.0)) {
                    flag.toggle()
                }
            }
            
            Spacer()
            
            VStack {
                Rectangle().fill(Color.yellow).frame(width: 50, height: 50)
                
                if !flag {
                    Circle()
                        .fill(Color.blue)
                        .matchedGeometryEffect(id: "geoeffect1", in: nspace)
                        .frame(width: 50, height: 50)
                        .border(Color.black)
                        .zIndex(1)
                }
                
                Rectangle().fill(Color.yellow).frame(width: 50, height: 50)
            }
            
        }.frame(width: 250).padding(10).border(Color.gray, width: 3)
    }
    
    @ViewBuilder
    private var view2: some View {
        HStack {
            if flag {
                VStack {
                    Polygon(color: Color.green)
                        .offset(x: 30)
                        .matchedGeometryEffect(id: "geoeffect1", in: nspace)
                        .frame(width: 200, height: 200)
                }
                .transition(.polygonTriangle)
            }
            Spacer()
            Button("Switch") {
                withAnimation(.easeInOut(duration: 2.0)) {
                    flag.toggle()
                }
            }
            Spacer()
            if !flag {
                VStack {
                    Polygon(color: Color.blue)
                        .matchedGeometryEffect(id: "geoeffect1", in: nspace)
                        .frame(width: 200, height: 200)
                }
                .transition(.polygonCircle)
            }
        }
        .frame(width: 450).padding(40).border(Color.gray, width: 3)
    }
}

struct GeometryView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryView()
    }
}

struct Polygon: View {
    @Environment(\.polygonSides) var sides: Double
    let color: Color
    
    var body: some View {
        Group {
            if sides >= 30 {
                Circle()
                    .stroke(color, lineWidth: 10)
            } else {
                PolygonShape(sides: sides)
                    .stroke(color, lineWidth: 10)
            }
        }
    }
    
    struct PolygonShape: Shape {
        var sides: Double
        
        func path(in rect: CGRect) -> Path {
            let h = Double(min(rect.size.width, rect.size.height)) / 2.0
            let c = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
            var path = Path()
            let extra: Int = Double(sides) != Double(Int(sides)) ? 1 : 0
            
            for i in 0..<Int(sides) + extra {
                let angle = (Double(i) * (360.0 / Double(sides))) * Double.pi / 180
                let pt = CGPoint(x: c.x + CGFloat(cos(angle) * h), y: c.y + CGFloat(sin(angle) * h))
                
                if i == 0 {
                    path.move(to: pt) // move to first vertex
                } else {
                    path.addLine(to: pt) // draw line to next vertext
                }
            }
            path.closeSubpath()
            return path
        }
    }
}

extension AnyTransition {
    static var polygonTriangle: AnyTransition {
        AnyTransition.modifier(
            active: PolygonModifier(sides: 30, opacity: 0),
            identity: PolygonModifier(sides: 3, opacity: 1)
        )
    }
    
    static var polygonCircle: AnyTransition {
        AnyTransition.modifier(
            active: PolygonModifier(sides: 3, opacity: 0),
            identity: PolygonModifier(sides: 30, opacity: 1)
        )
    }
    
    struct PolygonModifier: AnimatableModifier {
        var sides, opacity: Double
        
        var animatableData: Double {
            get { sides }
            set { sides = newValue }
        }
        
        func body(content: Content) -> some View {
            return content
                .environment(\.polygonSides, sides)
                .opacity(opacity)
        }
    }
}

extension EnvironmentValues {
    var polygonSides: Double {
        get { return self[PolygonSidesKey.self] }
        set { self[PolygonSidesKey.self] = newValue }
    }
}

public struct PolygonSidesKey: EnvironmentKey {
    public static let defaultValue: Double = 4
}


