//
//  whichPhoto.swift
//  ispy
//
//  Created by Amelia Lane on 4/1/23.
//

import SwiftUI

struct whichPhoto: View {
    var body: some View {
        ZStack{
            Image("StartBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            HStack(alignment: .center){
                
                
                NavigationLink(destination: ImageView()){
                    Text("Choose From \nPhoto Library")
                        .padding()
                        .foregroundColor(.white)
                        .background(.red)
                        .cornerRadius(15)
                }
                
                
                NavigationLink(destination: CameraView()){
                    Text("Take Photo")
                        .padding(27)
                        .foregroundColor(.white)
                        .background(.red)
                        .cornerRadius(15)
                }
                
                
            }
            .fixedSize(horizontal: true, vertical: true)
            .frame(height: 400)
            .frame(maxHeight: 400)
            .fontWeight(.bold)
            
        }
    }
    
    struct whichPhoto_Previews: PreviewProvider {
        static var previews: some View {
            whichPhoto()
        }
    }
    
    
    
}
