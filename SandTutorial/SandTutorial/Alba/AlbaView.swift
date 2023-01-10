//
//  AlbaView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/31.
//

import SwiftUI

struct AlbaView: View {
    @State private var tabSelection: AlbaTabItem = .First
    
    var body: some View {
        TabView(selection: $tabSelection) {
            SalarySettingView()
                .accentColor(nil)
                .tabItem {
                    Label("설정", systemImage: "gear.circle")
                }
                .tag(AlbaTabItem.First)
            
            SalaryTabView()
                .accentColor(nil)
                .tabItem {
                    Label("급여", systemImage: "leaf")
                }
                .tag(AlbaTabItem.Second)
            
            SalaryListCalendarView()
                .accentColor(nil)
                .tabItem {
                    Label("달력", systemImage: "calendar")
                }
                .tag(AlbaTabItem.Third)
            
            DemoCalendarView()
                .accentColor(nil)
                .tabItem {
                    Label("데모", systemImage: "logo.playstation")
                }
                .tag(AlbaTabItem.Fourth)
        }
        .accentColor(.yellow)
        .navigationTitle(tabSelection.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationViewStyle(.stack)
    }
}

extension AlbaView {
    enum AlbaTabItem: String, CaseIterable {
        case First
        case Second
        case Third
        case Fourth
        
        var title: String {
            switch self {
            case .First:
                return "급여설정"
            case .Second:
                return "근태/급여"
            case .Third:
                return "근태/급여"
            case .Fourth:
                return "데모"
            }
        }
    }
}
