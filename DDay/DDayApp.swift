//
//  DDayApp.swift
//  DDay
//
//  Created by Fenn on 2023/11/7.
//

import SwiftUI
import SwiftData

@main
struct DDayApp: App {
    @AppStorage("dietAmount") private var dietAmount : Int = 0
    @AppStorage("drinkAmount") private var drinkAmount : Int = 0
    
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            User.self,
//            Drink.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//        
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    scheduleResetTask()
                }
        }
//        .modelContainer(sharedModelContainer)
    }
    
    func scheduleResetTask() {
        let calendar = Calendar.current
        let now = Date()
        
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: now)
        dateComponents.hour = 0
        dateComponents.minute = 0
        
        let timeInterval = TimeInterval(24 * 60 * 60)  // 将整型值转换为时间间隔类型
        if let targetDate = calendar.date(from: dateComponents) {
            if targetDate <= now {
                dateComponents.day! += 1
            }
            let timer = Timer(fire: targetDate, interval: timeInterval, repeats: true) { _ in
                self.resetVariable() // 调用重置操作
            }
            RunLoop.main.add(timer, forMode: .common)
        }
    }
    
    func resetVariable() {
        drinkAmount = 0
        dietAmount = 0
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: Date())
        
        let recordString = "Date: \(dateString), DrinkAmount: \(drinkAmount), DietAmount: \(dietAmount)\n"
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent("record.txt")
            
            do {
                if FileManager.default.fileExists(atPath: fileURL.path) {
                    let fileHandle = try FileHandle(forWritingTo: fileURL)
                    fileHandle.seekToEndOfFile()
                    fileHandle.write(recordString.data(using: .utf8)!)
                    fileHandle.closeFile()
                } else {
                    try recordString.write(to: fileURL, atomically: true, encoding: .utf8)
                }
            } catch {
                print("Error writing to file: \(error)")
            }
        }
    }
}
