//
//  KeyboardView.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/03/11.
//

import SwiftUI

struct KeyboardView: View {
    @ObservedObject var viewModelWrapper: AddHistoryViewModelWrapper
    
    init(viewModelWrapper: AddHistoryViewModelWrapper) {
        self.viewModelWrapper = viewModelWrapper
     
    }
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width / 4 - 10
            let spacing: CGFloat = 2
            VStack(spacing: spacing) {
                Spacer()
                HStack {
                    
                    Text(viewModelWrapper.calculatorData)
                }
                
                createHStack {
                    createNumberButton(7, width: width)
                    createNumberButton(8, width: width)
                    createNumberButton(9, width: width)
                    createFunctionButton("*", width: width)
                }
                
                createHStack {
                    createNumberButton(4, width: width)
                    createNumberButton(5, width: width)
                    createNumberButton(6, width: width)
                    createFunctionButton("-", width: width)
                }
                
                createHStack {
                    createNumberButton(1, width: width)
                    createNumberButton(2, width: width)
                    createNumberButton(3, width: width)
                    createFunctionButton("+", width: width)
                }
                
                createHStack {
                    createFunctionButton(".", width: width, bgColor: .blue)
                    createNumberButton(0, width: width, height: width)
                    createRemoveButton(width: width)
                    createFunctionButton("=", width: width)
                }
            }
        }
    }
    
    private func createHStack(spacing: CGFloat = 2, @ViewBuilder view: @escaping () -> some View) -> some View {
        
        HStack(spacing: spacing) {
            Spacer()
            view()
            Spacer()
        }
    }
    private func createNumberButton(_ value: Int, width: CGFloat, height: CGFloat? = nil) -> some View {
        let _height = height ?? width
        
        return Button(action: {
            print(value)
            viewModelWrapper.viewModel.addCalcData("\(value)")
        }, label: {
            Text("\(value)")
        })
        .frame(width: width, height: _height)
        .background(Color.blue)
    }
    private func createFunctionButton(_ value: String, width: CGFloat, height: CGFloat? = nil, bgColor: Color? = nil) -> some View {
        let _height = height ?? width
        let color = bgColor ?? Color.orange
        return Button(action: {
            print(value)
            viewModelWrapper.viewModel.addCalcData(value)
        }, label: {
            Text("\(value)")
        })
        .frame(width: width, height: _height)
        .background(color)
    }
    
    private func createRemoveButton(width: CGFloat, height: CGFloat? = nil) -> some View {
        let _height = height ?? width
        
        return Button(action: {
            viewModelWrapper.viewModel.removeLast()
        }, label: {
            Text("<X")
        })
        .frame(width: width, height: _height)
        .background(Color.blue)
    }
}

//struct KeyboardView_Preview: PreviewProvider {
//    static var previews: KeyboardView {
//        let viewModel = AddHistoryViewModel()
//        let wrapper = AddHistoryDIContainer.createAddHistoryViewModelWrapper(viewModel: viewModel, type: .spending)
//        return KeyboardView(viewModelWrapper: wrapper)
//    }
//}
