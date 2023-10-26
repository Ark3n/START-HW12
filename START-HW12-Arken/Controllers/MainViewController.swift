//
//  ViewController.swift
//  START-HW12-Arken
//
//  Created by Arken Sarsenov on 22.10.2023.
//

import UIKit
import SnapKit
import SwiftUI

final class MainViewController: UIViewController {
    // MARK: - Properties
    private var isWorkTime = true
    private var isStarted = false
    
    private var timer = Timer()
    private var timerInFocusState = 20
    private var timerInRelaxState = 10
    private lazy var timerDuration = timerInFocusState
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.text = "\(timerDuration)"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    private var startPoint = CGFloat(-Double.pi / 2)
    private var endPoint = CGFloat(3 * Double.pi / 2)
    private lazy var path: UIBezierPath = {
        let path = UIBezierPath(arcCenter: view.center, radius: 100, startAngle: startPoint, endAngle: endPoint, clockwise: true)
        return path
    }()
    private lazy var backCirclerLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeColor = UIColor.systemRed.withAlphaComponent(0.3).cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 10
        return layer
    }()
    private lazy var progressCirclerLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeColor = UIColor.systemRed.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 10
        layer.strokeEnd = 0
        layer.lineCap = .round
        return layer
    }()
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "play.circle"), for: .normal)
        button.tintColor = .systemRed
        button.addTarget(self, action: #selector(handleStartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var pauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        button.tintColor = .systemRed
        button.isEnabled = false
        button.addTarget(self, action: #selector(handlePauseButtonTapped), for: .touchUpInside)
        return button
    }()
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup Views
    private func setupUI() {
        let buttonsStackView = UIStackView(arrangedSubviews: [startButton, pauseButton])
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 8
        view.backgroundColor = .black
        view.layer.addSublayer(backCirclerLayer)
        view.layer.addSublayer(progressCirclerLayer)
        [timerLabel, buttonsStackView].forEach{view.addSubview($0)}
        timerLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        buttonsStackView.snp.makeConstraints {
            $0.top.equalTo(timerLabel.snp_bottomMargin).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - ProgressBar style Timer state
    private func getTimerMode(_ isWorking: Bool) {
        progressCirclerLayer.resetAnimation()
        if isWorking {
            timerDuration = timerInFocusState
            timerLabel.text = "\(timerDuration)"
            timerLabel.textColor = .systemRed
            backCirclerLayer.strokeColor = UIColor.systemRed.withAlphaComponent(0.3).cgColor
            progressCirclerLayer.strokeColor = UIColor.systemRed.cgColor
            startButton.tintColor = .systemRed
            pauseButton.tintColor = .systemRed
        } else {
            timerDuration = timerInRelaxState
            timerLabel.text = "\(timerDuration)"
            timerLabel.textColor = .systemGreen
            backCirclerLayer.strokeColor = UIColor.systemGreen.withAlphaComponent(0.3).cgColor
            progressCirclerLayer.strokeColor = UIColor.systemGreen.cgColor
            startButton.tintColor = .systemGreen
            pauseButton.tintColor = .systemGreen
        }
    }
    
    //MARK: - Actions
    @objc private func handleStartButtonTapped() {
        isStarted = !isStarted
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        if timerDuration == timerInFocusState || timerDuration == timerInRelaxState {
            progressCirclerLayer.startAnimation(timer: timerDuration)
        } else {
            progressCirclerLayer.resumeAnimations()
        }
        startButton.isEnabled = false
        pauseButton.isEnabled = true
    }
    @objc private func handlePauseButtonTapped() {
        timer.invalidate()
        progressCirclerLayer.pauseAnimations()
        pauseButton.isEnabled = false
        startButton.isEnabled = true
    }
    @objc private func updateTimer() {
        timerDuration -= 1
        timerLabel.text = "\(timerDuration)"
        if timerDuration == 0 {
            timer.invalidate()
            isWorkTime = !isWorkTime
            getTimerMode(isWorkTime)
            pauseButton.isEnabled = false
            startButton.isEnabled = true
        }
    }
}

// MARK: - Preview Provider SwiftUI
struct Provider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            MainViewController()
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}
