//
//  SearchBarView.swift
//  Messenger
//
//  Created by user271419 on 12/17/24.
//

import SwiftUI
import Combine

class SearchObservable: ObservableObject {
    @Published var text: String = ""
    @Published var searchedText : String = ""
    private var cancellable: AnyCancellable?
    private let debounceDelay: TimeInterval = 0.5
    
    init() {
        cancellable = $text
            .debounce(for: .seconds(debounceDelay), scheduler: RunLoop.main)
            .sink { [weak self] text in
                self?.searchedText = text
            }
    }
}

struct SearchBarView: View {
    @ObservedObject var searchObservable: SearchObservable
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            TextField("Search", text: $searchObservable.text)
                .foregroundColor(.primary)
                .disableAutocorrection(true)
        }
        .padding(10)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}
