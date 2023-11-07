//
//  HomePageView.swift
//  DDay
//
//  Created by Fenn on 2023/11/7.
//

import SwiftUI

struct HomePageView : View {
    var body: some View{
        NavigationView {
            List {
                Section(header: Text("日程表")) {
                    NavigationLink(destination: HomeCalendarView()) {  // TODO: 日程表
                        Text("日程表")
                    }
                    Text("这是一个占位符")
                }
                
                Section(header: Text("手记")) {
                    NavigationLink(destination: HomeDiaryEditorView()) {  // TODO: 手记
                        Text("新的手记...")
                            .foregroundStyle(.purple)
                    }
                    NavigationLink(destination: HomeDiaryEditorView()) {  // TODO: 手记
                        HStack{
                            Text("手记 #1")
                            Spacer()
                            Image(systemName: "photo")
                        }
                    }
                    NavigationLink(destination: HomeDiaryEditorView()) {  // TODO: 手记
                        HStack{
                            Text("手记 #2")
                            Spacer()
                            Image(systemName: "photo")
                        }
                    }
                    Text("...")
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle(Text("DDay"))
        }
    }
}

#Preview {
    HomePageView()
}
