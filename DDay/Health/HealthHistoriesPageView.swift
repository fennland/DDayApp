//
//  HealthHistoriesPageView.swift
//  DDay
//
//  Created by Fenn on 2023/11/10.
//

import SwiftUI

struct HealthHistoriesPageView: View {
    @State private var records: [String] = []
    @Binding var showType : Int
    @State private var showTypeHint : [String] = ["", "饮水历史", "进食历史"]
    @State private var showNothing : Bool = false
    
    var body: some View {
        if !showNothing{
            List {
                ForEach(records, id: \.self) { record in
                    parseRecord(record, type: showType)
                }
            }
            .onAppear {
                loadRecords()
            }
            .listStyle(.inset)
            .navigationBarTitle(showTypeHint[showType], displayMode: .inline)
        }
        else {
            VStack {
                Image (systemName: "info.circle").padding()
                Text("这里空空如也")
                    .font(.footnote)
            }
        }
    }
    
    func loadRecords() {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent("record.txt")
            do {
                let contents = try String(contentsOf: fileURL)
                let recordArray = contents.components(separatedBy: "\n")
                records = recordArray.filter { !$0.isEmpty }
            } catch {
                print("Error reading file: \(error)")
                self.showNothing.toggle()
            }
        }
    }
    
    @ViewBuilder
    func parseRecord(_ record: String, type: Int) -> some View {
        let components = record.components(separatedBy: ",")
        if components.count >= 2 {
            let date = components[0]
            let variable = components[type]
            HStack {
                Text("\(date)")
                Spacer()
                Text("\(variable)")
            }
        } else {
            EmptyView()
        }
    }
}

#Preview {
    HealthHistoriesPageView(showType: .constant(1))
}
