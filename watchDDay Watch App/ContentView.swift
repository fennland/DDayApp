//
//  ContentView.swift
//  watchDDay Watch App
//
//  Created by Fenn on 2023/11/12.
//

import SwiftUI
import Foundation


struct ContentView: View {
    @State private var currentPage: Int = 1
    @State private var currentPlace_drink : Int = 1
    @State private var currentPlace_diet : Int = 1
    @State private var currentPlace_test : Int = 1
    
    @AppStorage("userWeight") private var weight: Double = 50.0
    @AppStorage("userHeight") private var height: Double = 1.7
    @AppStorage("drinkPerAmount") private var drinkPerAmount : Int = 100
    @State private var HintDrinkEnough : String = ""
    @AppStorage("currentWeightUnit") private var currentWeightUnit: String = "kg"
    @State var addCalories: Double = 0.0
    
    @AppStorage("userAge") private var userAge: Int = 20
    @AppStorage("userGender") private var userGender: Int = 0
    @AppStorage("dietAmount") private var dietAmount : Int = 0
    @AppStorage("drinkAmount") private var drinkAmount : Int = 0
    @State var isShowingDietAdd : Bool = false
    var body: some View {
        TabView(selection: $currentPage) {
            TabView(selection: $currentPlace_drink){
                WatchOSDrinkPage()
                    .tag(1)
                Text("page down1")
                    .tag(2)
            }.tag(1)
                .tabViewStyle(.verticalPage)
            TabView(selection: $currentPlace_diet){
                WatchOSDietPage()
                    .tag(1)
                Text("page down2")
                    .tag(2)
            }.tag(2)
                .tabViewStyle(.verticalPage)
//            TabView(selection: $currentPlace_test){
//                TextField("0.0", value: $addCalories, format: .number)
//                    .tag(1)
//                Text("page down3")
//                    .tag(2)
//            }.tag(3)
//                .tabViewStyle(.verticalPage)
//            TabView(selection: $currentPlace){
//                WatchOSDrinkPage()
//                    .tag(1)
//                Text("page down")
//                    .tag(2)
//            }.tag(3)
//            TabView(selection: $currentPlace){
//                WatchOSDrinkPage()
//                    .tag(1)
//                Text("page down")
//                    .tag(2)
//            }.tag(4)
        }
        .focusable(true) // 接受焦点以便于数字表冠事件
        .navigationTitle("DDay")
    }
    
    func WatchOSDrinkPage() -> some View {
        NavigationView{
            VStack{
                Button(action: {
                    //                    drinkAmount += drinkPerAmount
                    //                    if drinkAmount >= getRecommendedDrinkAmount(weight: weight, currentWeightUnit: currentWeightUnit) {
                    //                        HintDrinkEnough = "✅"
                    //                        // removeNotification()
                    //
                }
                ) {
                    if drinkAmount < getRecommendedDrinkAmount(weight: weight, currentWeightUnit: currentWeightUnit) { Image(systemName: "drop")
                            .imageScale(.large)
                    } else{
                        Image(systemName: "drop.fill")
                            .imageScale(.large)
                    }
                }
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .padding()
                .simultaneousGesture(TapGesture().onEnded { _ in
                    drinkAmount += drinkPerAmount
                    if drinkAmount >= getRecommendedDrinkAmount(weight: weight, currentWeightUnit: currentWeightUnit) {
                        HintDrinkEnough = "✅"
                        // removeNotification()
                    }
                })
                .simultaneousGesture(LongPressGesture(minimumDuration: 0.5).onEnded { _ in
                    if drinkAmount >= drinkPerAmount{
                        drinkAmount -= drinkPerAmount
                    }
                })
                Text("\(drinkAmount) ml / \(getRecommendedDrinkAmount(weight: weight, currentWeightUnit: currentWeightUnit)) ml")
                    .font(.title3)
            }.navigationTitle("饮水")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func WatchOSDietAddView() -> some View{
                HStack{
                    TextField("0.0 kCal", value: $addCalories, format: .number)
                        .onSubmit {
                            dietAmount += Int(addCalories)
                            addCalories = 0.0
                        }
                    Text("kCal")
                }
                .navigationTitle("记一笔热量")
                .navigationBarTitleDisplayMode(.inline)
    }
    
    func WatchOSDietPage() -> some View {
        return NavigationView{
            VStack{
//                NavigationLink(destination: WatchOSDietAddView(), isActive: $isShowingDietAdd) {
//                    EmptyView()
//                }.hidden()
                NavigationLink(destination: WatchOSDietAddView){
                    if dietAmount < Int(getRecommendedDietAmount(weight: weight, height: height, userGender: userGender, userAge: userAge, currentWeightUnit: currentWeightUnit)) {
                        Image(systemName: "flame")
                    }
                    else {
                        Image(systemName: "flame.fill")
                    }
                }
                .clipShape(Circle())
                    .padding()
                    
                Text("\(dietAmount) kCal / \(Int(getRecommendedDietAmount(weight: weight, height: height, userGender: userGender, userAge: userAge, currentWeightUnit: currentWeightUnit))) kCal")
                    .font(.title3)
            }.navigationTitle("进食")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
