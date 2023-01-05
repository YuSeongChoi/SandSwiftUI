//
//  SteamView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/18.
//

import SwiftUI

struct SteamView: View {
    
    private var top = ["Card1", "Card2"]
    private var middle = ["m1", "m2", "m3"]
    private var bottom = ["b1", "b2", "b3"]
    private var detail = ["d1", "d2"]
    
    @State private var selected = "About"
    @State private var show: Bool = false
    
    var body: some View {
        TabView {
            homeView
                .tabItem {
                    Image(systemName: "house")
                }
            
            Text("Search")
                .tabItem {
                    Image("search")
                }
            
            Text("Person")
                .tabItem {
                    Image(systemName: "person.fill")
                }
            
            Text("Bookmark")
                .tabItem {
                    Image(systemName: "bookmark")
                }
        }
        .accentColor(.white)
        .preferredColorScheme(.dark)
        .edgesIgnoringSafeArea(.top)
    }
    
    @ViewBuilder
    private var homeView: some View {
        VStack(spacing: 15) {
            HStack {
                Spacer()
                Button {
                    
                } label: {
                    Image("Cart")
                }
            }.overlay(Image("Logo"))
            
            ScrollView(.vertical, showsIndicators: false) {
                topView.padding(.vertical, 15)
                middleView
                bottomView.padding(.top, 15)
            }
        }.padding()
    }
    
    @ViewBuilder
    private var topView: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Featured")
                .font(.title)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(top, id: \.self) { i in
                        Image(i)
                            .onTapGesture {
                                self.show.toggle()
                            }
                    }
                }
            }.padding(.top, 15)
        }.sheet(isPresented: $show) {
            detailView
        }
    }
    
    @ViewBuilder
    private var middleView: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Now on Stream").font(.title)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(middle, id: \.self) { i in
                        Image(i)
                    }
                }
            }.padding(.top, 15)
        }
    }
    
    @ViewBuilder
    private var bottomView: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Recommended")
                .font(.title)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(bottom, id: \.self) { i in
                        Image(i)
                    }
                }
            }.padding(.top, 15)
        }
    }
    
    @ViewBuilder
    private var detailView: some View {
        VStack(spacing: 0) {
            Image("Header")
            Spacer()
            ZStack {
                VStack(spacing: 20) {
                    HStack(spacing: 25) {
                        Button {
                            self.selected = "About"
                        } label: {
                            Text("About")
                                .padding(.vertical, 15)
                                .padding(.horizontal, 22)
                        }
                        .background(self.selected == "About" ? Color("Color") : Color.clear)
                        .foregroundColor(self.selected == "About" ? .white : Color.gray)
                        .cornerRadius(15)
                        
                        Button {
                            self.selected = "Media"
                        } label: {
                            Text("Media")
                                .padding(.vertical, 15)
                                .padding(.horizontal, 22)
                        }
                        .background(self.selected == "Media" ? Color("Color") : Color.clear)
                        .foregroundColor(self.selected == "Media" ? .white : Color.gray)
                        .cornerRadius(15)
                    }.padding(.top, 15)
                    
                    if self.selected == "About" {
                        aboutView
                    } else {
                        mediaView
                    }
                }
            }
            .background(Rounded().fill(Color.black))
            .padding(.top, -15)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    @ViewBuilder
    private var aboutView: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Welcome to San Francisco the birthplace of technological revolution. Play as young marcus a brillant hacker and join DedSec, the most celebrated Hacker Group Your Goal: the largest Hacking operation in History")
                .padding(.vertical, 15)
            
            HStack {
                Spacer()
                Button {
                    
                } label: {
                    Text("More about this game")
                }
            }
            
            Text("system Requirement")
                .padding(.vertical, 15)
            
            Button {
                
            } label: {
                HStack(spacing: 10) {
                    Image("min")
                    
                    Text("Minimum requirement")
                }
            }
            
            Button {
                
            } label: {
                HStack(spacing: 10) {
                    Image("max")
                    
                    Text("Maximum requirement")
                }
            }.padding(.top, 15)
            Spacer()
        }
        .padding(.horizontal, 25)
        .foregroundColor(Color.white.opacity(0.6))
    }
    
    @ViewBuilder
    private var mediaView: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Images")
                .font(.title)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(detail, id: \.self) { i in
                        Image(i)
                    }
                }
            }.padding(.top, 15)
            
            Text("Videos")
            ZStack {
                Image("d3")
                
                Button {
                    
                } label: {
                    Image(systemName: "play.circle.fill")
                        .font(.largeTitle)
                }.foregroundColor(.white)
            }.padding(.top, 15)
            Spacer()
        }.padding(.horizontal, 25)
            .foregroundColor(.white)
    }
    
}

struct Rounded: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: 25, height: 25))
        
        return Path(path.cgPath)
    }
}

struct SteamView_Previews: PreviewProvider {
    static var previews: some View {
        SteamView()
    }
}
