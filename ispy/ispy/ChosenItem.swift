//
//  ChosenItem.swift
//  ispy
//
//  Created by Amelia Lane on 4/1/23.
//

import SwiftUI

struct ChosenItem: View {
    @State var item: String = ""
    var body: some View {
        VStack(alignment: .center){
            Text("what item is this?")
            TextField("write item here", text: $item)
                .multilineTextAlignment(.center)
            
        }
    }
}

struct ChosenItem_Previews: PreviewProvider {
    static var previews: some View {
        ChosenItem()
    }
}
