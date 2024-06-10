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
    
    @StateObject var viewModel: ProfileViewModel
    
    var body: some View {
        RouterView { router in
            ZStack {
                VStack (spacing: 60){
                    Spacer()
                    VStack {
                        Image(uiImage: viewModel.avatarImage ?? UIImage(resource: .avatar))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 128, height: 128)
                            .clipShape(.circle)
                            .overlay (alignment: .bottomTrailing){
                                PhotosPicker(selection: $viewModel.photosPickerItem, matching: .images) {
                                    Image(systemName: "pencil.circle.fill")
                                        .font(.system(size: 30))
                                        .foregroundStyle(Color.blue)
                                }
                                
                            }
                        Text(viewModel.userName ?? "")
                            .font(.system(size: 29).bold())
                    }
                    
                    VStack (spacing: 20) {
                        ExtractedView(imageName: "person.circle", text: "Personal Information")
                            .onTapGesture {
                                viewModel.openPersonalInformation()
                            }
                        ExtractedView(imageName: "lock.circle", text: "Change Password")
                            .onTapGesture {
                                viewModel.changePassword()
                            }
                        
                        HStack {
                            Image(systemName: "globe")
                                .font(.system(size: 32))
                            Text("Language")
                                .font(.system(size: 20))
                            Spacer()
                            Picker("Choose your language", selection: $viewModel.language) {
                                ForEach(UserLanguage.allCases) { category in
                                    Text(category.rawValue).tag(category)
                                        .font(.callout)
                                }
                            }
                            .onChange(of: viewModel.language, {
                                viewModel.userLanguage = viewModel.language.rawValue
                                viewModel.updatePersonalInformation()
                            })
                            .pickerStyle(.menu)
                        }
                        HStack {
                            Image(systemName: "arrowshape.up.circle")
                                .font(.system(size: 32))
                            Text("Level")
                                .font(.system(size: 20))
                            Spacer()
                            Picker("Choose your level", selection: $viewModel.level) {
                                ForEach(UserLevel.allCases) { category in
                                    Text(category.title).tag(category)
                                        .font(.callout)
                                }
                            }
                            .onChange(of: viewModel.level, {
                                viewModel.userLevel = viewModel.level.levelValue
                                viewModel.updatePersonalInformation()
                            })
                            .pickerStyle(.menu)
                        }
                        
//                        HStack {
//                            Image(systemName: isDarkMode ? "moon.circle" : "sun.max.circle")
//                                .font(.system(size: 32))
//                            Toggle(isOn: $isDarkMode) {
//                                Text("Dark Mode")
//                                    .font(.system(size: 20))
//                            }
//                            .onChange(of: isDarkMode) {
//                                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
//                                    withAnimation {
//                                        scene.windows.first?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
//                                    }
//                                }
//                            }
//                            .tint(Colors.brandPrimary)
//                        }
                        
                        ExtractedView(imageName: "arrow.left.circle", text: "Logout")
                            .onTapGesture {
                                viewModel.showLogoutAlert.toggle()
                            }
                            .alert(isPresented: $viewModel.showLogoutAlert) {
                                Alert(
                                    title: Text("Are you sure you want to logout?"),
                                    primaryButton: .destructive(Text("Logout"), action: {
                                        viewModel.logout()
                                    }),
                                    secondaryButton: .default(Text("Cancel"))
                                )
                            }
                    }
                    .padding(24)
                    .onChange(of: viewModel.photosPickerItem) { _, _ in
                        Task {
                            if let photosPickerItem = viewModel.photosPickerItem,
                               let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                                if let image = UIImage(data: data) {
                                    viewModel.avatarImage = image
                                }
                            }
                            
                            viewModel.photosPickerItem = nil
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
        ProfilePage(viewModel: ProfileViewModel(router: router))
    }
}

struct ExtractedView: View {
    
    let imageName: String
    let text: LocalizedStringResource
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

