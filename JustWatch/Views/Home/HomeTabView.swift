//
//  HomeTabView.swift
//  JustWatch
//
//  Created by Marchell on 13/02/21.
//

import SwiftUI

struct HomeTabView: View {
    
    let iconHeight: CGFloat = 22
    
    @StateObject private var router = HomeRouter()
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                VStack {
                    switch router.currentPage {
                    case .movie:
                        MovieNavigationView()
                    case .tv:
                        TVNavigationView()
                    case .search:
                        SearchNavigationView()
                    }
                }
                
                VStack {
                    Spacer()
                    HStack {
                        HStack {
                                
                            TabBarIcon(router: router, assignedPage: .movie, width: geometry.size.width/5.7, height: iconHeight, systemIconName: "film")
                            TabBarIcon(router: router, assignedPage: .tv, width: geometry.size.width/5.7, height: iconHeight, systemIconName: "tv")
                            TabBarIcon(router: router, assignedPage: .search, width: geometry.size.width/5.7, height: iconHeight, systemIconName: "magnifyingglass.circle")
                                
                        }.frame(width: geometry.size.width/1.6, height: 60, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(30)
                        .shadow(radius: 2)
                            
                    }.frame(width: geometry.size.width/1.2, height: 60, alignment: .center)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                }
                
            }.frame(width: geometry.size.width, height: geometry.size.height)
            
        }.edgesIgnoringSafeArea(.top)
    }
}

struct TabBarIcon: View {
    @StateObject var router: HomeRouter
    @State private var isActive = false
    
    let assignedPage: Page
    let width, height: CGFloat
    let systemIconName: String
    
    var body: some View {
        VStack {
            Image(systemName: router.currentPage == assignedPage ? "\(systemIconName).fill" : systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .foregroundColor(Color(hex: JWConfig.COLOR_SAPPHIRE))
                .onTapGesture {
                    withAnimation {
                        router.currentPage = assignedPage
                    }
                }
            
            Circle()
                .frame(width: 8, height: 8, alignment: .center)
                .foregroundColor(Color(hex: JWConfig.COLOR_SAPPHIRE))
                .transition(.scale)
                .isHidden(router.currentPage != assignedPage, remove: router.currentPage != assignedPage)
        }
    }
}

class HomeRouter: ObservableObject {
    @Published var currentPage: Page = .movie
}

enum Page {
    case movie
    case tv
    case search
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
