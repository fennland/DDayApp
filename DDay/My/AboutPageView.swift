//
//  AboutPageView.swift
//  DDay
//
//  Created by Fenn on 2023/11/7.
//

import SwiftUI

struct AboutPageView: View {
    var body: some View {
        VStack{
            Text(Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "DDay")
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding()
            Text("v\(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "0.0.0")(\(Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "0"))")
            Spacer()
        }
    }
}

#Preview {
    AboutPageView()
}
