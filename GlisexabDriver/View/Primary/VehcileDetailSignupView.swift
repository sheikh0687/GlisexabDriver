//
//  VehcileDetailSignupView.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 15/10/25.
//

import SwiftUI

struct VehcileDetailSignupView: View {
    
    @State private var vehicleType = ""
    @State private var vehicleBrand = ""
    @State private var vehicleNumber = ""
    @State private var vehicleColor = ""
    
    @EnvironmentObject private var router: NavigationRouter
    
    var body: some View {
        
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    
                    Text("Add Vehicle Details")
                        .font(.customfont(.medium, fontSize: 18))
                        .padding(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 40)
                        .padding(.bottom, 20)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        
                        Text("Vehicle Type")
                            .font(.customfont(.medium, fontSize: 14))
                            .padding(.leading, 4)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.15))
                                .frame(height: 45)
                                .cornerRadius(10)
                                .overlay (
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 0.8)
                                )
                            
                            HStack {
                                TextField("Select Vehicle Type", text: $vehicleType)
                                    .font(.customfont(.light, fontSize: 14))
                                    .padding()
                            }
                        }
                        
                        Text("Vehicle Brand & Model")
                            .font(.customfont(.medium, fontSize: 14))
                            .padding(.leading, 4)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.15))
                                .frame(height: 45)
                                .cornerRadius(10)
                                .overlay (
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 0.8)
                                )
                            
                            HStack {
                                TextField("Enter Brand & Model", text: $vehicleBrand)
                                    .font(.customfont(.light, fontSize: 14))
                                    .padding()
                            }
                        }
                        
                        Text("Vehicle Number Plate")
                            .font(.customfont(.medium, fontSize: 14))
                            .padding(.leading, 4)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.15))
                                .frame(height: 45)
                                .cornerRadius(10)
                                .overlay (
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 0.8)
                                )
                            
                            HStack {
                                TextField("Enter number plate", text: $vehicleNumber)
                                    .font(.customfont(.light, fontSize: 14))
                                    .padding()
                            }
                        }
                        
                        Text("Vehicle Color")
                            .font(.customfont(.medium, fontSize: 14))
                            .padding(.leading, 4)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.15))
                                .frame(height: 45)
                                .cornerRadius(10)
                                .overlay (
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 0.8)
                                )
                            
                            HStack {
                                TextField("Enter color", text: $vehicleColor)
                                    .font(.customfont(.light, fontSize: 14))
                                    .padding()
                            }
                        }
                        
                        Text("Select Your Vehicle Image")
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
                        router.push(to: .driverDocument)
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
        } // ZSTACk
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton {
                    router.popView()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                CustomLogo()
                    .frame(width: 100, height: 120)
            }
            
        }
        .onAppear {
            UINavigationBar.setTitleColor(.white)
        }
    }}

#Preview {
    VehcileDetailSignupView()
}
