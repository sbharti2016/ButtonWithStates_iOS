//
//  UIApp.swift
//  UI
//
//  Created by Sanjeev Bharti on 10/31/23.
//

import SwiftUI

@main
struct UIApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                FirstView()
                FailureView()
                SucessView()
                SecondView()
                ThirdView()
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .onAppear {
                UIPageControl.appearance().currentPageIndicatorTintColor = .black
                UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
