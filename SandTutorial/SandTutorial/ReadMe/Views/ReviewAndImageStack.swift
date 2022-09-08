//
//  ReviewAndImageStack.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/25.
//

import class PhotosUI.PHPickerViewController
import SwiftUI

struct ReviewAndImageStack: View {
    @ObservedObject var book: Book
    @Binding var image: Image?
    @State private var showingImagePicker = false
    @State private var showingDialog = false
    
    var body: some View {
        VStack {
            Divider()
                .padding(.vertical)
            TextField("Review...", text: $book.microReview)
            Divider()
                .padding(.vertical)
            
            Book.Image(image: image, title: book.title, cornerRadius: 16)
                .scaledToFit()
            
            HStack {
                if image != nil {
                    Spacer()
                    Button {
                        showingDialog = true
                    } label: {
                        Text("Delete Image")
                    }
                }
                    Spacer()
                    Button {
                        showingImagePicker = true
                    } label: {
                        Text("Update Image...")
                    }
                    Spacer()
            }
            .padding()
            Spacer()
        }
        .sheet(isPresented: $showingImagePicker) {
            PHPickerViewController.View(image: $image)
        }
        .confirmationDialog("Delete image for \(book.title)?", isPresented: $showingDialog) {
            Button("Delete", role: .destructive) { image = nil }
        } message: {
            Text("Delete image for \(book.title)")
        }
    }
}
