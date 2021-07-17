//
//  EmptyView.swift
//  TimeLeftUntil
//
//  Created by Noe De La Croix on 05/07/2021.
//

import SwiftUI

struct EmptyView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
//        LaunchAlert()
//            .onAppear(perform: {
//                presentationMode.wrappedValue.dismiss()})
            
        Text("Hey")
        }
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
