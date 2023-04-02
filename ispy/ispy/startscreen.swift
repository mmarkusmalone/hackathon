//
//  startscreen.swift
//  ispy
//
//  Created by Amelia Lane on 4/1/23.
//

import SwiftUI

struct startscreen: View {
    var body: some View {
        NavigationView{
            ZStack{
                Image("StartBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                
                VStack(alignment: .center) {
                    
                    Text("I Spy🕵️")
                        .fontWeight(.bold)
                        .font(.system(size:36))
                        .fontWeight(.heavy)
                        .padding(.all)
                    
                    
                    
                    Text("a game for you and your friends")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    NavigationLink(destination: whichPhoto()){
                        Text("**Start**")
                        .padding()
                        .foregroundColor(.white)
                        .background(.red)
                        .cornerRadius(15)
                    }
                    
                    
                    
                }
                .frame(maxWidth: .infinity, maxHeight: 200)
                .background(.white.opacity(0.75))
                .cornerRadius(15)
                .padding(.horizontal)
                
                
            }
        }
    }
        
        
        struct startscreen_Previews: PreviewProvider {
            static var previews: some View {
                startscreen()
                
            }
        }
    }

