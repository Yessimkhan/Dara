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
    let scenes = UIApplication.shared.connectedScenes
    
    @State private var avatarImage: UIImage?
    @State private var photosPickerItem: PhotosPickerItem?
    @State private var numberOfLesson: Int = 1
    @State private var nameInKazakh: String = ""
    @State private var nameInAnotherLanguage: String = ""
    @State private var showLogoutAlert: Bool = false
    @State private var showReloadAlert: Bool = false
    @AppStorage("isAuthorized") var isAuthorized: Bool = false
    @AppStorage("userEmail") var userEmail: String?
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @AppStorage("user_level") var userLevel: Int = 1
    @AppStorage("level") var level: LanguageLevel = .A1

    var body: some View {
        RouterView{ router in
            ZStack {
                VStack (spacing: 60){
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
                        Text(userEmail ?? "")
                            .font(.system(size: 29).bold())
                    }
                    
                    VStack (spacing: 20) {
                        ExtractedView(imageName: "person", text: "Personal Information")
                        
                        ExtractedView(imageName: "lock", text: "Login and security")
                        ExtractedView(imageName: "globe", text: "Language")
                        ExtractedView(imageName: "arrow.left.square", text: "Logout")
                            .onTapGesture {
                                showLogoutAlert.toggle()
                            }
                            .alert(isPresented: $showLogoutAlert) {
                                Alert(
                                    title: Text("Are you sure you want to logout?"),
                                    primaryButton: .destructive(Text("Logout"), action: {
                                        DispatchQueue.main.async {
                                            withAnimation {
                                                self.isAuthorized = false
                                            }
                                        }
                                    }),
                                    secondaryButton: .default(Text("Cancel"))
                                )
                            }
                        
                        HStack {
                            Image(systemName: "arrowshape.up.circle")
                                .font(.system(size: 32))
                            Text("Level")
                                .font(.system(size: 20))
                            Spacer()
                            Picker("Choose your level", selection: $level) {
                                ForEach(LanguageLevel.allCases) { category in
                                    Text(category.rawValue).tag(category)
                                        .font(.callout)
                                }
                            }
                            .onChange(of: level, {
                                userLevel = level.levelValue
                                showReloadAlert.toggle()
                                print(userLevel)
                            })
                            .pickerStyle(.menu)
                        }
                        .alert(isPresented: $showReloadAlert) {
                            Alert(
                                title: Text("Get a new level"),
                                message: Text("To get a new level you need to restart the application.")
                            )
                        }
                        
                        HStack {
                            Image(systemName: isDarkMode ? "moon" : "sun.min")
                                .font(.system(size: 32))
                            Toggle(isOn: $isDarkMode) {
                                Text("Dark Mode")
                                    .font(.system(size: 20))
                            }
                            .onChange(of: isDarkMode) { value in
                                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                    withAnimation {
                                        scene.windows.first?.overrideUserInterfaceStyle = value ? .dark : .light
                                    }
                                }
                            }
                            .tint(Colors.brandPrimary)
                        }
                    }
                    .padding(24)
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
    @State var isSelected: Bool = false {
        didSet {
            print("hello")
            angle = Angle(degrees: isSelected ? 0 : 180)
        }
    }
    @State var angle: Angle = Angle(degrees: 180)
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .font(.system(size: 32))
            Text(text)
                .font(.system(size: 20))
            Spacer()
            Image(systemName: "chevron.right")
//                .rotationEffect(angle)
//                .onTapGesture {
//                    withAnimation() {
//                        isSelected.toggle()
//                    }
//                }
        }
    }
}

