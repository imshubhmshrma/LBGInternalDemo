//
//  UserDetailsView.swift
//  LBGInternalDemo
//
//  Created by Shubham Sharma on 31/12/25.
//
import SwiftUI


struct UserDetailsView: View{
    let user: User
    var body: some View{
        VStack{
            Text("\(user.firstName) \(user.lastName)")
                .font(.largeTitle)
                .bold()
                .accessibilityIdentifier("UserDetailsView_txt_fName_Lname")
            Text("ID: \(user.id)")
                .font(.title)
                .navigationTitle("User Details")
                .accessibilityIdentifier("UserDetailsView_txt_Id")
        }
    }
}
