//
//  FailureView.swift
//  UI
//
//  Created by Sanjeev Bharti on 11/2/23.
//

import SwiftUI

struct FailureView: View {
    
    @State private var buttonState: ContentState = .rest
    @State private var showFailurePage = false
    
    var body: some View {
        
        ZStack {
            
            HeaderView(title: "Failure Demo")
            if showFailurePage {
                LottieView(name: "robot")
                    .opacity(showFailurePage ? 1.0 : 0.0)
            }
            
            VStack {
                Spacer()
                CustomButtonView(action: {
                    showFailurePage = false
                    // Test API call
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.5 ... 1.5), execute: DispatchWorkItem(block: {
                        buttonState = .fail
                    }))
                    
                }, state: $buttonState, fillColor: .clear) {
                    showFailurePage = true
                }
            }
            .padding(.bottom, 15)
        }
        .padding()
    }
}

#Preview {
    FailureView()
}
