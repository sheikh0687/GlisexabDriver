//
//  UploadDocumentView.swift
//  GlisexabDriver
//
//  Created by Arbaz  on 14/01/26.
//

import SwiftUI

struct UploadDocumentView: View {
    
    @EnvironmentObject private var router: NavigationRouter
    @State private var isDropDown: Bool = false
    @StateObject private var viewModel = DocumentViewModel()
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    vehicleTypeField
                        .padding(.horizontal)
                    
                    DocumentUploadRow (
                        title: "Driving License",
                        subtitle: "Driving license is official document") {
                            print("")
                        }
                    
                    DocumentUploadRow (
                        title: "Vehicle Image",
                        subtitle: "Upload your vehicle image") {
                            print("")
                        }
                    
                    DocumentUploadRow (
                        title: "vehicle Registration",
                        subtitle: "Upload your registration Sticker") {
                            print("")
                        }
                    
                    DocumentUploadRow (
                        title: "Airport sticker codes front",
                        subtitle: "Upload airport sticker codes front") {
                            print("")
                        }
                    
                    DocumentUploadRow (
                        title: "Airport sticker codes back",
                        subtitle: "Upload airport sticker codes back") {
                            print("")
                        }
                    
                    updateDocButton
                }
                .padding(.bottom, 32)
                .padding(.horizontal, 20)
                .padding(.top, 16)
            }
        }
        .navigationTitle(Text("Upload Document"))
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton {
                    router.popView()
                }
            }
        }
        .onAppear {
            UINavigationBar.setTitleColor(.white)
        }
    }
    
    private var vehicleTypeField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Vehicle Type")
                .font(.customfont(.medium, fontSize: 14))

            Button(action: {
                withAnimation {
                    isDropDown.toggle()
                }
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .frame(height: 45)
                        .shadow(color: .black.opacity(0.04), radius: 8,x: 0, y: 2)
                    
                    HStack {
                        Text(
                            viewModel.vehicleName.isEmpty ?
                            "Select Vehicle Type" :
                                viewModel.vehicleName
                        )
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                        
                        Spacer()
                        
                        Image(systemName: isDropDown ? "chevron.up" : "chevron.down")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
    
    private var updateDocButton: some View {
        Button {
//            Task {
//               await viewModel.webLoginResponse(appState: appState)
//            }
            print("Call an api")
        } label: {
            HStack {
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.white)
                        .scaleEffect(0.8)
                } else {
                    Text("Update")
                        .font(.customfont(.regular, fontSize: 14))
                }
            }
            .foregroundColor(.yellow)
            .shadow(radius: 2)
            .frame(maxWidth: .infinity)
            .frame(height: 48)
        }
        .background (.colorNeavyBlue)
        .cornerRadius(10)
        .disabled(viewModel.isLoading)
        .padding(.top, 16)
    }
}

struct DocumentUploadRow: View {
    
    let title: String
    let subtitle: String
    let onTap: () -> Void
    
    @State private var selectedImage: UIImage?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.customfont(.medium, fontSize: 16))
                        .foregroundColor(.black)
                    Text(subtitle)
                        .font(.customfont(.regular, fontSize: 14))
                        .foregroundColor(.gray)
                        .lineLimit(2)
                }
                Spacer()
            }
            
            HStack {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 80, height: 80)
                        .overlay (
                            Image(systemName: "camera.fill")
                                .font(.title2)
                                .foregroundColor(.gray)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                Spacer()
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .gray.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    UploadDocumentView()
}
