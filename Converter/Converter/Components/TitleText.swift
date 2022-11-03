//
//  TitleText.swift
//  Converter
//
//  Created by Яна Шебеко on 25.10.22.
//

import SwiftUI

struct TitleText: View {
    @State var text = ""
    @State var size: CGFloat
    var body: some View {
        Text(text)
            .padding()
            .font(.custom("Academy Engraved LET", size: size))
            .foregroundColor(.black)
    }
}

struct TitleText_Previews: PreviewProvider {
    static var previews: some View {
        TitleText(text: "Converterrrrr",size: 70)
    }
}
