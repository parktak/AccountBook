//
//  CategoryGridView.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/03/09.
//

import Foundation
import SwiftUI

/// for ios 13
struct CategoryGridListView: CategoryGridBaseView {
    private let columns: Int
    var viewModelWrapper: AddHistoryViewModelWrapper
    @State private var isShownKeyboard = false
    
    init(columns: Int, viewModelWrapper: AddHistoryViewModelWrapper) {
        self.columns = columns
        self.viewModelWrapper = viewModelWrapper
    }
    
    func setShownKeyboard(_ isShown: Bool) {
        self.isShownKeyboard = isShown
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                GridView(colums: columns, list: viewModelWrapper.categories) { category in
                    category.toView()
                        .onTapGesture {
                            viewModelWrapper.viewModel.excuteCategoryEvent(category)
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
            excuteBindingEvent(change)
        }
    }
        
    
}

@available(iOS 14.0, *)
struct CategoryVGridView: CategoryGridBaseView {
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
    
    func setShownKeyboard(_ isShown: Bool) {
        self.isShownKeyboard = isShown
    }
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: gridItems, alignment: .center) {
                        ForEach(viewModelWrapper.categories) { category in
                            category.toView()
                                .onTapGesture {
                                    viewModelWrapper.viewModel.excuteCategoryEvent(category)
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
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: isShownKeyboard)
            }
                
        }
        .onReceive(viewModelWrapper.viewModel.subject) { change in
            excuteBindingEvent(change)
        }
    }

}

// ios 13, 14 한번에 처리 할 수 있도록
fileprivate protocol CategoryGridBaseView: View {
    func setShownKeyboard(_ isShown: Bool)
}

fileprivate extension CategoryGridBaseView {
    
    func showAddCategoryView() {
        
    }
    
    func excuteBindingEvent(_ change: AddHistoryUIChange) {
        switch change {
        case .addHistory:
            setShownKeyboard(true)
            
        case .successToAdd:
            setShownKeyboard(false)
            
        case .addCategory:
            showAddCategoryView()
        default: break
        }
    }
}
