//
//  PopUp.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 16/10/25.
//

import SwiftUI

struct PopUp: View {
    
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            Image("referAmount")
                .resizable()
                .scaledToFit()
                .frame(width: .screenWidth * 0.7)
            
            Text("Ride Completed ✅")
                .font(.customfont(.semiBold, fontSize: 17))
            
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
                
                HStack(spacing: 4) {
                    Text("Distance :")
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(.gray)
                    Text("15minutes")
                        .font(.customfont(.semiBold, fontSize: 14))
                }
                
                HStack(spacing: 4) {
                    Text("Fare Earned :")
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(.gray)
                    Text("$80")
                        .font(.customfont(.semiBold, fontSize: 14))
                }
                
                HStack {
                    CustomButtonAction(title: "See Next Ride", color: .colorNeavyBlue, titleColor: .white) {
                        print("See Next Ride")
                    }
                    
                    CustomButtonAction(title: "View Earnings", color: .colorNeavyBlue, titleColor: .white) {
                        print("See Earninh")
                    }
                }
                .padding(.horizontal)
            }
        } // MAIN VSTACK
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 11)
            .stroke(Color.gray, lineWidth: 0.5)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(Color(.white)))
        )
        .padding(.horizontal, 24)

    }
}

#Preview {
    PopUp(isShowing: .constant(false))
}
