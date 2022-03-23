//
//  ExpandableList.swift
//  ExpandableList
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

import Foundation
import SwiftUI

struct ExpandableList<Content,Label>: View where  Content: View, Label: View {
    
    @State var isExpanded: Bool = false
    
    let label: () -> Label
    
    let children: () -> Content
    
    let hasDivider: Bool
    
    init(hasDivider: Bool = true, @ViewBuilder label: @escaping () -> Label, @ViewBuilder children: @escaping () -> Content) {
        self.label = label
        self.children = children
        self.hasDivider = hasDivider
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            content
                .contentShape(Rectangle())
                .clipped()
                .transition(.move(edge: .bottom))
                .onTapGesture {
                    withAnimation(.linear) {
                        isExpanded.toggle()
                    }
                }
            if hasDivider {
                Divider()
            }
        }
    }
    
    private var content: some View {
        VStack(alignment: .leading) {
            label()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.vertical], 10)
            if isExpanded {
                VStack(alignment: .leading) {
                    children()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
}

extension EnumeratedSequence {
    
    func array() -> Array<Self.Element> {
        Array(self)
    }
}
