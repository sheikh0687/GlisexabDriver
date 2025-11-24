//
//  AddressPickerView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 31/10/25.
//

import SwiftUI
import MapKit

struct AddressPickerView: View {
    
    @StateObject var searchViewModel: AddressSearchViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            TextField("Search address...", text: $searchViewModel.queryFragment)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
                .padding(.horizontal)
                .padding(.top, 20)
            
            if searchViewModel.results.isEmpty && !searchViewModel.queryFragment.isEmpty {
                Spacer()
                Text("No results")
                    .foregroundColor(.gray)
                Spacer()
            } else {
                List(searchViewModel.results, id: \.self) { result in
                    VStack(alignment: .leading) {
                        Text(result.title)
                            .fontWeight(.semibold)
                        if !result.subtitle.isEmpty {
                            Text(result.subtitle)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 4)
                    .onTapGesture {
                        searchViewModel.selectAddress(result) {
                            dismiss()
                        }
                    }
                }
            }
        }
        .navigationTitle("Search Address")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: doneButton)
        .onAppear {
            searchViewModel.queryFragment = ""
        }
    }
    
    @ViewBuilder
    private var doneButton: some View {
        Button {
            dismiss()
        } label: {
            Text("Done")
                .font(.customfont(.medium, fontSize: 16))
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    AddressPickerView(searchViewModel: .init())
}
