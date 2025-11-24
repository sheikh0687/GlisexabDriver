//
//  SideMenuRow.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 17/10/25.
//

import SwiftUI

struct SideMenuRow: View {
    
    let optionModel: SideMenuRowOption
//    @Binding var selectedOption: SideMenuRowOption?
    
    var body: some View {
        HStack(alignment: .center, spacing: 18) {
            Image(optionModel.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 28, height: 28)
                .alignmentGuide(.firstTextBaseline) { d in
                    d[.bottom]
                }
            
            Text(optionModel.title)
                .font(.customfont(.medium, fontSize: 18))
                .foregroundColor(.white)
                .alignmentGuide(.firstTextBaseline) { d in
                    d[.bottom]
                }

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 8)
    }
}


#Preview {
    SideMenuRow(optionModel: .myAccount)
}
