//
//  DecksView.swift
//  YoliFlashZilla
//
//  Created by robin tetley on 08/06/2023.
//

import SwiftUI

struct DecksView: View {
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct DecksView_Previews: PreviewProvider {
    static var previews: some View {
        DecksView()
    }
}
