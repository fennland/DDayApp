//
//  watchDDayApp.swift
//  watchDDay Watch App
//
//  Created by Fenn on 2023/11/12.
//

import SwiftUI
import WatchConnectivity

@main
struct watchDDay_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}



class InterfaceController: WKInterfaceController, WCSessionDelegate {
    var session: WCSession?
    
    override init() {
        super.init()
        
        // 设置 WatchConnectivity 会话
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // 当 WatchConnectivity 会话激活完成后，你可以在这里获取 iOS 应用中存储的值
        if session.isReachable {
            let requestData: [String: Any] = ["request": "getSharedData"]
            session.sendMessage(requestData, replyHandler: { replyData in
                if let sharedData = replyData["sharedData"] as? String {
                    // 在这里使用从 iOS 应用中获取的 sharedData 值
                    print("Received shared data from iOS app: \(sharedData)")
                }
            }, errorHandler: { error in
                print("Error sending message to iOS app: \(error.localizedDescription)")
            })
        }
    }
}

