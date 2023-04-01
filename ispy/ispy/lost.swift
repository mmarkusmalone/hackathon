//
//  startscreen.swift
//  ispy
//
//  Created by Amelia Lane on 4/1/23.
//

import SwiftUI

struct lost: View {
    var body: some View {
        ZStack{
            Image("purple")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 70, maxWidth: 200)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack(alignment: .center) {
                
                Text("Sorry, you lost.")
                    .fontWeight(.bold)
                    .font(.system(size:36))
                    .fontWeight(.heavy)
                    .padding(.all)
                    
                
                
                
                Text("Better Luck Next Time!")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                
                
                Button("Play Again?") {
                    print("Button tapped!")
                    
                    
                }
                .padding()
                .foregroundColor(.black)
                .background(.red)
                .cornerRadius(15)
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: 200)
            .background(.white)
            .cornerRadius(15)
            .padding(.horizontal)
            
        }
}
   
    
    struct lost_Previews: PreviewProvider {
        static var previews: some View {
            lost()
            
        }
    }
}
