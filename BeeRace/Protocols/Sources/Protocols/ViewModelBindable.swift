//
//  ViewModelBindable.swift
//  Protocols
//
//  Created by Joao Barbosa on 26/01/2026.
//

import UIKit

/// Protocol that subclassers should implement to conform with MVVM design pattern
public protocol ViewModelBindable {

    // This associatedtype defines the class of the view model that the
    // implementer will use.
    associatedtype ViewModelType

    @MainActor
    func bind(viewModel: ViewModelType)
}

public protocol ViewModel {
    // MARK: - types -

    /// The concrete type of View that the receiver corresponds to.
    associatedtype ViewControllerType: UIViewController & ViewModelBindable where ViewControllerType.ViewModelType == Self

}
