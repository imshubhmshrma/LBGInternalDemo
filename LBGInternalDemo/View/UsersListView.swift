//
//  UsersListView.swift
//  LBGInternalDemo
//
//  Created by Shubham Sharma on 30/12/25.
//

import SwiftUI

struct UsersListView: View {
    @StateObject var usersVM: UserViewModel
    
    init(usersVM: UserViewModel = UserViewModel(service: UserService())) {
        _usersVM = StateObject(wrappedValue: usersVM)
    }
    
    var body: some View {
        NavigationStack{
            Group{
                if usersVM.isLoading == true{
                    ProgressView()
                        .accessibilityIdentifier("progress_view_UsersListView")
                }else{
                    VStack{
                        List(usersVM.users,id:\.id) { user in
                            NavigationLink{
                                UserDetailsView(user: user)
                            } label: {
                                UserCellView(user: user)
                            }
                            .accessibilityIdentifier("user_cell_\(user.id)")
                            
                        }.accessibilityIdentifier("userListView")
                            .task {
                                usersVM.getUsers()
                            }
                    }
                }
            }
            .navigationTitle("Users")
        }
    }
}
