//
//  ButtonUI.swift
//  UI
//
//  Created by Sanjeev Bharti on 10/31/23.
//

import SwiftUI
import Combine

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
    
    var title: String {
        switch self {
        case .rest: return "Submit"
        case .loading: return ""
        case .success: return "✔️"
        case .fail: return "Ｘ"
        }
    }
    
}



////--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
///------------------------------------------------------------------------------------------------
///----------------------------------------------------------------------------------------
///

struct FancyButtonView: View {

    // It will be @Binding property
    @Binding var state: ContentState
    
    // Might not need this property
    private var width: CGFloat
    
    // Rename this property
    private var height: CGFloat
    
    private var cornerRadius: CGFloat
    private var borderLineWidth: CGFloat
    private var borderLineColor: Color
    private var fillColor: Color
    private var progressBarColor: Color
    private var animation: Animation
    
    @State private var shakeButton = false
    @State var attempts: Int = 0

    @State private var scaleButton = false
    
    @State var scale = 1.0
    @State var offset = 0.0
        
    init(state: Binding<ContentState>, width: CGFloat = .infinity, height: CGFloat = 50.0, cornerRadius: CGFloat = 10.0, borderLineWidth: CGFloat = 2.0, borderLineColor: Color = .blue, fillColor: Color = .blue, progressBarColor: Color = .white, animation: Animation = .smooth) {
        _state = state
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
        self.borderLineWidth = borderLineWidth
        self.borderLineColor = borderLineColor
        self.fillColor = fillColor
        self.progressBarColor = progressBarColor
        self.animation = animation
    }
    
    var testPublisher: AnyPublisher<ContentState, Never> {
        return Just(_state.wrappedValue).eraseToAnyPublisher()
    }
    
    var body: some View {
        
        ZStack {
            buttonView
                .modifier(Shake(animatableData: CGFloat(state == .fail ? 0 : 1)))
                .scaleEffect(scale, anchor: .top)
                .offset(y: offset)
            
            progressView.opacity(state == .loading ? 1.0 : 0.0)
                .allowsHitTesting(false) // Pass touches to ButtonView
        }
        .animation(animation, value: state)

        .onReceive(testPublisher, perform: { currentState in
            print("my state: ", currentState)
            if state == .fail {
                moveToRest()
            } else if state == .success {
                moveOutOfScreen()
            }
        })
     
    }
    
    private var buttonView: some View {
        Button(action: {
            if state == .rest {
                state = .loading
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
    
    private func moveToRest() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: DispatchWorkItem(block: {
            state = .rest
        }))
    }
    
    private func moveOutOfScreen() {
        
        withAnimation(.bouncy(duration: 0.3)) {
            scale = 1.5
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                withAnimation(.bouncy(duration: 0.2)) {
//                    offset = UIScreen.main.bounds.size.height
                    state = .rest
                    scale = 1.0
                    
                }
            }
        }
    }
}

//#Preview {
//    
//    VStack(spacing: 100) {
//        FancyButtonView(state: .constant(.rest))
//    }
//        .padding()
//}


struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat = 1.0
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}
