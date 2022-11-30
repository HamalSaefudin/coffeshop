//
//  CoffeshopMainView.swift
//  coffeshop
//
//  Created by Hamal Saefudin on 30/11/22.
//

import SwiftUI

struct CoffeshopMainView: View {
    @State private var tabSelected:EnumTabs = .browse
    var body: some View {
        NavigationStack {
            TabView(selection:$tabSelected){
                CoffeshopListView()
                    .listStyle(.plain)
                    .tabItem{
                        Image(systemName: "square.grid.2x2")
                        Text(EnumTabs.browse.rawValue.uppercased())
                    }
                
                    .tag(EnumTabs.browse)
                Text(EnumTabs.watch.rawValue.uppercased())
                    .tabItem{
                        Image(systemName: "play.rectangle")
                        Text(EnumTabs.watch.rawValue.uppercased())
                    }
                    .tag(EnumTabs.watch)
                Text(EnumTabs.loans.rawValue.uppercased())
                    .tabItem{
                        Image(systemName: "rectangle.and.text.magnifyingglass")
                        Text(EnumTabs.loans.rawValue.uppercased())
                    }
                    .tag(EnumTabs.loans)
                Text(EnumTabs.profile.rawValue.uppercased())
                    .tabItem{
                        Image(systemName: "person")
                        Text(EnumTabs.profile.rawValue.uppercased())
                    }
                    .tag(EnumTabs.profile)
                
            }
            .tint(.indigo)
            .navigationTitle(tabSelected.rawValue.uppercased())
        }
    }
}

struct CoffeshopMainView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeshopMainView()
    }
}

//MARK: -ENUM
enum EnumTabs:String{
    case browse
    case watch
    case loans
    case profile
}

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content)
        -> some View
    {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
