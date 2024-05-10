//
//  ProfilePage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 16.03.2024.
//

import SwiftUI
import PhotosUI
import SwiftfulRouting

struct ProfilePage: View {
    
    let router: AnyRouter
    
    @State private var avatarImage: UIImage?
    @State private var photosPickerItem: PhotosPickerItem?
    @State private var numberOfLesson: Int = 1
    @State private var nameInKazakh: String = ""
    @State private var nameInAnotherLanguage: String = ""
    @AppStorage("isAuthorized") var isAuthorized: Bool = false
    
    var body: some View {
        RouterView{ router in
            ZStack {
                VStack (spacing: 100){
                    VStack {
                        Image(uiImage: avatarImage ?? UIImage(resource: .avatar))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 128, height: 128)
                            .clipShape(.circle)
                            .overlay (alignment: .bottomTrailing){
                                PhotosPicker(selection: $photosPickerItem, matching: .images) {
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
                            .onTapGesture {
                                router.showAlert(.alert, title: "Are you sure you want to logout?") {
                                    Button {
                                        DispatchQueue.main.async {
                                            withAnimation {
                                                self.isAuthorized = false
                                            }
                                        }
                                    } label: {
                                        Text("Logout")
                                    }
                                    
                                    Button {
                                        
                                    } label: {
                                        Text("Cancel")
                                    }

                                }
                            }
                    }
                    .padding(.leading)
                    .onChange(of: photosPickerItem) { _, _ in
                        Task {
                            if let photosPickerItem,
                               let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                                if let image = UIImage(data: data) {
                                    avatarImage = image
                                }
                            }
                            
                            photosPickerItem = nil
                        }
                    }
                    
                    Spacer()
                    
                }
            }
            .navigationTitle("Profile")
        }
    }
}



#Preview {
    RouterView { router in
        ProfilePage(router: router)
    }
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
