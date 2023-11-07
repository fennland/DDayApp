//
//  MyPageView.swift
//  DDay
//
//  Created by Fenn on 2023/11/7.
//

import SwiftUI

struct MyPageView : View {
    @State private var isNotification = false
    var body: some View{
        NavigationView {
            List {
                Section(header: Text("个人信息")) {
                    NavigationLink(destination: Text("编辑个人信息")) {
                        Text("我的档案")
                    }
                    Text("这是一个占位")
                }
                
                Section(header: Text("设置")) {
                    Toggle(isOn: $isNotification) {
                        Text("推送通知")
                    }
    //                        .onChange(of: isNotification) { newValue in
    //                            if newValue {
    //                                print("true")
    //                            }
    //                            else {
    //                                print("false")
    //                            }
    //                        }
                    NavigationLink(destination: Text("TODO")) {  // TODO: 隐私与安全，权限设置、退出重进安全锁等
                        Text("隐私与安全")
                    }
                    NavigationLink(destination: Text("TODO")) {  // TODO: 关于页面
                        Text("关于")
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .tabItem {
                    Text("我")
            }.navigationBarTitle(Text("设置"))
        }
    }
}

#Preview {
    MyPageView()
}
