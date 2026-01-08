//
//  UserViewModel.swift
//  LBGInternalDemo
//
//  Created by Shubham Sharma on 30/12/25.
//
import Combine
class UserViewModel: ObservableObject{
    
    let service: UserServiceProtocol
    @Published var users: [User] = []
    @Published var isLoading = false
    
    init(service: UserServiceProtocol = UserService()){
        self.service = service
    }
    
    func getUsers(){
        self.isLoading = true
        defer { self.isLoading = false }
        
        self.service.getUsers { result in
            switch result{
            case .success(let users):
                print("users in View Model",users)
                self.users = users
            case .failure(let error):
                print("error in View Model",error)
            }
            self.isLoading = false
        } 
    }
    
    
    func getUsers() async{
        self.isLoading = true
        defer { self.isLoading = false}
        
        
        let data = await self.service.getUsers()
        
        switch data{
        case .success(let users):
            self.users = users
            self.isLoading = false
        case .failure(let error):
            print("error in View Model",error)
            self.isLoading = false
        }
    }
 
   
}
