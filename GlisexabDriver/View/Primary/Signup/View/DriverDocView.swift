//
//  DriverDocView.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 15/10/25.
//

import SwiftUI

struct DriverDocView: View {
    
    @EnvironmentObject private var router: NavigationRouter
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .top) {
            
            VStack(spacing: 16) {
                headerText
                
                ScrollView {
                    VStack(spacing: 24) {
                        
                        VStack(alignment: .leading, spacing: 15) {
                            
                            Text("Vehicle Registration")
                                .font(.customfont(.medium, fontSize: 14))
                                .padding(.leading, 4)
                            
                            ZStack {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.15))
                                    .frame(height: 100)
                                    .cornerRadius(10)
                                    .overlay (
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray.opacity(0.3), lineWidth: 0.8)
                                    )
                                
                                Image("imagePlace")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .padding(.leading, 12)
                            }
                            
                            Text("Commercial Insurance")
                                .font(.customfont(.medium, fontSize: 14))
                                .padding(.leading, 4)
                            
                            ZStack {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.15))
                                    .frame(height: 100)
                                    .cornerRadius(10)
                                    .overlay (
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray.opacity(0.3), lineWidth: 0.8)
                                    )
                                
                                Image("imagePlace")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .padding(.leading, 12)
                            }

                            Text("Driving License")
                                .font(.customfont(.medium, fontSize: 14))
                                .padding(.leading, 4)
                            
                            ZStack {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.15))
                                    .frame(height: 100)
                                    .cornerRadius(10)
                                    .overlay (
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray.opacity(0.3), lineWidth: 0.8)
                                    )
                                
                                Image("imagePlace")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .padding(.leading, 12)
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 24)
                        
                        Button {
                            router.push(to: .home)
                        } label: {
                            Text("NEXT")
                                .font(.customfont(.bold, fontSize: 16))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 45)
                                .background(Color.colorNeavyBlue)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 40)
                        
                    }// VSTACK
                    .frame(maxWidth: .infinity, alignment: .top)
                    .background(Color.white)
                    .navigationBarBackButtonHidden(true)
                }
            }
            .padding(.horizontal, 24)
            
        } // ZSTACk
        .navigationBarBackButtonHidden(true)
    }
    
    private var headerText: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 16) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.black)
                }
                
                HStack(spacing: 8) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                    
                    Text("Glide Cabs")
                        .font(.customfont(.semiBold, fontSize: 28))
                }
            }
            
            Text("Upload document")
                .font(.customfont(.semiBold, fontSize: 24))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Add your vehicle documents for verification")
                .font(.customfont(.regular, fontSize: 12))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var inputFields: some View {
        VStack(alignment: .leading, spacing: 6) {
            
        }
    }
}


#Preview {
    DriverDocView()
}
