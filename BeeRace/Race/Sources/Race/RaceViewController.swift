//
//  RaceViewController.swift
//  Race
//
//  Created by Joao Barbosa on 26/01/2026.
//

import UIKit
import Protocols
import SwiftUI

@MainActor
final class RaceViewController: UIViewController, ViewModelBindable {

    func bind(viewModel: RaceViewModel) {
        self.bindOnMain(viewModel: viewModel)
        self.viewModel?.startNewRace()
    }

    typealias ViewModelType = RaceViewModel
    private var viewModel: RaceViewModel?

    @MainActor
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    private func bindOnMain(viewModel: RaceViewModel) {
        self.viewModel = viewModel
        let hostingController = UIHostingController(rootView: RaceView(viewModel: viewModel))
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

    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}

