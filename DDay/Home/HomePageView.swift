//
//  HomePageView.swift
//  DDay
//
//  Created by Fenn on 2023/11/7.
//

import SwiftUI

struct HomePageView : View {
    @State var noteItems: [NoteItem] = [NoteItem(writeTime: "2023.11.10", title: "示例手记", content: "DDay 示例手记")]
    @State var searchText = ""
    @AppStorage("userName") private var userName: String = "用户"
    var body: some View{
        NavigationSplitView {
            List{
                Section(header: Text("手记")) {
                    NavigationLink(destination: HomeDiaryEditorView(noteItems: $noteItems)) {  // TODO: 手记
                        Text("新的手记...")
                            .foregroundStyle(.purple)
                    }
                    ForEach(noteItems) { noteItem in
                        NoteListRow(noteItem: noteItem)
                    }
                }
                Section(header: Text("日程表")) {
                    NavigationLink(destination: HomeCalendarView()) {  // TODO: 日程表
                        Text("日程表")
                    }
                    Text("这是一个占位符")
                }
            }
            .listStyle(.insetGrouped)
            .navigationBarTitle(Text("DDay"))
        }
    detail: {
        VStack{
            HStack{
                HomeCalendarView()
                    .background(Color.blue.opacity(0.10))
                    .cornerRadius(10)
                    .padding(10)
            }
            Spacer()
            
        }
        .navigationTitle("Hello, \(userName)!")
        .navigationBarTitleDisplayMode(.large)
    }
    }
    
    // MARK: 搜索
    
    func searchBarView() -> some View {
        TextField("搜索内容", text: $searchText)
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                    
                    // 编辑时显示清除按钮
                    if searchText != "" {
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                    }
                }
            )
            .padding(.horizontal, 10)
    }
}

// MARK: 列表内容

struct NoteListRow: View {
    @ObservedObject var noteItem: NoteItem
    
    var body: some View {
        NavigationLink(destination: Text("TODO")){  // HomeDiaryEditorView(title: "示例手记 #1")
            HStack {
                Text(noteItem.title)
                    .font(.system(size: 17))
                Spacer()
                Text(noteItem.writeTime)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                //            VStack(alignment: .leading, spacing: 10) {
                //                Text(noteItem.writeTime)
                //                    .font(.system(size: 14))
                //                    .foregroundColor(.gray)
                //                Text(noteItem.title)
                //                    .font(.system(size: 17))
                //                    .foregroundColor(.black)
                //                Text(noteItem.content)
                //                    .font(.system(size: 14))
                //                    .foregroundColor(.gray)
                //                    .lineLimit(1)
                //                    .multilineTextAlignment(.leading)
                //            }
                //            Spacer()
                //
                //            Button(action: {}) {
                //                Image(systemName: "ellipsis")
                //                    .foregroundColor(.gray)
                //                    .font(.system(size: 23))
                //            }
            }
        }
    }
}



#Preview {
    HomePageView()
}
