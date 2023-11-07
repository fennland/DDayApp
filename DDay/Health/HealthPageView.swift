//
//  HealthPageView.swift
//  DDay
//
//  Created by Fenn on 2023/11/7.
//

import SwiftUI

struct HealthPageView : View {
    @State private var drinkAmount : Int = 0
    @State private var drinkPerAmount_str : String = "100"
    @State private var isExpandedDrink = false
    @State private var isEditingDrink = false
    
    @State private var calorieAmount : Int = 0
    @State private var isExpandedDiet = false
    var body: some View{
        NavigationView {
            List {
                Section(header: Text("饮水")) {
                    HStack{
                        Text("饮水量")
                        Spacer()
                        Text("\(drinkAmount)" + " ml")
                    }
                    HStack{
                        Text("我喝水了！")
                        Spacer()
                        if isEditingDrink {
                            TextField("单位饮水量", text: $drinkPerAmount_str, onCommit: {
                                // Save the input and change back to button
                                isEditingDrink = false
                            })
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.trailing)
                        } else {
                            Button(action: {
                                // drinkAmount += Int(drinkPerAmount_str) ?? 0
                                print(drinkAmount)
                            }) {
                                Text("\(drinkPerAmount_str) ml")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .simultaneousGesture(LongPressGesture(minimumDuration: 0.5).onEnded { _ in
                                // Change to text field on long press
                                isEditingDrink = true
                            })
                            .simultaneousGesture(TapGesture().onEnded{
                                drinkAmount += Int(drinkPerAmount_str) ?? 0
                            })
                        }
                    }
                    
                    DisclosureGroup("饮水设置", isExpanded: $isExpandedDrink) {
                        NavigationLink(destination: Text("TODO")) {
                            Text("饮水历史")
                        }
                        Button(action: {
                            drinkAmount = 0
                        }, label: {
                            Text("清除计量")
                        })
                        // 添加更多子项
                    }
                }
                
                Section(header: Text("进食")) {
                    HStack{
                        Text("摄入卡路里")
                        Spacer()
                        Text("\(calorieAmount)" + " kCal")
                    }
                    NavigationLink(destination: Text("TODO")) {
                        Text("记一笔")
                    }
                    DisclosureGroup("进食设置", isExpanded: $isExpandedDiet) {
                        Text("Subitem 1")
                        Text("Subitem 2")
                        // 添加更多子项
                    }
                }
                
                
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle(Text("健康"))
        }
    }
}

#Preview {
    HealthPageView()
}
