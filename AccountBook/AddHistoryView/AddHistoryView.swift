//
//  AddHistoryView.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/02/23.
//

import SwiftUI

struct AddHistoryView: View {
    @ObservedObject var viewModel: AddHistoryViewModelWrapper
    
    @State private var selectedIndex = 0
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, content: {
            ZStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        
                    }, label: {
                        Text("취소")
                    })
                    
                    Spacer()
                }
                Text("추가")
                    
            }
            .frame(maxWidth: .infinity)
            
            Picker("type", selection: $selectedIndex) {
                Text("지출").tag(0)
                Text("수입").tag(1)
                Text("이체").tag(2)
            }
            .pickerStyle(.segmented)
            makePageView()
        })
        .frame(maxWidth: .infinity, minHeight: 50, alignment: .top)
        .padding(.horizontal, 16)
        
    }
    
    private func makePageView() -> some View {
        
        if #available(iOS 14.0, *) {
            return pageViewFor14()
        } else {
            return pageViewControllerForUIKit()
        }
    }
    
    @available(iOS 14.0, *)
    private func pageViewFor14() -> some View {
        TabView(selection: $selectedIndex) {
            AddHistoryDIContainer.createSpendingView(viewModel).tag(0)
            AddHistoryDIContainer.createIncomingView(viewModel).tag(1)
            TransferView().tag(2)
        }
        .tabViewStyle(.page)
    }
    
    private func pageViewControllerForUIKit() -> some View {
        AddHistoryViewPageViewControllerWrapper(page: $selectedIndex, viewModel: self.viewModel)
    }
}


struct AddHistoryView_Previews: PreviewProvider {
    
    static var previews: AddHistoryView {
        AddHistoryDIContainer.createAddHistoryView()
    }
}

/// for category add ui
extension Category {
    func toView() -> some View {
        VStack(alignment: .center) {
            Image(image)
                .resizable()
                .frame(width: 40, height: 40)
            Text(title)
        }
    }
}
