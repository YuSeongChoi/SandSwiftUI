//
//  AnimationView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/11.
//

import SwiftUI

struct AnimationView: View {
    
    @State private var transitionToggle: Bool = false
    @State private var animationToggle: Bool = false
    @State private var animate: Bool = false
    @State private var animationAmount: CGFloat = 1
    @State private var rotationAmount: CGFloat = 0.0
    
    let timing: Double = 3
    
    var body: some View {
        VStack {
//            transitionView
//            circleView
//            stepperView
            animationView
        }
    }
    
    @ViewBuilder
    private var animationView: some View {
        VStack {
            Button("애니메이션") {
                animate.toggle()
            }
            RoundedRectangle(cornerRadius: 20)
                .frame(width: animate ? 300 : 200, height: 100)
                .overlay(
                    Text("animation: default")
                        .foregroundColor(.white)
                )
                .animation(Animation.default)
            RoundedRectangle(cornerRadius: 20)
                .frame(width: animate ? 300 : 200, height: 100)
                .overlay(
                    Text("animation: spring")
                        .foregroundColor(.white)
                )
                .animation(Animation.spring(
                    // 몇초에 걸쳐서 작동시킬지
                    response: 3.0,
                    // damping 비율 할지
                    dampingFraction: 0.3,
                    // 블렌드시간 기본 1로 지정
                    blendDuration: 1.0
                ))
            RoundedRectangle(cornerRadius: 20)
                .frame(width: animate ? 300 : 200, height: 100)
                .overlay(
                    Text("animation: easeOut")
                        .foregroundColor(.white)
                )
                .animation(Animation.easeOut(duration: timing))
            RoundedRectangle(cornerRadius: 20)
                .frame(width: animate ? 300 : 200, height: 100)
                .overlay(
                    Text("animation: easeIn")
                        .foregroundColor(.white)
                )
                .animation(Animation.easeIn(duration: timing))
            RoundedRectangle(cornerRadius: 20)
                .frame(width: animate ? 300 : 200, height: 100)
                .overlay(
                    Text("animation: linear")
                        .foregroundColor(.white)
                )
                .animation(Animation.linear(duration: timing))
        }
    }
    
    @ViewBuilder
    private var rotationView: some View {
        VStack {
            Button("Tap Me") {
                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                    self.animationAmount += 360
                }
            }
            .padding(40)
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0.0, y: 1.0, z: 0.0))
        }
    }
    
    @ViewBuilder
    private var stepperView: some View {
        VStack {
            VStack {
                Stepper("Scale Amount", value: $animationAmount.animation(Animation.easeInOut(duration: 1).repeatCount(3, autoreverses: true)), in: 1...10)
                Spacer()
                Button("Tap Me") {
                    self.animationAmount += 1
                }
                .padding(40)
                .background(Color.green)
                .foregroundColor(.white)
                .clipShape(Circle())
                .scaleEffect(animationAmount)
            }
        }
    }
    
    @ViewBuilder
    private var circleView: some View {
        VStack {
            Button("Tap") {
//                self.animationAmount += 1
            }
            .padding(50)
            .background(Color.green)
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.yellow, lineWidth: 2)
                    .scaleEffect(animationAmount)
                    .opacity(Double(2 - animationAmount))
                    .animation(Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: false))
            )
            .onAppear {
                self.animationAmount = 2
            }
        }
    }
    
    @ViewBuilder
    private var transitionView: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Button("BUTTON") {
                    transitionToggle.toggle()
                }
                Spacer()
            }
            if transitionToggle {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: UIScreen.main.bounds.height * 0.5)
                    .transition(.asymmetric(insertion: AnyTransition.move(edge: .bottom),
                                            removal: AnyTransition.move(edge: .leading)))
//                    .transition(AnyTransition.opacity.animation(.easeInOut))
//                    .transition(.move(edge: .bottom))
                    .animation(.easeIn)
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct AnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView()
    }
}
