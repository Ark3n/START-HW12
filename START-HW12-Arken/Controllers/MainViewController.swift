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
 
    
// MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
    }
    
// MARK: - UI Configuration
    private func configureUI() {
        
    }
    private func configureConstraints() {
        
    }
}

// MARK: - Prrview Provider SwiftUI
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
