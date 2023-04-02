//
//  chatguess.swift
//  ispy
//
//  Created by Maya Markus-Malone on 4/1/23.
// key: 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

import SwiftUI
import Foundation
import OpenAISwift
//let openAI = OpenAISwift(authToken: "TOKEN")
let word = "apple"
struct chatguess: View {
    @ObservedObject
    var viewmodel = ViewModel()
    @State
    var text = ""
    @State
    var messages = [String]()
    @State
    var oghints = ["replace", "replace", "replace", "replace", "replace"]
    @State
    var recievedhints = [" 1", " 2", " 3", " 4", " 5"]
    @State
    var hints = 0
    
    let dispatchGroup = DispatchGroup()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Hint #1: " + recievedhints[0])
                    Spacer()
                    Text("Hint #2: " + recievedhints[1])
                    Spacer()
                    Text("Hint #3: " + recievedhints[2])
                    Spacer()
                    Text("Hint #4: " + recievedhints[3])
                    Spacer()
                    Text("Hint #5: " + recievedhints[4])
                }
                
                Spacer()
                HStack(){
                    Button("I got it!"){
                        
                    }.frame(width: 100, height: 40).background(.blue).foregroundColor(.white).font(.title3).cornerRadius(12)
                    Button("I give up"){
                        
                    }.frame(width: 100, height: 40).background(.blue).foregroundColor(.white).font(.title3).cornerRadius(12)
                }
                Button("Give me a Hint") {
                action: do{
                    switch hints{
                    case 0:
                        generate_hints()
                        dispatchGroup.notify(queue: .main) {
                            print("done")
                            recievedhints[hints] = oghints[hints]
                            print(oghints[0], recievedhints[0], oghints[1], recievedhints[1], oghints[2], recievedhints[2], oghints[3], recievedhints[3], oghints[4], recievedhints[4],separator: " ||| \n")
                            hints += 1
                        }
                        break
                    case 5:
                        print("better luck next time")
                        break
                    default:
                        dispatchGroup.notify(queue: .main) {
                            recievedhints[hints] = oghints[hints]
                            print(oghints[0], recievedhints[0], oghints[1], recievedhints[1], oghints[2], recievedhints[2], oghints[3], recievedhints[3], oghints[4], recievedhints[4],separator: " ||| \n")
                            hints+=1
                        }
                        break
                    }
                }
                }.frame(width: 300, height: 60).background(.blue).foregroundColor(.white).font(.title3).cornerRadius(12)
                
            }.padding(.horizontal).navigationTitle("Figure this out")
        }.onAppear {
                viewmodel.setup()
            }
        }
        func generate_hints(){
            let prompts = ["Please answer this query without using the word \(word) - what is a word, not \(word), that starts with the letter \(word.first!)?-  in this format: BLANK starts with the same letter as the mystery object", "Please answer this query- In one word, what is the color of an average \(word)?- in the following format: The mystery object is normally BLANK. ", "Please answer this query- Give me a word that rhymes with \(word)- in the following format without using the word \(word): BLANK rhymes with the mystery object", "Please answer this query- How would you describe the average size of a \(word)?- in the following format without using the word \(word): An average mystery object is BLANK", "Without using the word \(word), breifly, what do people use a the mystery object for?"]
            for i in 0..<prompts.count {
                    let prompt = prompts[i]
                    dispatchGroup.enter()
                    viewmodel.send(text: prompt) { result in
                        oghints[i] = result
                        dispatchGroup.leave()
                    }
            }
        }
        
    }
    


struct chatguess_Previews: PreviewProvider {
    static var previews: some View {
        chatguess()
    }
}

public class ViewModel: ObservableObject {
    init() {}
    private
    var client: OpenAISwift?
    func setup() {
        client = OpenAISwift(authToken: "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")
    }
    
    func send(text: String, completion: @escaping(String) -> Void) {
            client?.sendCompletion(with: text, maxTokens: 500, completionHandler: {
                result in
                switch result {
                    case.success(let message): let output = message.choices.first?.text ?? ""
                    completion(output)
                    case.failure(_): break
                }
            })
    }
            
}
