//
//  notifications.swift
//  DDay
//
//  Created by Fenn on 2023/11/12.
//

import Foundation
import UserNotifications


//询问用户是否允许该app推送通知
//由于推送系统中类型蛮多的，可以自己去“设置”中研究一下。这里的.alert表示是否允许弹窗； .sound表示是否允许提示音；.badge表示通知弹窗中的那个小图。
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


//推送通知
func makeNotification(title: String, body: String, time: Date) {
    // 通知的内容
    let content = UNMutableNotificationContent()
    content.title = title
    content.body = body
    content.sound = UNNotificationSound.default
    
    // 设置触发器，在每日的特定时间触发通知
    let calendar = Calendar.current
    let triggerDate = calendar.dateComponents([.hour, .minute], from: time)
    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
    
    // 完成通知的设置
    let request = UNNotificationRequest(identifier: "DDay提醒", content: content, trigger: trigger)
    
    // 添加我们的通知到UNUserNotificationCenter推送的队列里
    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            // 添加通知时请求错误的处理
            print("Error adding notification \(title) request: \(error)")
        } else {
            print("Notification \(title) scheduled successfully")
        }
    }
}

func updateNotification(title: String, body: String, time: Date) {
    // 取消之前的通知请求
    removeNotification()
    // 创建新的通知请求
    makeNotification(title: title, body: body, time: time)
}

func removeNotification() {
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["DDay提醒"])
    }
