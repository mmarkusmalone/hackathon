//
//  ChosenItem.swift
//  ispy
//
//  Created by Amelia Lane on 4/1/23.
//

import SwiftUI
@State private var item: String

struct ChosenItem: View {
    var body: some View {
        HStack{
            Text("what item is this?")
            TextField(text: $item, prompt: Text("write item here")) {
                
            }
        }
    }
}

struct ChosenItem_Previews: PreviewProvider {
    static var previews: some View {
        ChosenItem()
    }
}
