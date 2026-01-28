//
//  StartView.swift
//  Start
//
//  Created by Joao Barbosa on 26/01/2026.
//

import SwiftUI

struct StartView: View {

    @ObservedObject var viewModel: StartViewModel

    var body: some View {
        Button {
            viewModel.goToRace()
        } label: {
            Text("Start Bee Race")
                .fontWeight(.semibold)
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
        }
    }
}
