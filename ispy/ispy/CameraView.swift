//
//  ContentView.swift
//  SwiftUIImagePicker
//
//  Created by Simon Ng on 10/6/2020.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import SwiftUI

struct CameraView: View {
    
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    @State private var showNextScreen = false
    
    var body: some View {
        
            
        VStack {
            
            Image("CameraBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            Button(action: {
                self.isShowPhotoLibrary = true
            }) {
                HStack {
                    Image(systemName: "camera")
                        .font(.system(size: 40))
                        
                    Text("Take Your ISpy Photo Here")
                        .font(.headline)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                .background(Color.white)
                .foregroundColor(.purple)
            }
        }
        .sheet(isPresented: $isShowPhotoLibrary, onDismiss: {
            showNextScreen = true
        }) {
            ImagePicker(sourceType: .camera, selectedImage: self.$image)
        }
        NavigationLink(destination: ChosenItem(photoSelected: self.$image),
                       isActive: self.$showNextScreen) {
            EmptyView()
        }.hidden()
        
        }
    }



struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
