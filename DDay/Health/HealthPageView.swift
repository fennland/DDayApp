//
//  HealthPageView.swift
//  DDay
//
//  Created by Fenn on 2023/11/7.
//

import Foundation
import SwiftUI
import UserNotifications


struct HealthPageView : View {
    var caloriesBurningOptions = ["从来不动", "静态久坐，较少运动", "站站走走，经常运动", "运动员"]
    @AppStorage("MyProfileFromWhich") var MyProfileFromWhich : Int = 0
    
    // MARK: transfer to model
    @AppStorage("drinkAmount") private var drinkAmount : Int = 0
    @AppStorage("drinkPerAmount") private var drinkPerAmount : Int = 100
    // @AppStorage("lastDrinkDate") private var lastDrinkDate: Date = Date()
    // TODO: 每日饮水量重置，饮水量历史，数据持久化
    @State private var isExpandedDrink = false
    @State private var isSingleDrinkHint = true
    @State private var isEditingDrink = false
    @State private var HintDrinkEnough : String = ""
    
    @AppStorage("dietAmount") private var dietAmount : Int = 0
    @AppStorage("addCalories") private var addCalories : Double = 0.0
    @State private var isExpandedDiet = false
    @State private var isExpandedAddDiet = false
    
    @AppStorage("userWeight") private var weight: Double = 50.0
    @AppStorage("userHeight") private var height: Double = 1.7
    @AppStorage("userAge") private var userAge : Int = 20
    @AppStorage("userGender") private var userGender : Int = 0
    @AppStorage("caloriesBurning") private var caloriesBurning : Double = 1.2
    @AppStorage("caloriesBurningChoice") private var caloriesBurningChoice : Int = 0
    @State private var isEditingWeight = false
    @AppStorage("useKilogram") private var useKilogram = true
    @AppStorage("currentWeightUnit") private var currentWeightUnit: String = "kg"
    
