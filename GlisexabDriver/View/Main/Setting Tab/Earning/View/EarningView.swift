//
//  EarningView.swift
//  GlisexabDriver
//
//  Created by Arbaz  on 17/01/26.
//

import SwiftUI

struct EarningView: View {
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 24) {
                HStack(spacing: 12) {
                    VStack(alignment: .center, spacing: 10) {
                        Text("$\("0.0")")
                            .font(.customfont(.bold, fontSize: 18))
                        
                        Text("Total Earning")
                            .font(.customfont(.medium, fontSize: 16))
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .padding(.horizontal, 20)
                    .background (
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.gray, lineWidth: 0.5)
                            .background (
                                RoundedRectangle(cornerRadius: 18)
                                    .fill(Color.white)
                            )
                            .ignoresSafeArea(edges: .bottom)
                    )
                    
                    VStack(alignment: .center, spacing: 10) {
                        Text("$\("0.0")")
                            .font(.customfont(.bold, fontSize: 18))
                        
                        Text("Today Earning")
                            .font(.customfont(.medium, fontSize: 16))
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .padding(.horizontal, 20)
                    .background (
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.gray, lineWidth: 0.5)
                            .background (
                                RoundedRectangle(cornerRadius: 18)
                                    .fill(Color.white)
                            )
                            .ignoresSafeArea(edges: .bottom)
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                EarningCardView()
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Earning")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EarningCardView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 4) {
                Image(systemName: "mappin")
                    .foregroundColor(.red)
                    .font(.system(size: 18))
                Text("1901 Thornridge Cir. Shiloh, Hawaii 81063")
                    .font(.customfont(.medium, fontSize: 14))
                    .multilineTextAlignment(.leading)
            }
            
            HStack(spacing: 4) {
                Image(systemName: "mappin.circle.fill")
                    .foregroundColor(.green)
                    .font(.system(size: 18))
                Text("2715 Ash Dr. San Jose, South Dakota 83475")
                    .font(.customfont(.medium, fontSize: 14))
                    .multilineTextAlignment(.leading)
            }
            
            HStack {
                Text("Total")
                    .font(.customfont(.medium, fontSize: 14))
                
                Spacer()
                
                Text("$280")
                    .font(.customfont(.medium, fontSize: 14))
            }
            
            HStack {
                Spacer()
                
                Text("2026-01-09 12:05 pm")
                    .font(.customfont(.regular, fontSize: 15))
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 4)
    }
}

#Preview {
    EarningView()
}
