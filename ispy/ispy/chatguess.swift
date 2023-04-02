//
//  chatguess.swift
//  ispy
//
//  Created by Maya Markus-Malone on 4/1/23.
// key: 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
 
import SwiftUI
import Foundation
import OpenAISwift

struct chatguess: View {
    @Binding var word: String
    @ObservedObject
    var viewmodel = ViewModel()
    @State
    var text = ""
    @State
    var messages = [String]()
    @State
    var oghints = ["replace", "replace", "replace", "replace", "replace"]
    @State
    var recievedhints = ["", "", "", "", ""]
    @State
    var hints = 0
    @State var guessButton = false
    @State var user_guess: String = ""
    @State var guess_count = 0
    @State var rightorwrong = " "
    @State var showNextScreen1 = false
    @State var showWinScreen = false
    
    let dispatchGroup = DispatchGroup()
    
    var body: some View {
            VStack() {
                VStack(alignment: .leading) {
                    Spacer()
                    Text("Hint #1: Word with Same First letter").frame(width: 350, height: 20, alignment: .topLeading)
                    Text(recievedhints[0])
                }.frame(alignment: .top)
                VStack(){
                    Text("Hint #2: Color").frame(width: 350, height: 20, alignment: .leading)
                    Text(recievedhints[1])
                }
                VStack(alignment: .leading){
                    Text("Hint #3:Rhyming Word").frame(width: 350, height: 20, alignment: .leading)
                    Text(recievedhints[2])
                }
                VStack(alignment: .leading){
                    Text("Hint #4: Average Size").frame(width: 350, height: 20, alignment: .leading)
                    Text(recievedhints[3])
                }
                VStack(alignment: .leading){
                    Text("Hint #5: Purpose").frame(width: 350, height: 20, alignment: .leading)
                    Text(recievedhints[4])
                }
                
                Spacer()
                HStack(alignment: .center){
                    Button("I got it!"){
                        guessButton = true
                    }.frame(width: 100, height: 40).background(.blue).foregroundColor(.white).font(.title3).cornerRadius(12).alert("Guess", isPresented: $guessButton, actions: {
                        TextField("Guess", text: $user_guess)
                        
                        Button("Enter", action: {
                            compareWords(us_g: user_guess, rw: word)
                        })
                        Button("Cancel", role: .cancel, action: {})
                    }, message: {
                        Text("Please enter your Guess.\n Number of Guesses: \(guess_count) \n \(rightorwrong)")
                    })
                    NavigationLink(destination: lost()){
                        Text("I give up")
                            .frame(width: 100, height: 40)
                            .background(.blue)
                            .foregroundColor(.white)
                            .font(.title3)
                            .cornerRadius(12)
                    }}

                Button("Give me a Hint") {
                action: do{
                    switch hints{
                    case 0:
                        generate_hints()
                        dispatchGroup.notify(queue: .main) {
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
                
            }.padding(.horizontal).frame(alignment: .top)
        .onAppear {
                viewmodel.setup()
            }
        
        NavigationLink(destination: congrats(), isActive: self.$showWinScreen) {
            EmptyView()
        }.hidden()
        }

        func compareWords(us_g: String, rw: String){
            if (us_g.lowercased() == rw.lowercased()){
                rightorwrong = "Correct"
                showWinScreen = true
                showNextScreen1 = true
            }
            else{
                guess_count+=1
                rightorwrong = "Incorrect"
            }
            /*NavigationLink(destination: congrats(), isActive: self.$showNextScreen1){
                EmptyView()
                }.hidden()*/
            print("here")
        }
    
        func generate_hints(){
            let prompts = ["Please put the answer of this query- what word, that is not \(word), starts with the letter \(word.first!)?-   the BLANK of this format: BLANK starts with the same letter as the mystery object", "Please answer this query- In one word, what is the color of an average \(word)?- in the following format: The mystery object is normally blank. ", "Give me a word that rhymes with \(word) and answer without using the word \(word)", "Please answer this query- How would you describe the average size of a \(word)?- in the following format without using the word \(word): An average mystery object is BLANK", "Without using the word \(word), breifly, what do people use a the mystery object for?"]
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
        chatguess(word: Binding.constant(""))
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
                    case.failure(_):
                        print("fail")
                        break
                }
            })
    }
            
}
