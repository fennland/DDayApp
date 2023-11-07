//
//  ContentView.swift
//  DDay
//
//  Created by Fenn on 2023/11/7.
//

import SwiftUI
import SwiftData

struct ContentView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]
//
//    var body: some View {
//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
    @State private var index = 0    // 默认选中索引
    @State private var accColor : Color = .purple    // 默认主题色
    var body: some View {
        TabView (selection: $index){
            HomePageView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("DDay")
                }
                .tint(.purple)
            HealthPageView()
                .tabItem {
                    Image(systemName: "heart.text.square.fill")
                    Text("健康")
                }
                .tint(.pink)
            MyPageView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("我")
                }
        }.tint(accColor)
            .onChange(of: index){ newValue in
                getSelectedPageViewColor()
            }  // TODO: 点击不同的tabItem变色
    }
    
    private func getSelectedPageViewColor() {
        switch index {
        case 0:
            accColor = .purple
        case 1:
            accColor = .pink
        case 2:
            accColor = .blue
        default:
            accColor = .blue
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
