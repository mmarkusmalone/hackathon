//
//  ContentView.swift
//  SwiftUIImagePicker
//
//  Created by Simon Ng on 10/6/2020.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import SwiftUI

struct ImageView: View {
    
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    @State private var showNextScreen = false
    
    var body: some View {
        
            ZStack {
                
                VStack {
                    Image("ImageBackground")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .edgesIgnoringSafeArea(.all)
                    
                    Button(action: {
                        self.isShowPhotoLibrary = true
                    }) {
                        HStack {
                            Image(systemName: "photo")
                                .font(.system(size: 40))
                            
                            Text("Photo library")
                                .font(.headline)
                        }
                        
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                        .background(Color.white)
                        .foregroundColor(.green)
                        
                    }
                }
                .sheet(isPresented: $isShowPhotoLibrary, onDismiss: {
                    showNextScreen = true
                }) {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                    
                    
                }
                NavigationLink(destination: ChosenItem(photoSelected: self.$image),
                               isActive: self.$showNextScreen) {
                    EmptyView()
                }.hidden()
            }
        }
    }


struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
           
