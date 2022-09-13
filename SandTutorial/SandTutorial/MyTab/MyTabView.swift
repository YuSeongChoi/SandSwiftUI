//
//  MyTabView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/09/08.
//

import SwiftUI

struct MyTabView: View {
    @StateObject var viewRouter = ViewRouter()
    @State private var showPopUp = false
    
    let lightPurple = Color(red: 153/255, green: 102/255, blue: 255/255)
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                switch viewRouter.currentPage {
                case .home:
                    VStack {
                        Text("Home")
                        ZStack(alignment: .bottomTrailing) {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            FloatingMenu()
                                .padding()
                        }
                    }
                case .liked:
                    Text("Liked")
                case .records:
                    Text("Records")
                case .user:
                    Text("User")
                }
                Spacer()
                
                ZStack {
                    if showPopUp {
                        PlusMenuView(widthAndHeight: geometry.size.width / 7)
                            .offset(y: -geometry.size.height / 6)
                    }
                    HStack {
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .home, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "homekit", tabName: "Home")
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .liked, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "heart", tabName: "liked")
                        
                        ZStack {
                            Circle()
                                .foregroundColor(.white)
                                .frame(width: geometry.size.width/7, height: geometry.size.height/7)
                                .shadow(radius: 4)
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width/7-6, height: geometry.size.width/7-6)
                                .foregroundColor(lightPurple)
                                .rotationEffect(Angle(degrees: showPopUp ? 90 : 0))
                        }
                        .offset(y: -geometry.size.height/8/2)
                        .onTapGesture {
                            withAnimation {
                                showPopUp.toggle()
                            }
                        }
                        
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .records, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "waveform", tabName: "Records")
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .user, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "person.crop.circle", tabName: "Account")
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height/8)
                .background(Color(red: 240/255, green: 240/255, blue: 240/255)).shadow(radius: 2)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct FloatingMenu: View {
    @State private var showMenuToggle1: Bool = false
    @State private var showMenuToggle2: Bool = false
    @State private var showMenuToggle3: Bool = false
    
    var body: some View {
        if showMenuToggle1 {
            MenuItem(icon: "camera.fill")
        }
        if showMenuToggle2 {
            MenuItem(icon: "photo.on.rectangle")
        }
        if showMenuToggle3 {
            MenuItem(icon: "square.and.arrow.up.fill")
        }
        Button {
            withAnimation {
                showMenuToggle3.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation {
                    showMenuToggle2.toggle()
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation {
                    showMenuToggle1.toggle()
                }
            }
        } label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(Color(red: 153/255, green: 102/255, blue: 255/255))
                .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
        }
    }
}

struct MenuItem: View {
    var icon: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color(red: 153/255, green: 102/255, blue: 255/255))
                .frame(width: 55, height: 55)
            Image(systemName: icon)
                .imageScale(.large)
                .foregroundColor(.white)
        }
        .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
        .transition(.move(edge: .trailing))
    }
}

struct TabBarIcon: View {
    @ObservedObject var viewRouter: ViewRouter
    let assignedPage: ViewRouter.Page
    
    let width, height: CGFloat
    let systemIconName, tabName: String
    
    var body: some View {
        VStack {
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top, 10)
            Text(tabName)
                .font(.footnote)
            Spacer()
        }
        .padding(.horizontal, -4)
        .foregroundColor(viewRouter.currentPage == assignedPage ? Color("TabBarHighlight") : .gray)
        .onTapGesture {
            viewRouter.currentPage = assignedPage
        }
    }
}

struct PlusMenuView: View {
    let widthAndHeight: CGFloat
    let lightPurple = Color(red: 153/255, green: 102/255, blue: 255/255)
    
    var body: some View {
        HStack(spacing: 50) {
            ZStack {
                Circle()
                    .foregroundColor(lightPurple)
                    .frame(width: widthAndHeight, height: widthAndHeight)
                Image(systemName: "record.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(15)
                    .frame(width: widthAndHeight, height: widthAndHeight)
                    .foregroundColor(.white)
            }
            ZStack {
                Circle()
                    .foregroundColor(lightPurple)
                    .frame(width: widthAndHeight, height: widthAndHeight)
                Image(systemName: "folder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(15)
                    .frame(width: widthAndHeight, height: widthAndHeight)
                    .foregroundColor(.white)
            }
        }
        .transition(.scale)
    }
}

struct MyTabView_Previews: PreviewProvider {
    static var previews: some View {
        MyTabView()
    }
}

class ViewRouter: ObservableObject {
    enum Page {
        case home
        case liked
        case records
        case user
    }
    
    @Published var currentPage: Page = .home
}
