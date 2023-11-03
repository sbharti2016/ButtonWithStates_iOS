//
//  FailureView.swift
//  UI
//
//  Created by Sanjeev Bharti on 11/2/23.
//

import SwiftUI

struct SucessView: View {
    
    @State private var buttonState: ContentState = .rest
    @State private var showSuccessPage = false
    
    var body: some View {
        
        ZStack {
            
            HeaderView(title: "Success Demo")

            if showSuccessPage {
                LottieView(name: "relax")
                    .opacity(showSuccessPage ? 1.0 : 0.0)
            }
            
            VStack {
                Spacer()
                CustomButtonView(action: {
                    showSuccessPage = false
                    // Test API call
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.5 ... 1.5), execute: DispatchWorkItem(block: {
                        buttonState = .success
                    }))
                    
                }, state: $buttonState, fillColor: .clear) {
                    showSuccessPage = true
                }
            }
            .padding(.bottom, 10)
        }
        .padding()
    }
}

#Preview {
    SucessView()
}
