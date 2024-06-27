//
//  RefreshableScrollView.swift
//  byt8
//
//  Created by Will Sather on 6/28/21.
//

import Foundation
import SwiftUI

struct RefreshableScrollView<Content: View>: UIViewRepresentable {
    
    var content: Content
    var onRefresh: (UIRefreshControl) -> ()
    var refreshControl = UIRefreshControl()
    
    // View builder to capture swiftui view ...
    init(@ViewBuilder content: @escaping ()-> Content, onRefresh: @escaping (UIRefreshControl) -> ()) {
        self.content = content()
        self.onRefresh = onRefresh
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        
        let uiscrollView = UIScrollView()
        
        refreshControl.addTarget(context.coordinator, action: #selector(context.coordinator.onRefresh), for: .valueChanged)
        
        setUpView(uiscrollView: uiscrollView)
        
        uiscrollView.refreshControl = refreshControl
        
        return uiscrollView
        
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // Because view is not dynamically updating
        // Updating view dynamically
        setUpView(uiscrollView: uiView)
    }
    
    func setUpView(uiscrollView: UIScrollView) {
        
        let hostView = UIHostingController(rootView: content.frame(maxHeight: .infinity, alignment: .top))
        
        hostView.view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            hostView.view.topAnchor.constraint(equalTo: uiscrollView.topAnchor),
            hostView.view.bottomAnchor.constraint(equalTo: uiscrollView.bottomAnchor),
            hostView.view.leadingAnchor.constraint(equalTo: uiscrollView.leadingAnchor),
            hostView.view.trailingAnchor.constraint(equalTo: uiscrollView.trailingAnchor),
            hostView.view.widthAnchor.constraint(equalTo: uiscrollView.widthAnchor),
            hostView.view.heightAnchor.constraint(greaterThanOrEqualTo: uiscrollView.heightAnchor, constant: 1),
        ]
        
        // Removing previously added view
        uiscrollView.subviews.last?.removeFromSuperview()

        // Add View
        uiscrollView.addSubview(hostView.view)
        
        // Constrain View
        uiscrollView.addConstraints(constraints)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject {
        var parent: RefreshableScrollView
        
        init(parent: RefreshableScrollView) {
            self.parent = parent
        }
        
        @objc func onRefresh() {
            parent.onRefresh(parent.refreshControl)
        }
    }
    
} // End ScrollableView

