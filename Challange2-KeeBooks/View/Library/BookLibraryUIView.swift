//
//  ContentView.swift
//  KeBooks
//
//  Created by Maya Maria Nainggolan on 20/05/26.
//

//
//  ContentView.swift
//  KeeBooks
//
//  Created by Fuad Agus Salim on 19/05/26.
//

import SwiftUI
import Combine
import UIKit

// MARK: - Model

struct Audiobook: Identifiable, Equatable {
    let id: UUID
    let title: String
    let author: String
    let coverImageName: String?
    let coverColors: [Color]

    static func == (lhs: Audiobook, rhs: Audiobook) -> Bool { lhs.id == rhs.id }
}

// MARK: - Sample Data

extension Audiobook {
    static let library: [Audiobook] = [
        Audiobook(id: UUID(), title: "The Hunger Games", author: "Suzanne Collins", coverImageName: nil,
                  coverColors: [Color(red:0.18,green:0.12,blue:0.08), Color(red:0.35,green:0.22,blue:0.10)]),
        Audiobook(id: UUID(), title: "Dune", author: "Frank Herbert", coverImageName: nil,
                  coverColors: [Color(red:0.72,green:0.60,blue:0.38), Color(red:0.52,green:0.42,blue:0.22)]),
        Audiobook(id: UUID(), title: "The Hobbit", author: "J.R.R. Tolkien", coverImageName: nil,
                  coverColors: [Color(red:0.20,green:0.35,blue:0.20), Color(red:0.14,green:0.25,blue:0.14)]),
        Audiobook(id: UUID(), title: "Ender's Game", author: "Orson Scott Card", coverImageName: nil,
                  coverColors: [Color(red:0.12,green:0.18,blue:0.32), Color(red:0.08,green:0.12,blue:0.22)]),
        Audiobook(id: UUID(), title: "The Alchemist", author: "Paulo Coelho", coverImageName: nil,
                  coverColors: [Color(red:0.65,green:0.45,blue:0.20), Color(red:0.45,green:0.30,blue:0.12)]),
        Audiobook(id: UUID(), title: "1984", author: "George Orwell", coverImageName: nil,
                  coverColors: [Color(red:0.22,green:0.22,blue:0.22), Color(red:0.12,green:0.12,blue:0.12)]),
        Audiobook(id: UUID(), title: "Brave New World", author: "Aldous Huxley", coverImageName: nil,
                  coverColors: [Color(red:0.30,green:0.18,blue:0.35), Color(red:0.20,green:0.10,blue:0.25)]),
        Audiobook(id: UUID(), title: "Foundation", author: "Isaac Asimov", coverImageName: nil,
                  coverColors: [Color(red:0.15,green:0.28,blue:0.38), Color(red:0.08,green:0.18,blue:0.28)]),
        Audiobook(id: UUID(), title: "The Martian", author: "Andy Weir", coverImageName: nil,
                  coverColors: [Color(red:0.55,green:0.22,blue:0.10), Color(red:0.38,green:0.14,blue:0.06)]),
        Audiobook(id: UUID(), title: "Sapiens", author: "Yuval Noah Harari", coverImageName: nil,
                  coverColors: [Color(red:0.18,green:0.32,blue:0.38), Color(red:0.10,green:0.22,blue:0.28)]),
        Audiobook(id: UUID(), title: "Educated", author: "Tara Westover", coverImageName: nil,
                  coverColors: [Color(red:0.38,green:0.32,blue:0.22), Color(red:0.25,green:0.20,blue:0.12)]),
        Audiobook(id: UUID(), title: "Atomic Habits", author: "James Clear", coverImageName: nil,
                  coverColors: [Color(red:0.12,green:0.22,blue:0.18), Color(red:0.08,green:0.15,blue:0.12)]),
    ]
}

// MARK: - ViewModel

@MainActor
final class LibraryViewModel: ObservableObject {
    @Published private(set) var books: [Audiobook] = Audiobook.library
    @Published private(set) var selectedID: UUID? = nil

    func select(_ book: Audiobook) {
        let newID = selectedID == book.id ? selectedID : book.id
        guard selectedID != book.id else { return }
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        withAnimation(.spring(response: 0.32, dampingFraction: 0.72)) {
            selectedID = newID
        }
    }

    func isSelected(_ book: Audiobook) -> Bool { selectedID == book.id }
}

// MARK: - Book Cover View

struct BookCoverView: View {
    let book: Audiobook
    let size: CGSize

