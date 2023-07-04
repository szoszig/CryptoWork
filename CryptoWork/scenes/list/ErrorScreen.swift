//
//  ErrorScreen.swift
//  CryptoWork
//
//  Created by Gergely Szoke on 2023. 07. 04..
//

import SwiftUI

struct ErrorScreen: View {
    let error: CryptoWorkError
    let callback: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: error.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color("aldi_black"))
                .frame(width: 145, height: 143)
            Text(error.title)
                .font(.custom("Poppins-Bold", size: 30))
                .foregroundColor(Color("aldi_black"))
            Text(error.localizedDescription)
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color("aldi_black"))
            
            Button {
                callback()
            } label: {
                HStack {
                    Image(systemName: "return")
                        .foregroundColor(Color("aldi_white"))
                    Text("Retry").foregroundColor(Color("aldi_white"))
                        .font(.custom("Poppins-Regular", size: 16))
                }
                .padding(.vertical, 10)
                .padding(.horizontal,40)
                .background(
                    RoundedRectangle(cornerRadius: 5))
            }.padding(.top, 30)
            Spacer()
        }.padding(.horizontal, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ErrorScreen_Previews: PreviewProvider {
    static var previews: some View {
        ErrorScreen(error: .mappingError, callback: {})
    }
}
