//
//  ContentView.swift
//  DDay
//
//  Created by Fenn on 2023/11/7.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var index = UserDefaults.standard.integer(forKey: "selectedTabIndex")    // 从 UserDefaults 中恢复 tab 索引
    @State private var accColor : Color = .purple    // 默认主题色
    @AppStorage("dietAmount") private var dietAmount : Int = 0
    @AppStorage("drinkAmount") private var drinkAmount : Int = 0
    
    var body: some View {
        TabView(selection: $index){
            HomePageView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("DDay")
                }
                .tint(.purple)
                .tag(0)    // 添加 tag
            HealthPageView()
                .tabItem {
                    Image(systemName: "heart.text.square.fill")
                    Text("健康")
                }
                .tint(.pink)
                .tag(1)    // 添加 tag
            MyPageView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("我")
                }
                .tag(2)    // 添加 tag
        }
        .onChange(of: index) {
            UserDefaults.standard.set(index, forKey: "selectedTabIndex")    // 保存 tab 索引到 UserDefaults
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            // 应用进入前台时的处理，你也可以在这里进行一些操作
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            // 应用进入后台时的处理，你也可以在这里保存当前的 tab 索引
            UserDefaults.standard.set(index, forKey: "selectedTabIndex")    // 保存当前 tab 索引到 UserDefaults
        }
    }
    
    private func getSelectedPageViewColor() -> Color {
        switch index {
        case 0:
            print(index)
            return Color.purple
        case 1:
            print(index)
            return Color.pink
        case 2:
            print(index)
            return Color.blue
        default:
            print(index)
            return Color.blue
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
