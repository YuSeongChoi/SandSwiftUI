//
//  NaviDemoView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/12/19.
//

import SwiftUI

struct NaviDemoView: View {
    
    var body: some View {
        NavigationView {
            NavigationLink(destination: AView()) {
                Text("MOVE!")
            }
        }
        .navigationTitle("Home")
    }
    
}


struct AView: View {
    var body: some View {
        NavigationLink(destination: BView()) {
            Text("AView")
        }
        .navigationTitle("AView")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct BView: View {
    var body: some View {
        VStack {
            Text("BView")
        }
    }
}

struct CView: View {
    var body: some View {
        VStack {
            Text("CView")
        }
    }
}
