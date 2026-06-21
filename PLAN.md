# contract.ai — Flutter MVP implementation plan

Status: Phase 1 — navigation-only shell with mock upload response.
Targets: Android, iOS, Chrome (Flutter web).

## Goals
1. Replicate the 8 screens from `claude_design/contract.ai/screens.jsx` in Flutter, faithful to the iOS prototype (390×844 reference frame).
2. Wire end-to-end navigation between screens.
3. On "upload", run a mock analyzing animation and land on the pre-baked results screen — **no real file picker, no parsing, no AI**.
4. No real auth — auth buttons just navigate forward.

## Stack decisions (confirmed)
- **Routing**: `go_router` — declarative, clean Chrome URLs, deep links.
- **State**: `provider` (already in deps) — for theme/tweaks controller only.
- **Icons**: inline SVG paths rendered via `flutter_svg` strings (already in deps); fall back to `CustomPainter` for the brand logo.
- **Fonts**: `Ploni` (already wired in `pubspec.yaml`).
- **Web layout**: viewport ≥ 500 px → centered 390×844 iPhone frame with rounded corners + drop shadow; narrower viewports fill the window.
- **Mock upload**: full animation flow (~3.8 s, three step indicators) before landing on Results.

## File layout
```
lib/
  main.dart                          # bootstrap (fix current syntax errors)
  app.dart                           # MaterialApp.router + ThemeData
  router.dart                        # go_router config
  theme/
    tokens.dart                      # light + dark token maps (from screens.jsx)
    theme_controller.dart            # accent / dark / sevStyle (ChangeNotifier)
  models/
    issue.dart                       # id, sev, page, title, snippet, why, action
    recent.dart                      # id, name, when, group, red/amber/blue counts
  data/
    mock_issues.dart                 # ISSUES list, ported from screens.jsx
    mock_recents.dart                # RECENT + HISTORY_ALL lists, ported
  widgets/
    phone_frame.dart                 # 390×844 frame on wide web; passthrough on mobile/narrow
    app_tab_bar.dart                 # Home / History / You bottom bar
    severity.dart                    # SevChip, SevDot, sevColor()
    buttons.dart                     # PrimaryBtn, GhostBtn
    app_icons.dart                   # SVG-string icon set (doc, upload, camera, ...)
    brand_logo.dart                  # logo as CustomPainter
  screens/
    splash_screen.dart
    home_screen.dart
    upload_sheet.dart                # showModalBottomSheet content
    analyzing_screen.dart
    results_screen.dart
    issue_detail_screen.dart
    history_screen.dart
    settings_screen.dart
```

## Routes
| Path           | Screen           | Notes                                                                 |
|----------------|------------------|-----------------------------------------------------------------------|
| `/`            | Splash           | "Continue with Apple/Google/email" → all push `/home`                |
| `/home`        | Home             | Tab 1; hero CTA → `showModalBottomSheet(UploadSheet)`                |
| `/analyzing`   | Analyzing        | 3-stage animated timer → auto `context.go('/results')` at ~3.8 s     |
| `/results`     | Results          | Filter chips (All / Red / Amber / Blue), tap row → `/issue/:id`      |
| `/issue/:id`   | IssueDetail      | Looks up issue in `mock_issues`; back → `/results`                   |
| `/history`     | History          | Tab 2; rows → `/results`                                              |
| `/settings`    | Settings         | Tab 3; exposes accent picker, dark toggle, severity-style radio       |

ShellRoute groups `/home`, `/history`, `/settings` so the tab bar stays mounted.

## Mock upload flow
Home → tap hero card → `UploadSheet` (modal) → tap any of the four sources (PDF / Photo / Text / Cloud) → close sheet → `context.go('/analyzing')` → after the canned animation, `context.go('/results')`. Results already contain the pre-baked 10-issue dataset from `screens.jsx`.

## Theme & tweaks
- `tokens.dart` mirrors `defaultTokens` and `dark` maps from `screens.jsx` 1:1.
- `ThemeController` holds:
  - `Color accent` (default `#d97757`)
  - `bool dark` (default false; on first launch, follow system)
  - `SevStyle sevStyle` (`soft` | `solid`, default `soft`)
- Settings screen exposes accent swatches + dark toggle + severity radio (replacing the prototype's design-canvas Tweaks panel).

## Animations to port
- **Analyzing scan line**: `AnimationController` with `Tween<double>(0, 220)` looping 1.4 s, drawn as a gradient strip translated down the doc mock.
- **Active step dot pulse**: `AnimationController` looping 1.0 s, opacity 0.3↔1, scale 0.85↔1.
- **Upload sheet**: native `showModalBottomSheet(isScrollControlled: true, ...)` for the slide-up.
- **Splash radial wash**: `RadialGradient` background.

## Web (Chrome) treatment
`PhoneFrame` widget:
- Uses `LayoutBuilder`. If `constraints.maxWidth >= 500`, wraps child in a fixed 390×844 `Container` with `borderRadius: 44`, hairline border, drop shadow, centered on a neutral background (`#f0eee9` from the design HTML).
- Otherwise returns the child unchanged.
- Applied at the `ShellRoute` builder level so it wraps every route.

## Acceptance criteria
- `flutter run -d chrome`, `flutter run` (iOS sim), `flutter run -d android` all launch the app to Splash.
- Splash → tap any auth button → Home.
- Home → hero CTA → sheet → any source → Analyzing animation → Results.
- Results filter chips work; tap a row → Issue detail; back returns to Results.
- Tab bar switches Home / History / You without losing state.
- Settings accent picker recolors the app live; dark toggle flips theme; severity radio flips chip style on Results.

## Out of scope (Phase 2+)
- Real auth providers (Apple / Google / email magic link).
- `file_picker` / `image_picker` / clipboard integration.
- Document parsing (PDF text extraction, OCR).
- AI API calls for clause classification.
- Persistent storage for history (currently in-memory mock).
- Search functionality on History screen.
- Settings actions: Edit profile, Sign out, Export data, Help links.
- Issue detail "Show in doc" / "Ask follow-up" / Prev / Next buttons (visible but inert).
- Share / more menus on Results header.

## Implementation order
1. Fix `lib/main.dart` syntax; add `go_router` to `pubspec.yaml`; `flutter pub get`.
2. Build `theme/tokens.dart` + `ThemeController`; bootstrap `MaterialApp.router` in `app.dart`.
3. Build `router.dart` with all routes + `ShellRoute` for tabbed screens.
4. Build shared widgets: `PhoneFrame`, `AppTabBar`, severity chips, buttons, icons, brand logo.
5. Build models + mock data.
6. Implement screens in route order: Splash → Home → UploadSheet → Analyzing → Results → IssueDetail → History → Settings.
7. Smoke-test each target (Chrome, iOS sim, Android emulator).
