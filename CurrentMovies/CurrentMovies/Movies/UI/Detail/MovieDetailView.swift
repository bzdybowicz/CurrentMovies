//
//  MovieDetailView.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import Combine
import UIKit

final class MovieDetailView: UIView {

    private let viewModel: MovieDetailViewModelProtocol

    private let verticalStackView = UIStackView()
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    private let dateHorizontalStack = UIStackView()
    private let dateLabel = UILabel()
    private let dateValueLabel = UILabel()
    private let overViewLabel = UILabel()

    private var imageHeightConstraint: NSLayoutConstraint?
    private var cancellables: Set<AnyCancellable> = []

    init(viewModel: MovieDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
        bind()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension MovieDetailView {

    func bind() {
        titleLabel.text = viewModel.item.title
        dateLabel.text = viewModel.releaseDateText
        dateValueLabel.text = viewModel.item.releaseDate
        overViewLabel.text = viewModel.item.overview

        viewModel
            .imagePublisher
            .sink(receiveValue: { [weak self] image in
                self?.imageView.image = image
            })
            .store(in: &cancellables)

        viewModel
            .imageRatioPublisher
            .sink(receiveValue: { [weak self] value in
                guard let self else { return }
                self.imageHeightConstraint?.constant = value * self.imageView.frame.size.width
                self.setNeedsLayout()
                self.layoutIfNeeded()
            })
            .store(in: &cancellables)
    }

    func setup() {
        backgroundColor = .white
        setupStack()
        setupTitle()
        setupImage()
        setupDateLabel()
        setupOverView()
    }

    func setupStack() {
        addSubview(verticalStackView)
        verticalStackView.axis = .vertical
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }

    func setupImage() {
        verticalStackView.addArrangedSubview(imageView)
        let height = imageView.heightAnchor.constraint(equalToConstant: 200)
        height.isActive = true
        imageHeightConstraint = height
    }

    func setupTitle() {
        verticalStackView.addArrangedSubview(titleLabel)
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    }

    func setupDateLabel() {
        verticalStackView.addArrangedSubview(dateHorizontalStack)
        verticalStackView.setCustomSpacing(40, after: dateHorizontalStack)
        dateHorizontalStack.axis = .horizontal
        dateHorizontalStack.distribution = .equalSpacing
        dateHorizontalStack.addArrangedSubview(dateLabel)
        dateHorizontalStack.addArrangedSubview(dateValueLabel)
    }

    func setupOverView() {
        verticalStackView.addArrangedSubview(overViewLabel)
        overViewLabel.textAlignment = .center
        overViewLabel.numberOfLines = 0
        overViewLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
