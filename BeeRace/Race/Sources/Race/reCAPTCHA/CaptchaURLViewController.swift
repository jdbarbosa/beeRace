//
//  CaptchaURLViewController.swift
//  Race
//
//  Created by Joao Barbosa on 26/01/2026.
//

import UIKit
import WebKit

final class CaptchaURLViewController: UIViewController {

    private let url: URL
    private let webView = WKWebView()
    weak var delegate: RaceViewModelDelegate?

    init(
        url: URL,
        delegate: RaceViewModelDelegate?
    ) {
        self.url = url
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .pageSheet
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupWebView()
        setupCloseButton()
        loadCaptcha()
    }

    private func setupWebView() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupCloseButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(dismissSelf)
        )
    }

    private func loadCaptcha() {
        webView.load(URLRequest(url: url))
    }

    @objc private func dismissSelf() {
        dismiss(animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.delegate?.captchaViewControllerWasDismissed()
    }
}
