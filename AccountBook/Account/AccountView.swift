//
//  AccountView.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/02/22.
//

import SwiftUI

struct AccountView: View {
    
    @ObservedObject var viewModel = AccountBookViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    VStack {
                        
                            Text("2025")
                            Text("2월")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                    
                    VStack {
                        Text("지출")
                        Text("2월")
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    
                    VStack {
                        Text("수입")
                        Text("2월")
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    VStack {
                        Text("잔액")
                        Text("2월")
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 16)
                }
                
                List(viewModel.hisotryDictionary.keys.sorted(), id: \.self) { key in
                    if let item = viewModel.hisotryDictionary[key] {
                        Section(header: Text("\(key)")) {
                            ForEach(item.list, id: \.self) { item in
                                AccountCell(data: item)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .viewDidload() {
            viewModel.loadData()
        }
    }
}

struct AccountCell: View {
    let data: AccountData
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Image(data.category.image).resizable().frame(width: 40, height: 40)
                    Text(data.title).font(.caption)
                    Spacer()
                    Text("\(data.money)").font(.caption)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                }
                .padding(.vertical, 10)
                Spacer()
                Color.red.frame(height: 1)
            }
            
            NavigationLink(destination: AccountDetailView()) {
                EmptyView()
            }.opacity(0)
            
        }
        .removeSeparator()
        
    }
}

//#Preview {
//    AccountView()
//}
