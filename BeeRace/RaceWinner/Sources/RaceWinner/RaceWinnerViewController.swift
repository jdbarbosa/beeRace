//
//  RaceWinnerViewController.swift
//  RaceWinner
//
//  Created by Joao Barbosa on 26/01/2026.
//

import UIKit
import Protocols
import SwiftUI

@MainActor
final class RaceWinnerViewController: UIViewController, ViewModelBindable {
    typealias ViewModelType = RaceWinnerViewModel

    private var viewModel: RaceWinnerViewModel?

    func bind(viewModel: RaceWinnerViewModel) {
        self.viewModel = viewModel

        let hostingController = UIHostingController(rootView: RaceWinnerView(viewModel: viewModel))
        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)

        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        hostingController.didMove(toParent: self)
    }
}
