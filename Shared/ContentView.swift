//
//  ContentView.swift
//  Shared
//
//  Created by Kiarash Vosough on 3/23/22.
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import SwiftUI

struct ContentView: View {
    
    private struct ItemL: Identifiable {
        var id = UUID()
        var expanded: Bool = false
    }
    
    private var items: [ItemL] = [ItemL(),ItemL(),ItemL(),ItemL(),ItemL(),ItemL(),ItemL(),ItemL(),ItemL(),ItemL()]
    
    @State private var flags: [Bool] = Array(repeating: false, count: 10)
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView { // use scrollview, there is a problem with list animation
                ForEach(Array(items.enumerated()), id: \.1.id) { i, item in
                    ExpandableList {
                        Text(item.id.uuidString.prefix(10))
                            .frame(width: proxy.size.width , alignment: .leading)
                    } children: {
                        ExpandableList(hasDivider: false) {
                            Text(item.id.uuidString.prefix(10))
                        } children: {
                            VStack {
                                Text(item.id.uuidString.prefix(3))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.blue.opacity(0.5))
                                Spacer(minLength: 5)
                                Text(item.id.uuidString.prefix(3))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.blue.opacity(0.5))
                            }
                            .onTapGesture {
                                print("inner items")
                            }
                        }
                    }
                }
                .padding([.horizontal], 10)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
