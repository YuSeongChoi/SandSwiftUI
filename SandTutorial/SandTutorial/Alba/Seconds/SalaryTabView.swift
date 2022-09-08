//
//  SalaryTabView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/31.
//

import SwiftUI

struct SalaryTabView: View {
    @State private var selection = SalaryMenuTabItem.Salary
    
    @ViewBuilder
    var salaryMenuView: some View {
        VStack(spacing: 0) {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    ForEach(SalaryMenuTabItem.allCases, id: \.self) { tab in
                        Button {
                            withAnimation {
                                selection = tab
                            }
                        } label: {
                            Color.clear.overlay(Text(tab.pagingTitle))
                        }
                        .foregroundColor(selection == tab ? .yellow : .gray)
                        .font(selection == tab ? .body : .body)
                    }
                }
                .background(Divider(), alignment: .bottom)
                .background(Divider(), alignment: .top)
                .overlay(Rectangle()
                    .size(width: geometry.size.width / 2, height: 2)
                    .offset(x: geometry.size.width * CGFloat(selection.index) / 2 , y: geometry.size.height - 2)
                    .foregroundColor(Color.yellow)
                         , alignment: .bottom)
            }
            .frame(height: 52).animation(.linear, value: selection)
            TabView(selection: $selection) {
                SalaryView()
                    .tag(SalaryMenuTabItem.Salary)
                HoldingTaxView()
                    .tag(SalaryMenuTabItem.Holding)
            }.tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
    
    var body: some View {
        salaryMenuView
    }
}

extension SalaryTabView {
    enum SalaryMenuTabItem: String, CaseIterable {
        case Salary
        case Holding
        
        var index: Int {
            switch self {
            case .Salary:
                return 0
            case .Holding:
                return 1
            }
        }
        
        var pagingTitle: String {
            switch self {
            case .Salary:
                return "세금"
            case .Holding:
                return "원천세"
            }
        }
    }
}

struct SalaryTabView_Previews: PreviewProvider {
    static var previews: some View {
        SalaryTabView()
    }
}
