//
//  whichPhoto.swift
//  ispy
//
//  Created by Amelia Lane on 4/1/23.
//

import SwiftUI

struct whichPhoto: View {
    var body: some View {
        NavigationView{
            HStack(alignment: .center){
                
                
                NavigationLink(destination: ImageView()){
                    Text("choose from \nphoto library")
                        .padding()
                        .foregroundColor(.black)
                        .background(.red)
                        .cornerRadius(15)
                }
                
                
                NavigationLink(destination: CameraView()){
                    Text("take photo")
                        .padding()
                        .foregroundColor(.black)
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
    
