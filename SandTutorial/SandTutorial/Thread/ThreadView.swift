//
//  ThreadView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/12.
//

import SwiftUI

/**
 Thread의 업그레이드 과정
 1. Main Thread에서 시작
 2. 앱 실행
 3. Background Thread로 이동
 4. 작업을 수행
 5. 수행한 작업을 업데이트하기 전에 Main Thread로 이동
 6. 수행 작업 업데이트
 */

struct ThreadView: View {
    
    @StateObject private var bvm = backgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack (spacing: 10) {
                Text("Background Thread")
                    .font(Font.title2.bold())
                    .onTapGesture {
                        bvm.fetchData()
                    }
                
                ForEach(bvm.dataArray, id: \.self) { data in
                    Text(data)
                        .font(.headline)
                        .foregroundColor(.pink)
                }
            }
        }
    }
    
}

struct ThreadView_Previews: PreviewProvider {
    static var previews: some View {
        ThreadView()
    }
}

class backgroundThreadViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    func fetchData() {
        DispatchQueue.global(qos: .background).async {
            let newData = self.downLoadData()
            print("Thread 확인 1 : \(Thread.isMainThread)")
            print("Thread 확인 1 :  \(Thread.current)")
            DispatchQueue.main.async {
                self.dataArray = newData
                print("Thread 확인 2 : \(Thread.isMainThread)")
                print("Thread 확인 2.  \(Thread.current)")
            }
        }
    }
    
    private func downLoadData() -> [String] {
        var data: [String] = []
        
        for i in 0..<100 {
            data.append("\(i)")
            print(data)
        }
        return data
    }
    
}
