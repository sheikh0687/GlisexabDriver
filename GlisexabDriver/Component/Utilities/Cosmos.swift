//
//  Cosmos.swift
//  Glisexab
//
//  Created by Arbaz  on 09/12/25.
//

import Foundation
import Cosmos
import SwiftUI

struct CosmosRatingView: UIViewRepresentable {
    
    @Binding var rating: Double
    var updateHandler: (Double) -> Void   // callback

    func makeUIView(context: Context) -> CosmosView {
        let cosmosView = CosmosView()
        cosmosView.rating = rating
        cosmosView.settings.starSize = 36
        cosmosView.settings.filledColor = .colorNeavyBlue
        cosmosView.settings.filledBorderColor = .colorNeavyBlue
        cosmosView.settings.emptyBorderColor = .colorNeavyBlue

        // Let Cosmos size itself nicely in HStack
        cosmosView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        cosmosView.setContentHuggingPriority(.defaultHigh, for: .vertical)

        cosmosView.didTouchCosmos = { newRating in
            // live update while dragging, if you want
            self.rating = newRating
        }

        cosmosView.didFinishTouchingCosmos = { newRating in
            self.rating = newRating
            self.updateHandler(newRating)
        }

        return cosmosView
    }

    func updateUIView(_ uiView: CosmosView, context: Context) {
        uiView.rating = rating
    }
}
