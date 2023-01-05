//
//  ContentView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 15) {
                    Group {
                        HStack {
                            NavigationLink("Alba View") {
                                AlbaView()
                            }
                            NavigationLink("BulleyeView") {
                                BulleyeView()
                            }
                            NavigationLink("ReadMeView") {
                                ReadMeView()
                            }
                        }
                        HStack {
                            NavigationLink("MovieList") {
                                MovieList()
                            }
                            NavigationLink("SavanaTours") {
                                SavanaToursView()
                            }
                            NavigationLink("SpinnerView") {
                                SpinnerView()
                            }
                        }
                        HStack {
                            NavigationLink("NavigationMapView") {
                                InterestingPlacesView(places: MapDiretory().places)
                            }
                            NavigationLink("Asyquembine") {
                                Asyquembine()
                            }
                            NavigationLink("Buzzy") {
                                BuzzyView()
                            }
                        }
                        HStack {
                            NavigationLink("Draggable Map") {
                                DraggableMap()
                            }
                            NavigationLink("Chef Secrets") {
                                ChefSecretsView()
                            }
                            NavigationLink("My Tab View") {
                                MyTabView()
                            }
                        }
                        HStack {
                            NavigationLink("Taxi Map") {
                                TaxiView()
                            }
                            NavigationLink("Limit TextEditor") {
                                LimitTextEditorView()
                            }
                            NavigationLink("Gradient View") {
                                GradientView(store: .constant(.defaultStore))
                            }
                        }
                    }
                    Group {
                        HStack {
                            NavigationLink("Fruta") {
                                FrutaView()
                            }
                            NavigationLink("Pie") {
                                PieChart(title: "2022 Worlds", data: chartDataSet, separatorColor: Color(UIColor.systemBackground), accentColors: pieColors)
                            }
                            NavigationLink("Animation") {
                                AnimationView()
                            }
                            NavigationLink("Async Image") {
                                PageMoveView()
                            }
                            NavigationLink("Thread View") {
                                ThreadView()
                            }
                        }
                        HStack {
                            NavigationLink("Escaping View") {
                                EscapingView()
                            }
                            NavigationLink("Combine View") {
                                CombineView()
                            }
                        }
                        HStack {
                            NavigationLink("Animate1") {
                                HighAnimationView()
                            }
                            NavigationLink("Animate2") {
                                HighAnimationView2()
                            }
                            NavigationLink("Geometry1") {
                                GeometryView()
                            }
                            NavigationLink("Geometry2") {
                                GeometryView2()
                            }
                        }
                        HStack {
                            NavigationLink("Hero1") {
                                HeroAnimationView(itemArray: mealData)
                            }
                            NavigationLink("Hero2") {
                                Wildlife()
                            }
                            NavigationLink("Steam") {
                                SteamView()
                            }
                        }
                        HStack {
                            NavigationLink("Path") {
                                PathMenu()
                            }
                            NavigationLink("Swipe") {
                                SwipeView()
                            }
                            NavigationLink("Material") {
                                MaterialView()
                            }
                            NavigationLink("Glow") {
                                GlowView()
                            }
                            NavigationLink("Vibrancy") {
                                VibrancyView()
                            }
                        }
                    }
                    Group {
                        HStack {
                            NavigationLink("NaviDemo") {
                                NaviDemoView()
                            }
                            NavigationLink("Sudoku") {
                                SudokuView()
                            }
                            NavigationLink("SlidingTab") {
                                SlidingTabProgressiveSelectionView()
                                SlidingTabSelectionView()
                            }
                            NavigationLink("ScrollTab") {
                                SlidingTabConsumerView()
                            }
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(.stack)
        }
    }
}

//import AsyncAlgorithms
//
//func asdfsdf() async throws {
//    let task = URLSession.shared.dataTask(with: .init(url: FileManager.default.temporaryDirectory))
//    let urls = [URL]()
//    let c = urls.async.map{ url in
//        if let _ = try? await Task.sleep(nanoseconds: 1000000) {
//            return 0
//        } else {
//            return 1
//        }
//    }
//    let task23 = Task {
//        for await i in c {
//            print(i)
//        }
//    }
//    task23.cancel()
//    (0..<100).publisher.map{
//        if $0 < 10 {
//            return 0
//        } else {
//            return 1
//        }
//    }.setFailureType(to: Error.self)
//    Task{
//
//    }
//
//    let provider: () -> (Task<(URL,URLResponse),Error>, URLSessionDownloadTask) = {
//        let semaphore = DispatchSemaphore(value: 0)
//        var taskHolder:URLSessionDownloadTask? = nil
//        let task1 = Task<(URL,URLResponse),Error> {
//            try await withCheckedThrowingContinuation { continuation in
//                let task = URLSession.shared.downloadTask(with: .init(url: FileManager.default.temporaryDirectory)) { url, response, error in
//                    guard let url, let response else {
//                        continuation.resume(throwing: error ?? URLError(.badServerResponse))
//                        return
//                    }
//                    do {
//                        let newURL = try FileManager.default.url(for: .itemReplacementDirectory, in: .userDomainMask, appropriateFor: url, create: true)
//                        try FileManager.default.moveItem(at: url, to: newURL)
//                        continuation.resume(returning: (newURL, response))
//                    } catch {
//                        continuation.resume(throwing: error)
//                    }
//                    continuation.resume(returning: (url, response))
//                }
//                taskHolder = task
//                semaphore.signal()
//            }
//        }
//        semaphore.wait()
//        return (task1, taskHolder.unsafelyUnwrapped)
//    }
//    let (localTask, urlTask) = provider()
//    urlTask.resume()
//    if Task.isCancelled {
//        urlTask.cancel()
//    }
//    let (url,response) = try await withTaskCancellationHandler {
//        urlTask.cancel()
//        localTask.cancel()
//    } operation: {
//        try await localTask.value
//    }
//
//}
