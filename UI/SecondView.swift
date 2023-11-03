//
//  SecondView.swift
//  UI
//
//  Created by Sanjeev Bharti on 11/2/23.
//

import SwiftUI

struct SecondView: View {
    @State private var buttonState: ContentState = .rest
    @State private var buttonState1: ContentState = .rest
    @State private var buttonState2: ContentState = .rest
    @State private var buttonState3: ContentState = .rest
    
    var body: some View {
        
        ZStack {
            
            HeaderView(title: "Mixed Variants\nof FancyButton")
            
            VStack(spacing: 50) {
                CustomButtonView(action: {
                    
                    // Test API call
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 1.5 ... 5.5), execute: DispatchWorkItem(block: {
                        buttonState = .fail
                    }))
                    
                }, state: $buttonState, fillColor: .clear)
                
                CustomButtonView(action: {
                    
                    // Test API call
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 1.5 ... 5.5), execute: DispatchWorkItem(block: {
                        buttonState1 = .success
                    }))
                }, state: $buttonState1, textColor: .white, fillColor: .black)
                
                CustomButtonView(action: {
                    // Test API call
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 1.5 ... 5.5), execute: DispatchWorkItem(block: {
                        buttonState2 = .fail
                    }))
                }, state: $buttonState2, height: 70.0, textColor: .white, progressBarColor: .blue)
                
                CustomButtonView(action: {
                    
                    // Test API call
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 1.5 ... 5.5), execute: DispatchWorkItem(block: {
                        buttonState3 = .success
                    }))
                }, state: $buttonState3, height: 120.0, textColor: .white, borderLineColor: .clear, fillColor: .blue, progressBarColor: .teal)
                
            }
            .padding()
        }
    }
}

#Preview {
    SecondView()
}
