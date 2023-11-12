//
//  Model.swift
//  DDay
//
//  Created by Fenn on 2023/11/10.
//

import Foundation
import SwiftUI
import SwiftData


class NoteItem: ObservableObject, Identifiable {
    var id = UUID()
    @Published var writeTime: String = ""
    @Published var title: String = ""
    @Published var content: String = ""
    
    // 实例化
    init(writeTime: String, title: String, content: String) {
        self.writeTime = writeTime
        self.title = title
        self.content = content
    }
}


class User : ObservableObject, Identifiable {
    var id = UUID()
    @Published var name : String = "defaultUser"
    @Published var weight : Double = 50.0
    @Published var height : Double = 1.7
    @Published var currentWeightUnit : String = "kg"
    @Published var bmi : Double = 0.0
    
    init(name: String, weight: Double, height: Double, currentWeightUnit: String, bmi: Double){
        self.name = name
        self.weight = weight
        self.height = height
        self.currentWeightUnit = currentWeightUnit
        self.bmi = getBMI()
    }
    
    func getProperWeight() -> String {
        return "\(weight) \(currentWeightUnit)"
    }
    
    func getBMI() -> Double {
        if currentWeightUnit == "kg" {
            return self.weight / self.height / self.height
        } else {
            return self.weight / 2 / self.height / self.height
        }
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


class Drink {
    @Published var amount : Int = 0
    @Published var perAmount : Int = 0
    
    init(amount : Int, perAmount: Int){
        self.amount = amount
        self.perAmount = perAmount
    }
    
    func getRecommendedDrinkAmount(weight: Double, currentWeightUnit : String) -> Int {
        if currentWeightUnit == "kg" {
            return Int(weight / 32 * 1000)
        } else {
            return Int(weight / 2 / 32 * 1000)
        }
    }
}