    var body: some View {
        RoundedRectangle(cornerRadius: 6, style: .continuous)
            .fill(
                LinearGradient(
                    colors: book.coverColors,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(width: size.width, height: size.height)
            .overlay(
                VStack(spacing: 2) {
                    Text(book.title)
                        .font(.system(size: min(size.width * 0.13, 11), weight: .bold))
                        .foregroundColor(.white.opacity(0.90))
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                        .padding(.horizontal, 4)
                    Text(book.author)
                        .font(.system(size: min(size.width * 0.10, 8), weight: .regular))
                        .foregroundColor(.white.opacity(0.65))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .padding(.horizontal, 4)
                }
                .padding(.vertical, 6)
            )
            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
    }
}

// MARK: - AudiobookCard

struct AudiobookCard: View {
    let book: Audiobook
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Cover + Info Row
            HStack(alignment: .top, spacing: 10) {
                GeometryReader { geo in
                    BookCoverView(book: book, size: CGSize(width: geo.size.width, height: geo.size.width * 1.4))
                }
                .aspectRatio(1/1.4, contentMode: .fit)
                .frame(width: 70)

                VStack(alignment: .leading, spacing: 3) {
                    Text(book.title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                        .lineLimit(3)
                        .fixedSize(horizontal: false, vertical: true)

                    Text(book.author)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(Color(red: 0.50, green: 0.50, blue: 0.52))
                        .lineLimit(2)
                }
                .padding(.top, 2)

                Spacer(minLength: 0)
            }
            .padding(.horizontal, 12)
            .padding(.top, 12)

            Spacer(minLength: 8)

            // Divider
            Divider()
                .padding(.horizontal, 12)

            // Pick Button
            Button(action: onTap) {
                HStack(spacing: 6) {
                    if isSelected {
                        Image(systemName: "checkmark")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(Color(red: 0.20, green: 0.72, blue: 0.35))
                    } else {
                        Image(systemName: "hand.point.up.left.fill")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(Color(red: 0.25, green: 0.50, blue: 0.95))
                    }

                    Text(isSelected ? "Tonight's Pick" : "Pick")
                        .font(.system(size: 15, weight: isSelected ? .semibold : .regular))
                        .foregroundColor(
                            isSelected
                                ? Color(red: 0.20, green: 0.72, blue: 0.35)
                                : Color(red: 0.25, green: 0.50, blue: 0.95)
                        )
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 11)
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 12)
        }
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(red: 0.97, green: 0.97, blue: 0.97))
                .shadow(
                    color: isSelected
                        ? Color(red: 0.20, green: 0.72, blue: 0.35).opacity(0.18)
                        : Color.black.opacity(0.08),
                    radius: isSelected ? 12 : 6,
                    x: 0,
                    y: isSelected ? 4 : 2
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(
                    isSelected
                        ? Color(red: 0.20, green: 0.72, blue: 0.35).opacity(0.35)
                        : Color.clear,
                    lineWidth: 1.0
                )
        )
        .scaleEffect(isSelected ? 1.015 : 1.0)
        .animation(.spring(response: 0.30, dampingFraction: 0.70), value: isSelected)
    }
}

// MARK: - Tab Bar Item Model

struct TabItem {
    let title: String
    let icon: String
    let selectedIcon: String
}

// MARK: - LibraryView

struct LibraryView: View {
    @StateObject private var vm = LibraryViewModel()
    @State private var selectedTab: Int = 1

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
    ]

    private let tabs: [TabItem] = [
        TabItem(title: "Home",     icon: "house",              selectedIcon: "house.fill"),
        TabItem(title: "Library",  icon: "books.vertical",     selectedIcon: "books.vertical.fill"),
        TabItem(title: "Activity", icon: "clock",              selectedIcon: "clock.fill"),
        //TabItem(title: "Search",   icon: "magnifyingglass",    selectedIcon: "magnifyingglass"),
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Main scroll content
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    // Large Title Header
                    Text("Library")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(Color(red: 0.10, green: 0.10, blue: 0.10))
                        .padding(.horizontal, 20)
                        .padding(.top, 16)
                        .padding(.bottom, 20)

                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(vm.books) { book in
                            AudiobookCard(
                                book: book,
                                isSelected: vm.isSelected(book),
                                onTap: { vm.select(book) }
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                }
            }
            .background(Color(red: 0.93, green: 0.94, blue: 0.95))

            // Tab Bar
            tabBar
        }
        .ignoresSafeArea(edges: .bottom)
        .preferredColorScheme(.light)
    }

    // MARK: Tab Bar
    private var tabBar: some View {
        VStack(spacing: 0) {
            Divider()
                .foregroundColor(Color(white: 0.88))

            HStack(spacing: 0) {
                ForEach(Array(tabs.enumerated()), id: \.offset) { index, tab in
                    Button {
                        selectedTab = index
                    } label: {
                        VStack(spacing: 4) {
                            if index == 1 && selectedTab == 1 {
                                // Library selected — pill background
                                Image(systemName: tab.selectedIcon)
                                    .font(.system(size: 22, weight: .semibold))
                                    .foregroundColor(Color(red: 0.25, green: 0.50, blue: 0.95))
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 6)
                                    .background(
                                        Capsule()
                                            .fill(Color(red: 0.88, green: 0.92, blue: 1.00))
                                    )
                            } else {
                                Image(systemName: selectedTab == index ? tab.selectedIcon : tab.icon)
                                    .font(.system(size: 22, weight: selectedTab == index ? .semibold : .regular))
                                    .foregroundColor(
                                        selectedTab == index
                                            ? Color(red: 0.25, green: 0.50, blue: 0.95)
                                            : Color(red: 0.48, green: 0.48, blue: 0.50)
                                    )
                                    .padding(.vertical, 6)
                            }

                            Text(tab.title)
                                .font(.system(size: 10, weight: .regular))
                                .foregroundColor(
                                    selectedTab == index
                                        ? Color(red: 0.25, green: 0.50, blue: 0.95)
                                        : Color(red: 0.48, green: 0.48, blue: 0.50)
                                )
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.top, 10)
            .padding(.bottom, 28)
            .background(Color(red: 0.97, green: 0.97, blue: 0.98))
        }
    }
}

// MARK: - Previews

//#Preview("Library") {
//    LibraryView()
//}
//
//#Preview("Card – Unselected") {
//    ZStack {
//        Color(red: 0.93, green: 0.94, blue: 0.95).ignoresSafeArea()
//        AudiobookCard(book: Audiobook.library[0], isSelected: false, onTap: {})
//            .padding(24)
//    }
//}
//
//#Preview("Card – Selected") {
//    ZStack {
//        Color(red: 0.93, green: 0.94, blue: 0.95).ignoresSafeArea()
//        AudiobookCard(book: Audiobook.library[1], isSelected: true, onTap: {})
//            .padding(24)
//    }
//}

