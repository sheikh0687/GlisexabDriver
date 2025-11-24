//
//  WalletView.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 28/10/25.
//

import SwiftUI

struct WalletView: View {
    
    @EnvironmentObject private var router: NavigationRouter
    
    var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill (
                        LinearGradient (
                            colors: [.colorNeavyBlue, .colorLightNeavy],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 180)
                    .overlay (
                        HStack {
                            VStack(alignment: .leading, spacing: 36) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Your Balance")
                                        .font(.customfont(.semiBold, fontSize: 18))
                                        .foregroundColor(.white)
                                    Text("$ 19,84,500")
                                        .font(.customfont(.bold, fontSize: 24))
                                        .foregroundColor(.white)
                                }
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Account Number")
                                        .font(.customfont(.semiBold, fontSize: 18))
                                        .foregroundColor(.white)
                                    Text("*****6774")
                                        .font(.customfont(.bold, fontSize: 24))
                                        .foregroundColor(.white)
                                }
                            }
                            Spacer()
                            Button(action: {
                                // handle withdrawal
                            }) {
                                Text("Withdrawal")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.colorNeavyBlue)
                                    .frame(width: 110, height: 36)
                                    .background(Color.white)
                                    .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal, 18)
                        .padding(.vertical, 20)
                    )
            }
            .padding(.horizontal)
        }
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
}

#Preview {
    WalletView()
}
