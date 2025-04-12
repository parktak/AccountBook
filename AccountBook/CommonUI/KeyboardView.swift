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
            HStack {
                VStack {
                    VStack(spacing: spacing) {
                        HStack {
                            TextField("제목을 입력해주세요", text: Binding<String>(
                                get: { viewModelWrapper.title },
                                set: { viewModelWrapper.viewModel.setTitle($0)}))
                            .frame(width: width * 4 + (spacing * 3), height: 25)
                            .background(Color.white)
                        }
                        
                        createHStack {
                            HStack {
                                Text(viewModelWrapper.calculatorData)
//                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            }
                            .frame(maxWidth: width * 3 + (spacing * 2), maxHeight: .infinity, alignment: .leading)
                            .background(Color.white)
                            
                            Button(action: {
                                hideKeyboard() {
                                    self.viewModelWrapper.viewModel.add()
                                }
                                
                            }, label: {
                                Text("저장")
                            })
                            .frame(width: width, height: 25)
                            .background(Color.orange)
                        }
                        .frame(maxHeight: 25)
                        
                        createCalculatorView(width, spacing: spacing)
                    }
                    .background(Color.gray)
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                
            }
            .keyboardAdaptive()
            
        }
        
    }
    
    private func createCalculatorView(_ width: CGFloat, spacing: CGFloat) -> some View {
        
        VStack(spacing: spacing) {
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

#if canImport(UIKit)
extension View {
    func hideKeyboard(_ completion: (() -> Void)?) {
        UIView.animate(withDuration: 0, animations: {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }, completion: { _ in
            completion?()
        })
        
    }
}
#endif

//struct KeyboardView_Preview: PreviewProvider {
//    static var previews: KeyboardView {
//        let viewModel = AddHistoryViewModel()
//        let wrapper = AddHistoryDIContainer.createAddHistoryViewModelWrapper(viewModel: viewModel, type: .spending)
//        return KeyboardView(viewModelWrapper: wrapper)
//    }
//}
