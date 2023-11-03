//
//  HeaderView.swift
//  UI
//
//  Created by Sanjeev Bharti on 11/2/23.
//

import SwiftUI

struct HeaderView: View {
    
    private let title: String
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        VStack {
            Text(title)
                .fontDesign(.rounded)
                .fontWeight(.heavy)
                .animation(.smooth)
            Spacer()
        }
    }
}

#Preview {
    HeaderView(title: "Test Header")
}
