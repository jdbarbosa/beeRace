// The Swift Programming Language
// https://docs.swift.org/swift-book

public protocol RaceWinnerRestartable: AnyObject {

    @MainActor
    func didPressRestartRaceButton()
}
