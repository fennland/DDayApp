//
//  BotView.swift
//  DDay
//
//  Created by Fenn on 2024/1/9.
//

import SwiftUI

struct BotPageView: View {
    var body: some View {
        NavigationView {
            List {
                
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle(Text("聊天"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    BotPageView()
}
