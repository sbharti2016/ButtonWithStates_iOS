//
//  ButtonUI.swift
//  UI
//
//  Created by Sanjeev Bharti on 10/31/23.
//

import SwiftUI

enum ContentState {
    case rest
    case loading
    case success
    case fail
    
    var color: Color {
        switch self {
        case .rest: return .clear
        case .loading: return .blue
        case .success: return .green
        case .fail: return .red
        }
    }
    
    var filledImageName: String {
        return ""
    }
    
}

struct FancyButtonView: View {

    private var width: CGFloat
    private var height: CGFloat
    private var cornerRadius: CGFloat
    private var borderLineWidth: CGFloat
    private var borderLineColor: Color
    private var fillColor: Color
    private var progressBarColor: Color
    private var animation: Animation
    
    // It will be @Binding property
    @State private var state: ContentState = .rest
    
    @State private var shakeButton = false
    @State var attempts: Int = 0

    @State private var scaleButton = false
    
    init(width: CGFloat = .infinity, height: CGFloat = 50.0, cornerRadius: CGFloat = 10.0, borderLineWidth: CGFloat = 2.0, borderLineColor: Color = .blue, fillColor: Color = .blue, progressBarColor: Color = .white, animation: Animation = .smooth) {
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
        self.borderLineWidth = borderLineWidth
        self.borderLineColor = borderLineColor
        self.fillColor = fillColor
        self.progressBarColor = progressBarColor
        self.animation = animation
    }
    
    var body: some View {
        
        ZStack {
            buttonView
                .modifier(Shake(animatableData: CGFloat(attempts)))

            progressView.opacity(state == .loading ? 1.0 : 0.0)
                .allowsHitTesting(false) // Pass touches to ButtonView
        }
        .animation(animation, value: state)
    }
    
    private var buttonView: some View {
        Button(action: {
            if state == .rest {
                state = .loading
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: DispatchWorkItem(block: {
                    state = .fail
                    attempts += 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.33, execute: DispatchWorkItem(block: {
                        state = .rest
                    }))
                    
                }))
            } else {
                state = .rest
            }
            
        }, label: {
            Text("Submit")
                .font(state != .rest ? .footnote : .body)
                .opacity(state != .rest ? 0.0 : 1.0)
                .fontWeight(.semibold)
                .frame(maxWidth: state != .rest ? height : width, maxHeight: height, alignment: .center)
                .overlay {
                    RoundedRectangle(cornerRadius: state != .rest ? height/2 : cornerRadius)
                        .stroke(state != .rest ? state.color :.blue, lineWidth: borderLineWidth)
                        .fill(state != .rest ? state.color : .clear)
                }
        })
    }
    
    private var progressView: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .tint(.white)
    }
    
}

#Preview {
    
    VStack(spacing: 100) {
        FancyButtonView()
        FancyButtonView(height: 40)

        FancyButtonView(height: 100)
        FancyButtonView(height: 30)
    }
        .padding()
}


struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat = 1.0
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))

    }
}
