//
//  BackButton.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 10/10/25.
//

import SwiftUI

struct BackButton: View {
    var onTap: (() -> Void)
    
    var body: some View {
        Button(action: {
            onTap()
        }, label: {
            Image(systemName: "arrow.backward")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .padding(4)
                .foregroundStyle(.white)
        })
    }
}

#Preview {
    BackButton(onTap: {
        
    })
}
