//
//  CryptoDetailRowView.swift
//  CryptoWork
//
//  Created by Gergely Szoke on 2023. 07. 04..
//

import SwiftUI

struct CryptoDetailRowView: View {
    let title: String
    let valueText: Text
    var valueColor: Color?
    
    var body: some View {
        HStack {
            Text(title)
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color("aldi_black"))
            Spacer(minLength: 16)
            valueText
                .font(.custom("Poppins-Bold", size: 16))
                .foregroundColor(valueColor ?? Color("aldi_black"))
        }
    }
}

struct CryptoDetailRowView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoDetailRowView(
            title: "Title",
            valueText: Text("Value")
        )
    }
}
