//
//  CreateAccountPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 27.02.2024.
//

import SwiftUI

struct CreateAccountPage: View {
    
    @State var userName: String = ""
    @State var userNumber: String = ""
    @State var userEmail: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack{
                VStack (spacing: 100){
                    Spacer()
                    
                    VStack() {
                        Text("Create an Account")
                            .font(.title)
                        
                        TextField("Username...", text: $userName)
                            .padding()
                            .background(Color.gray.opacity(0.3).cornerRadius(10))
                            .padding()
                        
                        TextField("Phone...", text: $userNumber)
                            .padding()
                            .background(Color.gray.opacity(0.3).cornerRadius(10))
                            .padding()
                            .keyboardType(.numberPad)
                        
                        TextField("Email...", text: $userEmail)
                            .padding()
                            .background(Color.gray.opacity(0.3).cornerRadius(10))
                            .padding()
                        
                        Button(action: {
                            
                        }, label: {
                            Text("Continue")
                                .foregroundStyle(Color.blue)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.black.cornerRadius(10))
                                .padding()
                        })
                    }
                    
                    VStack (spacing: 20) {
                        Text("Or")
                        HStack {
                            Button(action: {
                                
                            }, label: {
                                Image(systemName: "star.fill")
                                    .padding()
                                    .padding(.horizontal, 50)
                                    .background(Color.black.cornerRadius(10))
                            })
                            
                            Button(action: {
                                
                            }, label: {
                                Image(systemName: "heart.fill")
                                    .padding()
                                    .padding(.horizontal, 50)
                                    .background(Color.black.cornerRadius(10))
                                
                            })
                        }
                        Button(action: {
                            
                        }, label: {
                            Text("Alreary Dara's user? Log in")
                            
                        })
                    }
                }
            }
        }
    }
}

#Preview {
    CreateAccountPage()
}
