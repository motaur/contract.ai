# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
flutter pub get          # install/sync dependencies
flutter run -d chrome    # run on web (primary target)
flutter run              # run on iOS simulator
flutter run -d android   # run on Android emulator
flutter build web --release --base-href /contract.ai/ --no-tree-shake-icons  # production web build
flutter test             # run all tests
flutter test test/widget_test.dart  # run a single test file
flutter analyze          # static analysis (dart analyze also works)
```

## Architecture

This is a Flutter MVP (Phase 1 — navigation shell with mock data, no real AI or auth). Targets: Android, iOS, Chrome/web.

**State management**: `provider` — a single `ThemeController` (`ChangeNotifierProvider` at root) holds accent color, dark/light toggle, and severity chip style (`SevStyle`). Read via `context.watch<ThemeController>()`.

**Routing**: `go_router` — all routes declared in `lib/router.dart`. A top-level `ShellRoute` wraps everything in `PhoneFrame` (see below). Three tabbed routes (`/home`, `/history`, `/settings`) are wrapped in `_TabbedShell` which overlays `AppTabBar` as a `Stack`. Non-tabbed routes (`/`, `/analyzing`, `/results`, `/issue/:id`) skip the tab bar.

**Theme tokens**: `lib/theme/tokens.dart` defines `Tokens` (a plain Dart class, not a `ThemeExtension`) with two static instances: `Tokens.light` and `Tokens.dark`. These mirror the color palette from `claude_design/contract.ai/screens.jsx`. Access anywhere via `Tokens.of(context)` (backed by an `InheritedWidget` called `TokensScope`). `ThemeController.tokens` returns the active palette.

**`PhoneFrame`** (`lib/widgets/phone_frame.dart`): on web viewports ≥ 500 px wide, wraps the child in a fixed 390×844 container with rounded corners and drop shadow (mimicking an iPhone frame). On mobile or narrow viewports, passes the child through unchanged. Applied at the `ShellRoute` level.

**Mock data**: `lib/data/mock_issues.dart` and `lib/data/mock_recents.dart` hold pre-baked lists ported from the design prototype. No network calls; no persistence.

**Mock upload flow**: Home → hero CTA → `UploadSheet` (modal bottom sheet) → any source → `context.go('/analyzing')` → 3-stage animation (~3.8 s) → `context.go('/results')`.

**Fonts**: `Ploni` (primary, wired as `fontFamily` in `ThemeData`) and `AlmoniNeueAAA` — both loaded from `assets/fonts/`. Icons are SVG files under `assets/icons/` rendered via `flutter_svg`.

**Severity system**: Three kinds — `red`, `amber`, `blue` (`SevKind` enum in `tokens.dart`). `sevColor(t, k)` returns a `SevPalette` with fg/bg/ink colors. `SevStyle` (soft/solid) toggles chip rendering style globally.

## CI / Deploy

GitHub Actions workflow at `.github/workflows/deploy.yml`. Pushes to `master` trigger a Flutter web build and deploy to GitHub Pages at `/contract.ai/`. The `--no-tree-shake-icons` flag is required because SVG icons bypass the tree-shaker.

## Design reference

`claude_design/contract.ai/screens.jsx` is the canonical design prototype (8 screens). When implementing UI, use it as the pixel-level reference. The HTML prototype (`Contract Analyzer.html`) renders the design in a browser for quick visual checks.
