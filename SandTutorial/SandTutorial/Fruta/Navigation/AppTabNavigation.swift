//
//  AppTabNavigation.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/07.
//

import SwiftUI

struct AppTabNavigation: View {
    
    enum Tab {
        case menu
        case favorites
        case rewards
        case recipes
    }
    
    @State private var selection: Tab = .menu
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                SmoothieMenu()
            }
            .tabItem {
                let menuText = Text("Menu", comment: "Smoothie menu tab title")
                Label {
                    menuText
                } icon: {
                    Image(systemName: "list.bullet")
                }.accessibility(label: menuText)
            }
            .tag(Tab.menu)
            
            NavigationView {
                FavoriteSmoothies()
            }
            .tabItem {
                Label {
                    Text("Favorites", comment: "Favorite smoothies tab title")
                } icon: {
                    Image(systemName: "heart.fill")
                }
            }
            .tag(Tab.favorites)
            
            #if EXTENDED_ALL
            NavigationView {
                RewardsView()
            }
            .tabItem {
                Label {
                    Text("Rewards", comment: "Smoothie rewards tab title")
                } icon: {
                    Image(systemName: "seal.fill")
                }
            }
            .tag(Tab.rewards)
            
            NavigationView {
                RecipeList()
            }
            .tabItem {
                Label {
                    Text("Recipes", comment: "Smoothie recipes tab title")
                } icon: {
                    Image(systemName: "book.closed.fill")
                }
            }
            .tag(Tab.recipes)
            #endif
        }
    }
    
}
