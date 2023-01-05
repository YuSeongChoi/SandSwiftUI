//
//  PageMoveView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/11.
//

import SwiftUI

struct PageMoveView: View {
    
    private let imageName: String = "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FlI00H%2FbtqXQ6wtwVP%2FUrgHPkbHKxeqWwHIYzoaK1%2Fimg.png"
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: imageName), transaction: Transaction(animation: .spring(response: 0.7, dampingFraction: 0.5, blendDuration: 0.3))) { phase in
                switch phase {
                case .success(let image):
                    image.ImageModifier()
                        .transition(.move(edge: .bottom))
                case .failure(_):
                    Image(systemName: "exclamationmark.icloud.fill")
                        .IconModifier()
                case .empty:
                    Image(systemName: "photo.circle.fill")
                        .IconModifier()
                @unknown default:
                    ProgressView()
                }
            }
            .padding(30)
        }
    }
}

extension Image {
    func ImageModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    
    func IconModifier() -> some View {
        self
            .ImageModifier()
            .frame(maxWidth: 200)
            .foregroundColor(.blue.opacity(0.6))
    }
}

struct PageMoveView_Previews: PreviewProvider {
    static var previews: some View {
        PageMoveView()
    }
}
