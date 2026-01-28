import XCTest
import Models
import RaceWinner
@testable import APIClient
@testable import Race

final class RaceTests: XCTestCase {
    func testViewModelRoutesToWinnerWhenTimerFinishes() async {
        let expectation = expectation(description: "Routes to race winner")
        let bee = Bee(name: "BeeGees", color: "#8d62a1")
        let router = MockRaceRouter(
            onRouteToWinner: { winner in
                XCTAssertEqual(winner, bee)
                expectation.fulfill()
            },
            onRouteToCaptcha: {
                // NO-OP
            }
        )
        let repository = MockRaceRepository(duration: 1, bees: [bee])
        let viewModel = await MainActor.run {
            RaceViewModel(router: router, repository: repository)
        }

        await MainActor.run {
            viewModel.startNewRace()
        }

        await fulfillment(of: [expectation], timeout: 3.0)
    }

    func testViewModelRoutesToCaptchaWhenRequestisForbidden() async {
        let expectation = expectation(description: "Routes to captcha on forbidden requets")

        let router = MockRaceRouter(
            onRouteToWinner: { _ in },
            onRouteToCaptcha: {
                expectation.fulfill()
            }
        )
        let repository = FailingMockRepository(
            duration: 1,
            captchaResponse: CaptchaResponse(captchaUrl: "www.google.com/userverify")
        )
        let viewModel = await MainActor.run {
            RaceViewModel(router: router, repository: repository)
        }

        await MainActor.run {
            viewModel.startNewRace()
        }

        await fulfillment(of: [expectation], timeout: 3.0)
    }
}

private final class MockRaceRouter: RaceRouter {
    func routeToCaptcha(captchaURL: URL, raceViewModelDelegate: (any Race.RaceViewModelDelegate)?) {
        onRouteToCaptcha()
    }
    
    func routeToWinner(winnerBee: Models.Bee, delegate: (any RaceWinner.RaceWinnerRestartable)?) {
        onRouteToWinner(winnerBee)
    }
    
    private let onRouteToWinner: (Bee) -> Void
    private let onRouteToCaptcha: () -> Void

    init(
        onRouteToWinner: @escaping (Bee) -> Void,
        onRouteToCaptcha: @escaping () -> Void
    ) {
        self.onRouteToWinner = onRouteToWinner
        self.onRouteToCaptcha = onRouteToCaptcha
    }
}

private final class MockRaceWinnerRestartable: RaceWinner.RaceWinnerRestartable {
    func didPressRestartRaceButton() {}
}

private final class MockRaceViewModelDelegate: RaceViewModelDelegate {
    func captchaViewControllerWasDismissed() {}
}


private final class MockRaceRepository: RaceRepository {
    private let duration: Int
    private let bees: [Bee]

    init(duration: Int, bees: [Bee]) {
        self.duration = duration
        self.bees = bees
    }

    func duration() async throws -> DurationResponse {
        DurationResponse(timeInSeconds: duration)
    }

    func raceStatus() async throws -> RaceStatusRaceResponse {
        RaceStatusRaceResponse(beeList: bees)
    }
}

private final class FailingMockRepository: RaceRepository {
    private let duration: Int
    private let captchaResponse: CaptchaResponse

    init(duration: Int, captchaResponse: CaptchaResponse) {
        self.duration = duration
        self.captchaResponse = captchaResponse
    }

    func duration() async throws -> DurationResponse {
        DurationResponse(timeInSeconds: duration)
    }

    func raceStatus() async throws -> RaceStatusRaceResponse {
        let url = URL(string: captchaResponse.captchaUrl)
        throw APIError.forbidden(captchaURL: url)
    }
}
