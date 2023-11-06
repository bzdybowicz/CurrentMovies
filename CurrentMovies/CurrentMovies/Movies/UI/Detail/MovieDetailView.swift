//
//  MovieDetailView.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import UIKit

final class MovieDetailView: UIView {

    private let viewModel: MovieDetailViewModelProtocol

    init(viewModel: MovieDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension MovieDetailView {

    func setup() {
        backgroundColor = .white
    }

    func setupImage() {

    }

    func setupTitle() {

    }

    func setupDateLabel() {

    }

    func setupOverView() {

    }
}
