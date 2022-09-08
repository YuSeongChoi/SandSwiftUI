//
//  AsyncEncodedModelSequence.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/26.
//

import Foundation
import Combine

final class AsyncEncodedModelSequnce {
    let syncIterator = EncodedModelIterator()
    
    private var cancellable = AnyCancellable { }
    private var continuation: CheckedContinuation<Data?, Error>?
    
    init() {
        cancellable = syncIterator.publisher
            .sink(receiveCompletion: { [unowned self] completion in
                switch completion {
                case .finished:
                    continuation?.resume(returning: nil)
                case .failure(let error):
                    continuation?.resume(throwing: error)
                }
            }, receiveValue: { [unowned self] value in
                continuation?.resume(returning: value)
            })
    }
}

// MARK: - AsyncSequence AsyncIteratorProtocol
extension AsyncEncodedModelSequnce: AsyncSequence, AsyncIteratorProtocol {
    typealias Element = Data
    
    func next() async throws -> Data? {
        try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
        }
    }
}

public extension AsyncSequence where AsyncIterator == Self {
    func makeAsyncIterator() -> Self { self }
}
