//
//  ChosenItem.swift
//  ispy
//
//  Created by Amelia Lane on 4/1/23.
//

import SwiftUI

struct ChosenItem: View {
    @Binding var photoSelected: UIImage
    @State var item: String = ""
    var body: some View {
        VStack(alignment: .center){
            Image(uiImage: photoSelected)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 500)
            Text("What item is this?")
            TextField("write item here", text: $item)
                .multilineTextAlignment(.center)
            NavigationLink(destination: chatguess()){
                Text("**Let's Start**")
                    .padding()
                    .foregroundColor(.white)
                    .background(.red)
                    .cornerRadius(15)
            }
        }
    }
}

struct ChosenItem_Previews: PreviewProvider {
    static var previews: some View {
        ChosenItem(photoSelected: Binding.constant(UIImage()))
    }
}

