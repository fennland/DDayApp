//
//  Data.swift
//  DDay
//
//  Created by Fenn on 2023/11/12.
//

import Foundation
import SwiftUI


func getProperWeight(weight: Double, currentWeightUnit: String) -> String {
    return "\(weight) \(currentWeightUnit)"
}

func getBMI(weight: Double, height: Double, currentWeightUnit: String) -> Double {
    if currentWeightUnit == "kg" {
        return weight / height / height
    } else {
        return weight / 2 / height / height
    }
//    return String(format: "%.2f", bmi) + "%"
}

func getBMILevel(bmi: Double) -> String {
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

func getRecommendedDrinkAmount(weight: Double, currentWeightUnit: String) -> Int {
    if currentWeightUnit == "kg" {
        return Int(weight / 32 * 1000)
    } else {
        return Int(weight / 2 / 32 * 1000)
    }
}

func getRecommendedDietAmount(weight: Double, height: Double, userGender: Int, userAge: Int, currentWeightUnit: String, caloriesBurning: Double) -> Double {
    var result: Double
    
    if currentWeightUnit == "kg"{
        switch (userGender){
        case 0:
            let sum1 = Double(655)
            let sum2 = 9.6 * weight
            let sum3 = 1.8*Double(height)*100
            let sum4 = 4.7*Double(userAge)
            result = (sum1 + sum2 + sum3 - sum4) * caloriesBurning
            break
        case 1:
            let sum1 = Double(66)
            let sum2 = 13.7*weight
            let sum3 = 5*height*100
            let sum4 = 6.8*Double(userAge)
            result = (sum1 + sum2 + sum3 - sum4) * caloriesBurning
            break
        default:
            let sum1 = Double(66)
            let sum2 = 13.7*weight
            let sum3 = 5*height*100
            let sum4 = 6.8*Double(userAge)
            result = (sum1 + sum2 + sum3 - sum4) * caloriesBurning
            break
        }
    } else {
        switch (userGender){
        case 0:
            let sum1 = Double(655)
            let sum2 = 9.6 * weight / 2
            let sum3 = 1.8*Double(height)*100
            let sum4 = 4.7*Double(userAge)
            result = (sum1 + sum2 + sum3 - sum4) * caloriesBurning
            break
        case 1:
            let sum1 = Double(66)
            let sum2 = 13.7*weight / 2
            let sum3 = 5*height*100
            let sum4 = 6.8*Double(userAge)
            result = (sum1 + sum2 + sum3 - sum4) * caloriesBurning
            break
        default:
            let sum1 = Double(66)
            let sum2 = 13.7*weight / 2
            let sum3 = 5*height*100
            let sum4 = 6.8*Double(userAge)
            result = (sum1 + sum2 + sum3 - sum4) * caloriesBurning
            break
        }
    }
    return result
}
