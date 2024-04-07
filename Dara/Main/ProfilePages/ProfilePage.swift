//
//  ProfilePage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 16.03.2024.
//

import SwiftUI

struct ProfilePage: View {
    @State var numberOfLesson: Int = 1
    @State var nameInKazakh: String = ""
    @State var nameInAnotherLanguage: String = ""
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack (spacing: 100){
                    VStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 100))
                            .padding()
                            .background(Color.black.cornerRadius(70))
                            .overlay (alignment: .bottomTrailing){
                                Button {
                                    // action
                                } label: {
                                    Image(systemName: "pencil.circle.fill")
                                        .font(.system(size: 30))
                                        .foregroundStyle(Color.blue)
                                    
                                }
                                
                            }
                        Text("Yessimkhan")
                            .font(.system(size: 29).bold())
                    }
                    
                    VStack (spacing: 20){
                        ExtractedView(imageName: "person", text: "Personal Information")
                        ExtractedView(imageName: "lock", text: "Login and security")
                        ExtractedView(imageName: "globe", text: "Language")
                        ExtractedView(imageName: "arrow.left.square", text: "Logout")
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                }
            }
            .navigationTitle("Profile")
        }
    }
}



#Preview {
    ProfilePage()
}

struct ExtractedView: View {
    
    let imageName: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .font(.system(size: 32))
            Text(text)
                .font(.system(size: 20))
            Spacer()
        }
    }
}
