//
//  TimerView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/09/13.
//

import SwiftUI
import Combine

@MainActor
final class TimerViewModel: ObservableObject, Identifiable {
    @Published var count: Int = 0
    var cancelBag = Set<AnyCancellable>()
    
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    @Published var showButton: Bool = false
    
    init() {
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    private func setUpTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.count += 1
            }
            .store(in: &cancelBag)
    }
    
    private func addTextFieldSubscriber() {
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { (text) -> Bool in
                if text.count > 3 {
                    return true
                }
                return false
            }
            .sink(receiveValue: { [weak self] (isValid) in
                self?.textIsValid = isValid
            })
            .store(in: &cancelBag)
    }
    
    private func addButtonSubscriber() {
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] (isValid, count) in
                guard let self = self else { return }
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancelBag)
    }
}

struct TimerView: View {
    @StateObject private var viewModel = TimerViewModel()
    
    var body: some View {
        VStack {
            Text("\(viewModel.count)")
                .font(.largeTitle)
            
            TextField("Type something here...", text: $viewModel.textFieldText)
                .padding(.leading)
                .frame(height: 55)
                .font(.headline)
                .background(Color(red: 226/255, green: 226/255, blue: 226/255))
                .cornerRadius(10)
                .overlay(
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .opacity(
                                viewModel.textFieldText.count < 1 ? 0 :
                                    viewModel.textIsValid ? 0 : 1
                            )
                        
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .opacity(viewModel.textIsValid ? 1 : 0)
                    }
                    .font(.title)
                    .padding(.trailing), alignment: .trailing)
            
            Button {
                
            } label: {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(10)
                    .opacity(viewModel.showButton ? 1 : 0.5)
            }.disabled(!viewModel.showButton)

        }
        .padding()
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
