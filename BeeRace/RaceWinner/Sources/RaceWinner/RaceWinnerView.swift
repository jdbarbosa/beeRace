//
//  RaceWinnerView.swift
//  RaceWinner
//
//  Created by Joao Barbosa on 26/01/2026.
//

import SwiftUI
import Models

struct RaceWinnerView: View {
    let viewModel: RaceWinnerViewModel

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                VStack(spacing: 0) {
                    Text("Winner")
                        .font(.largeTitle)
                        .padding(.vertical)

                    Image("bee_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                        .padding(12)
                        .background(Color(hex: viewModel.winnerBee.color))
                        .clipShape(Circle())
                        .padding()

                    VStack(alignment: .center, spacing: 0) {
                        Text("1st")
                            .font(.body)
                            .padding(.bottom, 4)
                        Text(viewModel.winnerBee.name)
                            .font(.caption)
                    }
                    Spacer()
                }
                VStack(spacing: 0) {
                    Button {
                        viewModel.restartRace()
                    } label: {
                        Text("Restart Bee Race")
                            .fontWeight(.semibold)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

struct RaceWinnerView_Previews: PreviewProvider {

    static var previews: some View {
        RaceWinnerView(
            viewModel: RaceWinnerViewModel(
                winnerBee: Bee(name: "Bee 1", color: "#FF0000"),
                router: RaceWinnerDummyRouter(),
                delegate: nil
            )
        )
    }
}

final class RaceWinnerDummyRouter: RaceWinnerRouter {
    func newRace() { }
}

// TODO: Move this to dedicated package
extension Color {
    init?(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexString = hexString.replacingOccurrences(of: "#", with: "")
        guard hexString.count == 6 else { return nil }

        let scanner = Scanner(string: hexString)
        var rgb: UInt64 = 0

        guard scanner.scanHexInt64(&rgb) else { return nil }

        let r = Double((rgb & 0xFF0000) >> 16) / 255.0
        let g = Double((rgb & 0x00FF00) >> 8) / 255.0
        let b = Double(rgb & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}
