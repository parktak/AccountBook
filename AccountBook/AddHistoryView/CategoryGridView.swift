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
    private var list: [Category]
    
    init(columns: Int, list: [Category]) {
        self.columns = columns
        self.list = list
    }
    
    var body: some View {
        ScrollView {
            GridView(colums: columns, list: list) { category in
                category.toView()
            }
        }
    }
    
}

@available(iOS 14.0, *)
struct CategoryVGridView: View {
    private let columns: Int
    private var list: [Category]
    
    init(columns: Int, list: [Category]) {
        self.columns = columns
        self.list = list
    }
    
    let gridItems = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: gridItems, alignment: .center) {
                    ForEach(list) { category in
                        category.toView()
                    }
                }
                .background(Color.yellow)
            }
            Spacer()
        }
    }
}
