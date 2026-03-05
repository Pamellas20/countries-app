class Breakpoints {
  const Breakpoints._();

  /// Mobile breakpoint: width < 600
  static const double mobile = 600;

  /// Tablet breakpoint: 600 <= width < 1024
  static const double tablet = 1024;

  /// Desktop/Web breakpoint: width >= 1024
  static const double desktop = 1024;

  /// Maximum content width for web layouts
  static const double maxContentWidth = 1200;

  /// Helper method to get current breakpoint from width
  static ScreenType getScreenType(double width) {
    if (width < mobile) {
      return ScreenType.mobile;
    } else if (width < tablet) {
      return ScreenType.tablet;
    } else {
      return ScreenType.desktop;
    }
  }

  /// Helper method to check if current width is mobile
  static bool isMobile(double width) => width < mobile;

  /// Helper method to check if current width is tablet
  static bool isTablet(double width) => width >= mobile && width < tablet;

  /// Helper method to check if current width is desktop
  static bool isDesktop(double width) => width >= desktop;
}

/// Screen type enumeration
enum ScreenType { mobile, tablet, desktop }
