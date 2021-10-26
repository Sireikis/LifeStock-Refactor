//
//  TipJar.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/14/21.
//

import SwiftUI

extension SettingsScreenView {
    
    struct TipJar: View {
        
        var viewModel: ViewModel
        
        var body: some View {
            Form {
                if viewModel.canMakePayments() {
                    List(viewModel.myProducts, id: \.self) { product in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(product.localizedTitle)
                                    .font(.headline)
                                Text(product.localizedDescription)
                                    .font(.caption2)
                            }
                            Spacer()
                            
                            Button(action: {
                                viewModel.purchaseProduct(product: product)
                            }) {
                                Text("$\(product.price)")
                            }
                            .foregroundColor(.blue)
                        }
                    }
                } else {
                    Text("In-App Purchases are disabled on this device.")
                }
            }
            .navigationTitle("Tip Jar")
        }
    }
}
