//
//  ZeroView.swift
//  UI
//
//  Created by Sanjeev Bharti on 11/2/23.
//

import SwiftUI

struct FirstView: View {
    
    @State private var buttonState: ContentState = .rest
    @State private var buttonState1: ContentState = .rest

    var body: some View {
        VStack {
            
            VStack(spacing: 50) {
                
                Text("State: \(buttonState.name)")
                    .fontDesign(.rounded)
                    .fontWeight(.heavy)
                    .animation(.smooth)
                
                CustomButtonView(action: {
                    
                    // Test API call
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 2.5 ... 4.0), execute: DispatchWorkItem(block: {
                        buttonState = .success
                    }))
                    
                }, state: $buttonState, textColor: .white)
                
            }
            
            Divider()
                .padding(50)
            
            VStack(spacing: 50) {
                
                Text("State: \(buttonState1.name)")
                    .fontDesign(.rounded)
                    .fontWeight(.heavy)
                
                CustomButtonView(action: {
                    
                    // Test API call
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 2.5 ... 4.0), execute: DispatchWorkItem(block: {
                        buttonState1 = .fail
                    }))
                }, state: $buttonState1, textColor: .white)
                
            }
        }
        .padding()
        
    }
}

#Preview {
    FirstView()
}
