//
//  RaceViewModelDelegate.swift
//  Race
//
//  Created by Joao Barbosa on 26/01/2026.
//

@MainActor
protocol RaceViewModelDelegate: AnyObject {
    func captchaViewControllerWasDismissed()
}
