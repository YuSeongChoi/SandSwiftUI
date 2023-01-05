//
//  LimitTextEditorView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/09/13.
//

import SwiftUI

struct LimitTextEditorView: View {
    @State private var description: String = ""
    @State private var placeholderText: String = "입력해 주세요."
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("1. 본인의 장점을 설명하시오. (500자)")
            ZStack(alignment: .leading) {
                if description.isEmpty {
                    TextEditor(text: $placeholderText)
                        .foregroundColor(.gray)
                        .disabled(true)
                }
                TextEditor(text: $description)
                    .opacity(self.description.isEmpty ? 0.25 : 1)
                    .lineSpacing(5)
                    .frame(maxWidth: .infinity, minHeight: 300)
                    .onChange(of: description) { desc in
                        if desc.count > 500 {
                            DispatchQueue.main.async {
                                self.description = String(desc.prefix(500))
                            }
                        }
                    }
                    .overlay(
                        Text("\(description.count)/500")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                            .padding(), alignment: .bottomTrailing
                    )
            }
        }
        .padding(EdgeInsets(top: 30, leading: 22, bottom: 30, trailing: 22))
        .background(Color(red: 220/255, green: 220/255, blue: 220/255))
    }
}

struct LimitTextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        LimitTextEditorView()
    }
}
