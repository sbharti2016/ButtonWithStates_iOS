//
//  ThirdView.swift
//  UI
//
//  Created by Sanjeev Bharti on 11/2/23.
//

import SwiftUI

struct ThirdView: View {
    @State private var buttonState: ContentState = .rest
    @State private var buttonState1: ContentState = .rest
    @State private var buttonState2: ContentState = .rest
    @State private var buttonState3: ContentState = .rest
    
    var body: some View {
        
        ZStack {
            
            HeaderView(title: "Mixed Variants\nof FancyButton")

            VStack(spacing: 50) {
                
                HStack {
                    CustomButtonView(action: {
                        
                        // Test API call
                        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 1.5 ... 5.5), execute: DispatchWorkItem(block: {
                            buttonState = .fail
                        }))
                        
                    }, state: $buttonState, fillColor: .clear)
                    
                    Spacer()
                }
                
                CustomButtonView(action: {
                    
                    // Test API call
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 1.5 ... 5.5), execute: DispatchWorkItem(block: {
                        buttonState1 = .success
                    }))
                }, state: $buttonState1, textColor: .white, fillColor: .black)
                
                HStack {
                    Spacer()
                    
                    CustomButtonView(action: {
                        // Test API call
                        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 1.5 ... 5.5), execute: DispatchWorkItem(block: {
                            buttonState2 = .success
                        }))
                    }, state: $buttonState2, height: 70.0, textColor: .white, progressBarColor: .blue)
                    
                }
                
                HStack {
                    CustomButtonView(action: {
                        
                        // Test API call
                        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 1.5 ... 5.5), execute: DispatchWorkItem(block: {
                            buttonState3 = .fail
                        }))
                    }, state: $buttonState3, height: 120.0, textColor: .white, borderLineColor: .clear, fillColor: .teal, progressBarColor: .teal)
                    
                    Spacer()
                }
            }
            .padding()
            .animation(.easeIn(duration: 0.3), value: true)
            
        }
    }
}

#Preview {
    ThirdView()
}
