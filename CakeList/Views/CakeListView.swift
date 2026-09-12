//
//  CakeListView.swift
//  CakeList
//
//  Created by mahesh lad on 11/09/2026.
//
import SwiftUI

struct CakeListView: View {
    @State private var viewModel = CakeListViewModel()
    @State private var selectedCake: Cake?
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .idle, .loading:
                    ProgressView("Loading cakes...")
                    
                case .loaded(let cakes):
                    
                    List(cakes) { cake in
                        Button {
                            selectedCake = cake
                        } label: {
                            HStack(spacing: 12) {
                                AsyncImage(url: URL(string: cake.image)) { image in
                                    image.resizable().aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    Color.gray.opacity(0.2)
                                }
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(cake.title)
                                        .font(.headline)
                                    Text(cake.desc)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        // Fall down and fade-in animation
                        .transition(.move(edge: .top).combined(with: .opacity))
                    }
                    .animation(.easeOut(duration: 0.5), value: cakes)
                    
                case .error(let message):
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundStyle(.red)
                        Text("Failed to load cakes")
                            .font(.title3).bold()
                        Text(message)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                        
                        Button("Retry") {
                            Task { await viewModel.loadCakes() }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                }
            }
            .navigationTitle("Cakes")
            .task {
                if case .idle = viewModel.state {
                    await viewModel.loadCakes()
                }
            }
            .sheet(item: $selectedCake) { cake in
                VStack(alignment: .leading, spacing: 16) {
                    Text(cake.title)
                        .font(.title)
                        .bold()
                    Text(cake.desc)
                        .font(.body)
                    
                    Spacer()
                    AsyncImage(url: URL(string: cake.image)) { image in
                        image.resizable().aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Color.gray.opacity(0.2)
                    }
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Spacer()
                    Button("Close") {
                        selectedCake = nil
                    }
                    .buttonStyle(.borderedProminent)
                    .accessibilityIdentifier("cakePopupCloseButton")
                }
                .padding()
                .presentationDetents([.medium])
            }
            
        }
    }
}

#Preview {
    CakeListView(
        
    )
}
