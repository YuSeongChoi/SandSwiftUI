//
//  EncodedModelIerator.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/26.
//

import Foundation
import Combine

final class EncodedModelIterator {
    private let subject = PassthroughSubject<Data, Error>()
    private var intIterator = (1...).makeIterator()
    private var cancel: (() -> Void)?
    
    var publisher: AnyPublisher<Data, Error> {
        subject.eraseToAnyPublisher()
    }
    
    func resume() {
        cancel = Timer.publish(every: 2 / 3, on: .main, in: .default)
            .autoconnect()
            .sink { [unowned self] _ in
                _ = next()
            }
            .cancel
    }
    
    func stop() {
        cancel?()
    }
}

extension EncodedModelIterator: IteratorProtocol {
    func next() -> Data? {
        do {
            guard let data = (try intIterator.next().map {
                try JSONEncoder().encode(AsyncModel(int: $0))
            }) else {
                return nil
            }
            
            subject.send(data)
            return data
        } catch {
            subject.send(completion: .failure(error))
            return nil
        }
    }
}
