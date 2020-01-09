//
//  VendorView.swift
//  NextUpWeb
//
//  Created by Szymon Lorenz on 8/1/20.
//  Copyright © 2020 NextUp. All rights reserved.
//

import Foundation
import SwiftWebUI

struct Vendor: Identifiable {
    var id: Int?
    var ownerID: [String]?
    var createdAt: Date?
    var updatedAt: Date?
    var title: String?
    var description: String?
    var image: URL?
    
    func imageView() -> Image {
        if let url = image {
            return Image(url)
        }
        return Image.unsplash(size: UXSize(width: 200, height: 200))
    }
    
    var cardView: SUICard<Text> {
        return SUICard(imageView(), Text(title ?? ""), meta: Text(description ?? ""), content: {
            Text("Click to view")
        })
    }
}

struct VendorView: View {
    @State var vendors: [Vendor]
    
    var addNewCard: SUICard<Text> {
        return SUICard(
            Image.unsplash(size: UXSize(width: 60, height: 60), "Construction", "Building"),
            Text("Create Vendor"),
            meta: Text("Create an NextUp festival orginiser entity and start publishing festivals associated to it")
        ) { Text("Click to view") }
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                Button(action: {
                 print("ABC")
                }) { Text("Add Vendor") }
                Spacer()
            }
            SUICards {
                ForEach<[Vendor], SUICard<Text>>(vendors) { v in
                    return v.cardView
                }
            }.padding()
        }
    }
}

