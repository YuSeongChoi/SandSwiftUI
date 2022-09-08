//
//  Asyquembine.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/26.
//

import SwiftUI

struct Asyquembine {
    private let syncIterator = EncodedModelIterator()
    private let asyncSequence = AsyncEncodedModelSequnce()
    
    @State private var publishedModel: AsyncModel?
    @State private var asyncModel: AsyncModel?
}

// MARK: - private
private extension Asyquembine {
    struct IteratorView: View {
        let title: String
        let syncIterator: EncodedModelIterator
        @Binding var model: AsyncModel?
        
        var body: some View {
            VStack(spacing: 12) {
                Text(title)
                    .font(.title)
                    .bold()
                    .foregroundColor(.secondary)
                
                Text("Iteration: \(model.map { String($0.int) } ?? "nil")")
                    .font(.title)
                
                HStack {
                    Button {
                        syncIterator.resume()
                    } label: {
                        Label("Resume", systemImage: "play")
                    }
                    Button {
                        syncIterator.stop()
                    } label: {
                        Label("Stop", systemImage: "stop")
                    }
                    .tint(.red)
                }
                
                Button {
                    _ = syncIterator.next()
                } label: {
                    Label("Iterate", systemImage: "arrow.clockwise")
                }
            }
            .font(.title3)
            .buttonStyle(.bordered)
            .padding()
        }
    }
}

// MARK: - View
extension Asyquembine: View {
    var body: some View {
        VStack {
            IteratorView(title: "Combine", syncIterator: syncIterator, model: $publishedModel)
                .onReceive(
                    syncIterator.publisher
                        .decode(type: AsyncModel.self, decoder: JSONDecoder())
                        .map { $0 }
                        .replaceError(with: nil)
                ) {
                    publishedModel = $0
                }
            
            Divider()
                .padding()
            
            IteratorView(title: "Async", syncIterator: asyncSequence.syncIterator, model: $asyncModel)
                .task {
                    do {
                        for try await model in (
                            asyncSequence
                                .map { try JSONDecoder().decode(AsyncModel.self, from: $0) }
                        ) {
                            asyncModel = model
                        }
                    } catch { }
                }
        }
    }
}
