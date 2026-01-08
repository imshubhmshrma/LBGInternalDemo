//
//  UserCellView.swift
//  LBGInternalDemo
//
//  Created by Shubham Sharma on 30/12/25.
//

import SwiftUI

struct UserCellView: View{
    let user: User
    var body: some View{
        VStack(alignment: .leading){
            Text(user.firstName)
                .font(.title)
                .accessibilityIdentifier("userCellView_txt_firstName_\(user.id)")
            Text(user.lastName)
                .font(.title2)
                .accessibilityIdentifier("userCellView_txt_lastName_\(user.id)")
        }
    }
}