    @AppStorage("bmiIndex") private var bmi : Double = 0.0
    @State private var isBMIToggle : Bool = false
    @AppStorage("isNotify") private var isNotify: Bool = false
    @State private var showNotificationTimeSettings : Bool = false
    @State private var whenToPushDrink = Date()
    @State private var whenToPushDiet = Date()
    @State private var showDietAddView : Bool = false
    var body: some View{
        NavigationView {
            List {
                DietView()
                DrinkView()
                SettingView()
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle(Text("健康"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: saveBtn
    
//    func DietView() -> some View {
//        Section(header: Text("进食")) {
//            HStack{
//                Text("摄入卡路里")
//                Spacer()
//                Text("\(dietAmount)" + " kCal")
//            }
//            HStack{
//                Text("体重")
//                Spacer()
//                if isEditingWeight {
//                    TextField("0.0", value: $weight, format: .number)
//                        .onSubmit {
//                            isEditingWeight = false
//                            weight = abs(weight)
//                        }
//                        .textFieldStyle(.roundedBorder)
//                        .multilineTextAlignment(.trailing)
//                        .frame(maxWidth: 80.0)
//                    Text(currentWeightUnit)
//                } else {
//                    Button(getProperWeight(weight: weight, currentWeightUnit: currentWeightUnit)) {
//                        isEditingWeight = true
//                    }
//                    .frame(maxWidth: .infinity, alignment: .trailing)
//                }
//            }
//            HStack{
//                Text("BMI")
//                Spacer()
//                NavigationLink(destination: MyProfilePageView(fromWhich: $MyProfileFromWhich)) {
//                    Button(getBMI() + " " + getBMILevel()) {
//                    }
//                    .frame(maxWidth: .infinity, alignment: .trailing)
//                }
//                .onAppear {
//                    MyProfileFromWhich = 1
//                }
//            }
//            NavigationLink(destination: Text("TODO")) {
//                Text("记一笔热量")
//            }
//            DisclosureGroup("进食设置", isExpanded: $isExpandedDiet) {
//                NavigationLink(destination: HealthHistoriesPageView(showType: .constant(2))) {
//                    Text("进食历史")
//                }
//                Toggle(isOn: $useKilogram){
//                    Text("体重以 kg 为单位")
//                }.onChange(of: useKilogram) {
//                    if useKilogram == false {
//                        currentWeightUnit = "斤"
//                        weight *= 2
//                    }
//                    else{
//                        currentWeightUnit = "kg"
//                        weight /= 2
//                    }
//                }
//                Button(action: {
//                    dietAmount = 0
//                }, label: {
//                    Text("清除计量")
//                })
//            }
//        }
//    }
    
    func DietView() -> some View {
        bmi = getBMI(weight: weight, height: height, currentWeightUnit: currentWeightUnit)
        return Section(header: Text("进食")){
            HStack{
                Text("摄入卡路里")
                Spacer()
                Text("\(dietAmount) kCal / \(Int(getRecommendedDietAmount(weight: weight, height:height, userGender:userGender, userAge: userAge, currentWeightUnit: currentWeightUnit, caloriesBurning: caloriesBurning))) kCal")
            }
            DisclosureGroup("记录进食", isExpanded: $isExpandedAddDiet) {
                HStack{
                    Text("热量")
                    Spacer()
                    TextField("0.0 kCal", value: $addCalories, format: .number)
                        .onSubmit {
                            dietAmount += Int(addCalories)
                            addCalories = 0.0
                        }
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.trailing)
                        .frame(maxWidth: 80.0)
                    Text("kCal")
                }
            }
            HStack{
                Text("BMI")
                Spacer()
                NavigationLink(destination: MyProfilePageView(fromWhich: $MyProfileFromWhich)) {
                    Button(String(format: "%.2f", bmi) + "%" + " " + getBMILevel(bmi: bmi)) {
                    }.frame(maxWidth: .infinity, alignment: .trailing)
                }
                .onAppear {
                    MyProfileFromWhich = 1
                }
            }
            HStack{
                Text("体重")
                Spacer()
                if isEditingWeight {
                    TextField("0.0", value: $weight, format: .number)
                        .onSubmit {
                            isEditingWeight = false
                            weight = abs(weight)
                        }
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.trailing)
                        .frame(maxWidth: 80.0)
                    Text(currentWeightUnit)
                } else {
                    Button(getProperWeight(weight: weight, currentWeightUnit: currentWeightUnit)) {
                        isEditingWeight = true
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            
            DisclosureGroup("进食设置", isExpanded: $isExpandedDiet) {
                NavigationLink(destination: HealthHistoriesPageView(showType: .constant(2))) {
                    Text("进食历史")
                }
                Picker("基础代谢系数", selection: $caloriesBurningChoice) {
                    ForEach(0..<caloriesBurningOptions.count, id: \.self) {
                        Text(self.caloriesBurningOptions[$0])
                    }
                }
                .onChange(of: caloriesBurningChoice) {
                    switch (caloriesBurningChoice){
                    case 0:
                        caloriesBurning = 1.2
                        break
                    case 1:
                        caloriesBurning = 1.4
                        break
                    case 2:
                        caloriesBurning = 1.7
                        break
                    case 3:
                        caloriesBurning = 2.0
                        break
                    default:
                        caloriesBurning = 1.2
                        break
                    }
                }
                Toggle(isOn: $useKilogram){
                    Text("体重以 kg 为单位")
                }.onChange(of: useKilogram) {
                    if useKilogram == false {
                        currentWeightUnit = "斤"
                        weight *= 2
                    }
                    else{
                        currentWeightUnit = "kg"
                        weight /= 2
                    }
                }
                Button(action: {
                    dietAmount = 0
                }, label: {
                    Text("清除计量")
                })
            }
        }
    }
    
    func DrinkView() -> some View {
        Section(header: Text("饮水")) {
            HStack{
                Text("饮水量 \(HintDrinkEnough)")
                Spacer()
                Text("\(drinkAmount) ml / \(getRecommendedDrinkAmount(weight: weight, currentWeightUnit: currentWeightUnit)) ml")
            }
            HStack{
                Text("我喝水了！")
                Spacer()
                if isEditingDrink {
                    TextField("单位饮水量", value: $drinkPerAmount, format: .number)
                        .onSubmit {
                            isEditingDrink = false
                        }
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.trailing)
                } else {
                    Button("\(drinkPerAmount) ml"
                    ) {}
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .simultaneousGesture(LongPressGesture(minimumDuration: 0.5).onEnded { _ in
                            isEditingDrink = true
                        })
                        .simultaneousGesture(TapGesture().onEnded{
                            drinkAmount += drinkPerAmount
                            if Int(drinkAmount) >= getRecommendedDrinkAmount(weight: weight, currentWeightUnit: currentWeightUnit) {
                                HintDrinkEnough = "✅"
                                removeNotification()
                            }
                        })
                }
            }
            
            DisclosureGroup("饮水设置", isExpanded: $isExpandedDrink) {
                NavigationLink(destination: HealthHistoriesPageView(showType: .constant(1))) {
                    Text("饮水历史")
                }
                Button(isSingleDrinkHint ? "单次饮水量" : "长按 \(drinkPerAmount) ml 即可修改"){
                    isSingleDrinkHint = !isSingleDrinkHint
                }
                Button(action: {
                    drinkAmount = 0
                    HintDrinkEnough = ""
                }, label: {
                    Text("清除计量")
                })
            }
        }
    }
    
    
    func SettingView() -> some View {
        Section(header: Text("设定")){
            Toggle(isOn: $isNotify){
                Text("定时通知")
            }.onChange(of: isNotify) {
                if (isNotify) {
                    setNotification { granted in
                        if !granted {
                            isNotify.toggle()
                        }
                    }
                }
            }
            if (isNotify) {
                DatePicker("每日饮水通知", selection: $whenToPushDrink, displayedComponents: .hourAndMinute)
                    .datePickerStyle(CompactDatePickerStyle())
                    .onChange(of: whenToPushDrink) {
                        updateNotification(title: "该喝水啦！", body: "今天已经喝了\(drinkAmount)ml水啦！每日应该喝够\(getRecommendedDrinkAmount(weight: weight, currentWeightUnit: currentWeightUnit))ml水哦～", time: whenToPushDrink)
                    }
            }
            if (isNotify) {
                DatePicker("每日进食通知", selection: $whenToPushDiet, displayedComponents: .hourAndMinute)
                    .datePickerStyle(CompactDatePickerStyle())
                    .onChange(of: whenToPushDiet) {
                        updateNotification(title: "今天摄入了多少卡路里呢？", body: "现在来看你已经摄入了\(dietAmount)kCal，进入DDay记录一下吧！", time: whenToPushDiet)
                    }
            }
        }
    }
    
//    func getProperWeight() -> String {
//        return "\(weight) \(currentWeightUnit)"
//    }
//    
//    func getBMI() -> String {
//        if currentWeightUnit == "kg" {
//            bmi = weight / height / height
//        } else {
//            bmi = weight / 2 / height / height
//        }
//        return String(format: "%.2f", bmi) + "%"
//    }
//    
//    func getBMILevel() -> String {
//        switch (bmi) {
//        case 0...18.4 :
//            return "偏瘦"
//        case 18.5...23.9 :
//            return "正常"
//        case 24.0...27.9 :
//            return "过重"
//        case 28.0...Double.infinity :
//            return "肥胖"
//        default:
//            return ""
//        }
//    }
//    
//    func getRecommendedDrinkAmount() -> Int {
//        if currentWeightUnit == "kg" {
//            return Int(weight / 32 * 1000)
//        } else {
//            return Int(weight / 2 / 32 * 1000)
//        }
//    }
    
    
//    //询问用户是否允许该app推送通知
//    //由于推送系统中类型蛮多的，可以自己去“设置”中研究一下。这里的.alert表示是否允许弹窗； .sound表示是否允许提示音；.badge表示通知弹窗中的那个小图。
//    func setNotification(completion: @escaping (Bool) -> Void) {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, _) in
//            if granted {
//                // 用户同意我们推送通知
//                print("Notification Allowed")
//                completion(true)
//            } else {
//                // 用户不同意
//                print("Notification Non-allowed")
//                completion(false)
//            }
//        }
//    }
//
//    
//    //推送通知
//    func makeNotification(title: String, body: String, time: Date) {
//        // 通知的内容
//        let content = UNMutableNotificationContent()
//        content.title = title
//        content.body = body
//        content.sound = UNNotificationSound.default
//        
//        // 设置触发器，在每日的特定时间触发通知
//        let calendar = Calendar.current
//        let triggerDate = calendar.dateComponents([.hour, .minute], from: time)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
//        
//        // 完成通知的设置
//        let request = UNNotificationRequest(identifier: "DDay提醒", content: content, trigger: trigger)
//        
//        // 添加我们的通知到UNUserNotificationCenter推送的队列里
//        UNUserNotificationCenter.current().add(request) { error in
//            if let error = error {
//                // 添加通知时请求错误的处理
//                print("Error adding notification \(title) request: \(error)")
//            } else {
//                print("Notification \(title) scheduled successfully")
//            }
//        }
//    }
//    
//    func updateNotification(title: String, body: String, time: Date) {
//        // 取消之前的通知请求
//        removeNotification()
//        // 创建新的通知请求
//        makeNotification(title: title, body: body, time: time)
//    }
//
//    func removeNotification() {
//        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["DDay提醒"])
//    }
}

#Preview {
    HealthPageView()
}
