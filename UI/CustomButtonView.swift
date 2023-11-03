//
//  CustomButtonView.swift
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
    
    var name: String {
        switch self {
        case .rest: return "Initial"
        case .loading: return "Loading"
        case .success: return "Success"
        case .fail: return "Failure"
        }
    }
    
    var color: Color {
        switch self {
        case .rest: return .clear
        case .loading: return .teal
        case .success: return .clear
        case .fail: return .clear
        }
    }
}

typealias ButtonActionHandler = ()->Void

struct CustomButtonView: View {

    // Button's tap action handler
    let action: ButtonActionHandler
    
    // Button's State information
    @Binding var state: ContentState
    
    // Button's title information
    private var title: String
    
    // Button height information
    private var height: CGFloat
    
    // Button's height information
    private var textColor: Color
    
    // Button's corner radius information
    private var cornerRadius: CGFloat
    
    // Button's border line width information
    private var borderLineWidth: CGFloat
    
    // Button's line color information
    private var borderLineColor: Color
    
    // Button's background information
    private var fillColor: Color
    
    // Progress bar information
    private var progressBarColor: Color
    
    // View information
    private var animation: Animation
    
    // Button's tap action handler
    let completionHandler: ButtonActionHandler?
        
    init(action: @escaping ButtonActionHandler, state: Binding<ContentState>, title: String = "Submit", width: CGFloat = .infinity, height: CGFloat = 50.0, cornerRadius: CGFloat = 10.0, textColor: Color = .primary, borderLineWidth: CGFloat = 2.0, borderLineColor: Color = .teal, fillColor: Color = .teal, progressBarColor: Color = .black, animation: Animation = .smooth, completionHandler: ButtonActionHandler? = nil) {
        self.action = action
        _state = state
        self.title = title
        self.height = height
        self.cornerRadius = cornerRadius
        self.textColor = textColor
        self.borderLineWidth = borderLineWidth
        self.borderLineColor = borderLineColor
        self.fillColor = fillColor
        self.progressBarColor = progressBarColor
        self.animation = animation
        self.completionHandler = completionHandler
    }
    
    var stateChangePublisher: AnyPublisher<ContentState, Never> {
        return Just(_state.wrappedValue).eraseToAnyPublisher()
    }
    
    var body: some View {
        
        ZStack {
            buttonView
            progressView.opacity(state == .loading ? 1.0 : 0.0)
                .allowsHitTesting(false) // Pass touches to ButtonView
        }
        .overlay(content: {
            if state == .fail {
                LottieView(name: "cross1")
                    .scaleEffect(1.5)
            } else if state == .success {
                LottieView(name: "checkmark1")
                    .scaleEffect(1.7)
            } else {
                EmptyView()
            }
        })
        .animation(animation, value: state)
        .onReceive(stateChangePublisher, perform: { currentState in
            if state == .fail || state == .success {
                moveToRest()
            }
        })
    }
    
    private var buttonView: some View {
        Button(action: {
            if state == .rest {
                state = .loading
            }
            action()
        }, label: {
            Text(title)
                .font(state != .rest ? .footnote : .body)
                .opacity(state != .rest ? 0.0 : 1.0)
                .foregroundStyle(textColor)
                .fontWeight(.semibold)
                .frame(maxWidth: state != .rest ? height : .infinity, maxHeight: height, alignment: .center)
                .background(content: {
                    RoundedRectangle(cornerRadius: state != .rest ? height/2 : cornerRadius)
                        .fill(state != .rest ? .clear : fillColor)
                })
                .overlay {
                    RoundedRectangle(cornerRadius: state != .rest ? height/2 : cornerRadius)
                        .stroke(state != .rest ? state.color : borderLineColor, lineWidth: borderLineWidth)
                }
        })
    }
    
    private var progressView: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .tint(progressBarColor)
            .scaleEffect(1.2)
    }
    
    private func moveToRest() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1, execute: DispatchWorkItem(block: {
            state = .rest
            completionHandler?()
        }))
    }
    
}

#Preview {
    
    VStack(spacing: 100) {
        CustomButtonView(action: {
            
        }, state: .constant(.rest))
    }
        .padding()
}
