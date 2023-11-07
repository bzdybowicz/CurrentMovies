// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum ApiKey {
    internal enum Alert {
      /// Once entered, it will be stored securely and reused.
      internal static let message = L10n.tr("Localizable", "apiKey.alert.message", fallback: "Once entered, it will be stored securely and reused.")
      /// Enter API key
      internal static let placeholder = L10n.tr("Localizable", "apiKey.alert.placeholder", fallback: "Enter API key")
      /// Localizable.strings
      ///   CurrentMovies
      /// 
      ///   Created by Bartlomiej Zdybowicz on 06/11/2023.
      internal static let title = L10n.tr("Localizable", "apiKey.alert.title", fallback: "Api key is required to work with TMDB API")
    }
  }
  internal enum Detail {
    internal enum ReleaseDate {
      /// Release date
      internal static let label = L10n.tr("Localizable", "detail.releaseDate.label", fallback: "Release date")
    }
  }
  internal enum Generic {
    /// Cancel
    internal static let cancel = L10n.tr("Localizable", "generic.cancel", fallback: "Cancel")
    /// Ok
    internal static let ok = L10n.tr("Localizable", "generic.ok", fallback: "Ok")
  }
  internal enum List {
    internal enum Search {
      /// Search
      internal static let placeholder = L10n.tr("Localizable", "list.search.placeholder", fallback: "Search")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
