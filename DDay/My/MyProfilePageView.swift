//
//  MyProfilePageView.swift
//  DDay
//
//  Created by Fenn on 2023/11/7.
//

import SwiftUI


struct MyProfilePageView: View {
    @Binding var fromWhich : Int
//    @AppStorage("MyProfileFromWhich") var MyProfileFromWhich : Int = 0
    var body: some View {
        List{
            if fromWhich == 0 {
                UserInfoView()
            }
            HealthInfoView()
        }
    }
    
    var Gender = ["女", "男", "多元性别"]
    @AppStorage("userName") private var userName : String = "用户"
    @AppStorage("userGender") private var userGender = 0
    @AppStorage("userAge") private var userAge : Int = 20
    
    @AppStorage("userHeight") private var userHeight : Double = 1.70
    @AppStorage("userWeight") private var userWeight : Double = 50.0
    @AppStorage("bmiIndex") private var bmi : Double = 0.0
    
    @State private var isShowMultiGenderAlert: Bool = false
    @AppStorage("useKilogram") private var useKilogram = true
    @AppStorage("currentWeightUnit") private var currentWeightUnit: String = "kg"
    
    func UserInfoView() -> some View {
        Section(header: Text("用户信息")){
            HStack{
                Text("用户名")
                Spacer()
                TextField("用户名", text: $userName)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: 150.0)
                    .multilineTextAlignment(.trailing)
            }
            Picker("性别", selection: $userGender) {
                ForEach(0..<Gender.count, id: \.self) {
                    Text(self.Gender[$0])
                }
            }
            .onChange(of: userGender) {
                if (userGender == 2) {
                    self.isShowMultiGenderAlert = true
                }
            }
            .alert(isPresented: self.$isShowMultiGenderAlert) {
                Alert(title: Text("注意"), message: Text("祝贺您勇敢选择了自己的性别！\n但请注意，此项内容仅用于健康数据的匹配，请尽可能选择您的生理性别。"))
            }
            HStack{
                Text("年龄")
                Spacer()
                TextField("年龄", value: $userAge, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: 100.0)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
    
    func HealthInfoView() -> some View {
        Section(header: Text("健康档案")){
            HStack{
                Text("BMI")
                Spacer()
                Text(getBMI() + " " + getBMILevel())
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            HStack{
                Text("身高")
                Spacer()
                TextField("身高", value: $userHeight, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: 100.0)
                    .multilineTextAlignment(.trailing)
                Text("m")
            }
            HStack{
                Text("体重")
                Spacer()
                TextField("体重", value: $userWeight, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: 150.0)
                    .multilineTextAlignment(.trailing)
                Text(currentWeightUnit)
            }
            Toggle(isOn: $useKilogram){
                Text("体重以 kg 为单位")
            }.onChange(of: useKilogram) {
                if useKilogram == false {
                    currentWeightUnit = "斤"
                    userWeight *= 2
                }
                else{
                    currentWeightUnit = "kg"
                    userWeight /= 2
                }
            }
        }
    }
    
    func getBMI() -> String {
        if currentWeightUnit == "kg" {
            bmi = userWeight / userHeight / userHeight
        } else {
            bmi = userWeight / 2 / userHeight / userHeight
        }
        return String(format: "%.2f", bmi) + "%"
    }
    
    func getBMILevel() -> String {
        switch (bmi) {
        case 0...18.4 :
            return "偏瘦"
        case 18.5...23.9 :
            return "正常"
        case 24.0...27.9 :
            return "过重"
        case 28.0...Double.infinity :
            return "肥胖"
        default:
            return ""
        }
    }
}

#Preview {
    MyProfilePageView(fromWhich: .constant(0))
}
