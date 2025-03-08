//
//  GridView.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/03/09.
//

import Foundation
import SwiftUI

struct GridView<Content: View, T: Hashable>: View {
    private let colums: Int
    private var list: [[T]] = []
    private let content: (T) -> Content
    
    init(colums: Int, list: [T], @ViewBuilder content: @escaping (T) -> Content) {
        self.colums = colums
        self.content = content
        setup(list)
    }
    
    var body: some View {
        GeometryReader { geometry in
#if DEBUG
            let colors: [Color] = [.red, .blue, .black, .yellow]
#endif
            let spacing: CGFloat = 10 // 아이템 간 간격
            let totalSpacing = spacing * CGFloat(colums - 1)
            let width = (geometry.size.width - totalSpacing) / CGFloat(colums)
            
            VStack(alignment: .leading) {
                ForEach(0 ..< self.list.count, id: \.self) { i in
                    HStack(spacing: 10) {
                        ForEach(self.list[i], id: \.self) { object in
                            self.content(object)
                                .frame(width: width)
#if DEBUG
                                .background(colors[i % colums])
#endif
                        }
                    }
                }
            }
        }
    }
    
    private mutating func setup(_ list: [T]) {
        var column = 0
        var columnIndex = 0
        
        for object in list {
            if columnIndex < self.colums {
                if columnIndex == 0 {
                    self.list.insert([object], at: column)
                    
                } else {
                    self.list[column].append(object)
                    
                }
                columnIndex += 1
            } else {
                column += 1
                self.list.insert([object], at: column)
                columnIndex = 1
            }
        }
    }
    
}
