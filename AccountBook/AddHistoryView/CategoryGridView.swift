//
//  CategoryGridView.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/03/09.
//

import Foundation
import SwiftUI

/// for ios 13
struct CategoryGridListView: View {
    private let columns: Int
    var viewModelWrapper: AddHistoryViewModelWrapper
    @State private var isShownKeyboard = false
    
    init(columns: Int, viewModelWrapper: AddHistoryViewModelWrapper) {
        self.columns = columns
        self.viewModelWrapper = viewModelWrapper
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                GridView(colums: columns, list: viewModelWrapper.categories) { category in
                    category.toView()
                        .onTapGesture {
                        viewModelWrapper.viewModel.selectCategory(category)
                        isShownKeyboard = true
                    }
                }
            }
            
            if isShownKeyboard {
                VStack {
                    Spacer()
                    KeyboardView(viewModelWrapper: viewModelWrapper)
                }
                .frame(maxHeight: .infinity)
            }
        }
        .onReceive(viewModelWrapper.viewModel.subject) { change in
            switch change {
            case .successToAdd:
                isShownKeyboard = false
            default: break
            }
        }
    }
        
    
}

@available(iOS 14.0, *)
struct CategoryVGridView: View {
    private let columns: Int
    var viewModelWrapper: AddHistoryViewModelWrapper
    @State private var isShownKeyboard = false
    
    init(columns: Int, viewModelWrapper: AddHistoryViewModelWrapper) {
        self.columns = columns
        self.viewModelWrapper = viewModelWrapper
    }
    
    let gridItems = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: gridItems, alignment: .center) {
                        ForEach(viewModelWrapper.categories) { category in
                            category.toView()
                                .onTapGesture {
                                    viewModelWrapper.viewModel.selectCategory(category)
                                    isShownKeyboard = true
                                }
                        }
                    }
                    .background(Color.yellow)
                }
                Spacer()
            }
            .frame(maxHeight: .infinity)
            
            if isShownKeyboard {
                VStack {
                    Spacer()
                    KeyboardView(viewModelWrapper: viewModelWrapper)
                }
                .frame(maxHeight: .infinity)
            }
                
        }
        .onReceive(viewModelWrapper.viewModel.subject) { change in
            switch change {
            case .successToAdd:
                isShownKeyboard = false
            default: break
            }
        }
    }
}
