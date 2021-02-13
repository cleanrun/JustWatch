//
//  ContentView.swift
//  JustWatch
//
//  Created by Marchell on 13/02/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onTapGesture {
                JWServices.Request(url: JWServices.URL_MOVIES_GET_DETAILS("0"), onSuccess: { response in
                    print("Request success")
                }, onFailure: { error in
                    print("Request error:: \(error.statusCode)")
                })
            }
    }
}
