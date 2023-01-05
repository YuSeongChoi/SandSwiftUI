//
//  CombineView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/12.
//

import SwiftUI
// 7-2
import Combine

/**
 - Combine을 쉽게 이해하기 위한 예시
 
 */

class DownloadWithCombineViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    // 7-3
    var cancelBag = Set<AnyCancellable>()
    
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // Combine Framework
        // https://developer.apple.com/documentation/combine/
        
        // Combine 해설:
        /*
         1. 어떠한 패키지에 대한 매월 정기구독을 가입함
         2. 회사는 패키지를 공장에서 생산함
         3. 패키지를 배송하고 고객은 상품을 전달받음
         4. 사용자는 패키지의 상태가 손상되었는지 확인함
         5. 상자를 열고 항목이 올바른지 확인함
         6. 항목을 사용함!!
         7. 위 구독은 언제든지 취소가 가능함
         */
        
        // 1. Publisher 생성 (dataTaskPublisher)
        URLSession.shared.dataTaskPublisher(for: url)
        // 2. subscribe publisher를 background Thread로 옮겨줌
        // (실제로 dataTask는 background Thread에서 작업되지만 가끔 publisher가 명시적으로 background에 있지 않으므로 이 라인을 호출함
            .subscribe(on: DispatchQueue.global(qos: .background))
        // 3. Main Thread에서 수신함
            .receive(on: DispatchQueue.main)
        // 4. tryMap (data가 있는지 없는지 상태가 좋은지 확인)
        // tryMap은 실패하고 오류를 발생시킬 수 있는 지도입니다.
            .tryMap(handleOutput)
//            .tryMap { data, response -> Data in
//                guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
//                    throw URLError(.badServerResponse)
//                }
//                return data
//            }
        // 5. decode (데이터를 PostModel로 디코딩)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
        // 6. sink(항목을 앱에 추가한다)
            .sink { completion in
                print("Completion: \(completion)")
            } receiveValue: { [weak self] returnedPosts in
                self?.posts = returnedPosts
            }
        // 7-1. store (필요한경우 구독을 취소함)
            .store(in: &cancelBag)
    }
    
    // 8. 만약 호출에 성공하지 못했다는 가정하에 몇가지 로직을 넣음
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
}

struct CombineView: View {
    
    @StateObject private var vm = DownloadWithCombineViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.posts) { post in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(post.title)
                            .font(Font.title.bold())
                        Text(post.body)
                            .foregroundColor(Color(UIColor.systemGray2))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
            }
            .navigationBarTitle("Faker JSON Data")
            .listStyle(.plain)
        }
    }
    
}

struct CombineView_Previews: PreviewProvider {
    static var previews: some View {
        CombineView()
    }
}
