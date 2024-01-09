//
//  HomeDiaryEditorView.swift
//  DDay
//
//  Created by Fenn on 2023/11/7.
//

import SwiftUI

struct HomeDiaryEditorView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var title: String = ""
    @State var date: String = "1970.01.01"
    @State var isEditing = false
    @State var content: String = ""
    @Binding var noteItems: [NoteItem]
    var body: some View {
        VStack{
            Spacer()
            titleView()
            Divider()
            contentView()
        }
        .navigationBarTitle((title == "") ? "新的手记" : "", displayMode: .inline)
        .navigationBarItems(trailing: saveBtnView())
    }
    
    // MARK: saveBtn
    
    func saveBtnView() -> some View {
        Button("保存") {
            presentationMode.wrappedValue.dismiss()
            // TODO: 保存内容
        }
    }
    
    // MARK: 标题输入框
    
    func titleView() -> some View {
        HStack{
            TextField("标题...", text: $title, onEditingChanged: { editingChanged in
                self.isEditing = editingChanged
            })
            .fontWeight(.bold)
            .font(.title2)
            .padding()
            Spacer()
            Text(date)
                .font(.caption)
                .foregroundColor(.gray)
                .frame(alignment: .trailing)
                .padding()
            
        }
    }
    
    // MARK: 内容输入框
    
    func contentView() -> some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $content)
                .font(.system(size: 17))
                .padding()
            if content.isEmpty {
                Text("灵光一闪的内容...")
                    .foregroundColor(Color(UIColor.placeholderText))
                    .padding(20)
            }
        }
    }
}



#Preview {
    HomeDiaryEditorView(noteItems: .constant([]))
}
