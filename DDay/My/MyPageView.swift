//
//  MyPageView.swift
//  DDay
//
//  Created by Fenn on 2023/11/7.
//

import SwiftUI
import UserNotifications

struct MyPageView : View {
    @AppStorage("isNotify") private var isNotification = false
    @AppStorage("MyProfileFromWhich") var MyProfileFromWhich : Int = 0
    @State private var cacheSize: String = "计算中..."
    @State private var isCleared: Bool = false
    
    

    
    var body: some View{
        NavigationView {
            List {
                Section(header: Text("个人信息")) {
                    NavigationLink(destination: MyProfilePageView(fromWhich: $MyProfileFromWhich)) {
                        Text("我的档案")
                    }
                    .onAppear {
                        MyProfileFromWhich = 0
                    }
                    Text("这是一个占位")
                }
                
                Section(header: Text("设置")) {
                    Toggle(isOn: $isNotification) {
                        Text("推送通知")    // TODO: 通知选项
                    }
                    .onChange(of: isNotification) {
                        if (isNotification) {
                            setNotification { granted in
                                if !granted {
                                    isNotification.toggle()
                                    removeNotification()
                                }
                            }
                        }
                    }
                    HStack {
                        Text("缓存")
                        Spacer()
                        Button("\(cacheSize)") {
                            clearCache()
                        }.disabled((cacheSize == "计算中..." || cacheSize == "0 KB" || cacheSize == "Zero KB" || cacheSize == "已清除"))
                    }
                    .onAppear {
                        calculateCacheSize()
                    }
                    NavigationLink(destination: Text("TODO")) {  // TODO: 隐私与安全，权限设置、退出重进安全锁等
                        Text("隐私与安全")
                    }
                    NavigationLink(destination: AboutPageView()) {  // TODO: 关于页面
                        Text("关于")
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .tabItem {
                Text("我")
            }.navigationBarTitle(Text("设置"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func setNotification(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, _) in
            if granted {
                // 用户同意我们推送通知
                print("Notification Allowed")
                completion(true)
            } else {
                // 用户不同意
                print("Notification Non-allowed")
                completion(false)
            }
        }
    }
    
    func removeNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["DDay提醒"])
    }
    
    func calculateCacheSize() {
        var cacheSize: Int = 0
        
        // 计算缓存目录大小
        if let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
            if let contents = try? FileManager.default.contentsOfDirectory(atPath: cacheURL.path) {
                for file in contents {
                    let filePath = cacheURL.appendingPathComponent(file)
                    if let attributes = try? FileManager.default.attributesOfItem(atPath: filePath.path) {
                        if let fileSize = attributes[.size] as? Int {
                            cacheSize += fileSize
                        }
                    }
                }
            }
        }
        
        // 添加records.txt的大小
        if let recordsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("record.txt") {
            if let attributes = try? FileManager.default.attributesOfItem(atPath: recordsURL.path) {
                if let fileSize = attributes[.size] as? Int {
                    cacheSize += fileSize
                }
            }
        }
        
        // 显示缓存大小
        let formattedSize = ByteCountFormatter.string(fromByteCount: Int64(cacheSize), countStyle: .file)
        
        let displaySize = formattedSize.replacingOccurrences(of: "Zero", with: "0")
        
        self.cacheSize = displaySize
    }
    
    func clearCache() {
        do {
            if let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
                try FileManager.default.removeItem(at: cacheURL)
                
                // 删除records.txt文件
                if let recordsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("record.txt") {
                    try FileManager.default.removeItem(at: recordsURL)
                }
                
                cacheSize = "已清除"
                isCleared = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    isCleared = false
                    calculateCacheSize()
                }
            }
        } catch {
            print("Error clearing cache: \(error.localizedDescription)")
        }
    }
}

extension FileManager {
    func allocatedSizeOfDirectoryAtURL(_ directoryURL: URL) throws -> Int {
        let resourceKeys: [URLResourceKey] = [.isRegularFileKey, .fileSizeKey]
        let directoryEnumerator = self.enumerator(at: directoryURL, includingPropertiesForKeys: resourceKeys, options: [], errorHandler: { url, error in
            print("Directory enumeration error at \(url):", error)
            return true
        })!
        
        var totalSize = 0
        
        for case let fileURL as URL in directoryEnumerator {
            let resourceValues = try fileURL.resourceValues(forKeys: Set(resourceKeys))
            if resourceValues.isRegularFile == true, let fileSize = resourceValues.fileSize {
                totalSize += fileSize
            }
        }
        
        return totalSize
    }
}

#Preview {
    MyPageView()
}
