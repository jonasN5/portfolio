import 'package:flutter/material.dart';
import 'package:portfolio/services/navigation/pages.dart';

/// The instance used as a singleton to access [AppRouterDelegate]. Use it like:
/// NavigationService().push(newPage);
class NavigationService extends AppRouterDelegate {
  NavigationService({required AppPage initialPage})
      : super(initialPage: initialPage);
}

class AppRouterDelegate extends RouterDelegate<AppPage>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppPage> {
  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  AppRouterDelegate({required AppPage initialPage}) {
    push(initialPage);
  }

  List<AppPage> _pages = [];

  @override
  Future<void> setNewRoutePath(AppPage configuration) async {
    items = [configuration];
  }

  @override
  AppPage get currentConfiguration => _pages.last;

  /// Returns an immutable copy of items in this stack
  List<AppPage> get items => List.unmodifiable(_pages);

  /// Replaces [_pages] with a copy of given [newPages] and notifies changes.
  set items(List<AppPage> newPages) {
    _pages = List.from(newPages);
    notifyListeners();
  }

  /// Pushes a new [page] at the end of the stack if the new page is not the
  /// same as the current and notifies changes.
  void push(AppPage page) {
    if (_pages.isEmpty || _pages.last.key != page.key) {
      _pages.add(page);
      notifyListeners();
    }
  }

  /// If the new [page] already exists in the [_pages] stack, the page is popped
  /// and placed on the top of the stack. If not, the new [page] is simply
  /// pushed to the top. This mechanism is suited for [BottomNavigationBar] or
  /// similar situations.
  void popToTopOrPush(AppPage page) {
    if (_pages.last.key != page.key) {
      try {
        final _page = _pages.firstWhere((element) => element.key == page.key);
        _pages.remove(_page);
        _pages.add(_page);
      } on StateError catch (e) {
        _pages.add(page);
      }
      notifyListeners();
    }
  }

  /// Rebuild all pages to update them with a new Locale.
  void refreshPages() {
    final copy = List.from(_pages);
    _pages = [];
    for (AppPage page in copy) {
      final newPage = AppPage.fromPathSegments(page.pathSegments);
      _pages.add(newPage);
    }
    notifyListeners();
  }

  /// Removes last item if possible and notifies change.
  /// It returns the popped item, or null if stack was empty.
  AppPage? pop() {
    try {
      final poppedItem = _pages.removeLast();
      notifyListeners();
      return poppedItem;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: _pages.map((e) => e.page).toList(),
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        pop();
        return true;
      },
    );
  }
}
