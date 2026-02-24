import 'package:expense_manager/core/constants/app_assets.dart';
import 'package:expense_manager/core/constants/app_colors.dart';
import 'package:expense_manager/core/constants/app_spacing.dart';
import 'package:expense_manager/core/constants/app_strings.dart';
import 'package:expense_manager/features/auth/screeens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({super.key});

  @override
  State<WalkthroughScreen> createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  /// ONLY TEXT CHANGES

  void nextPage() {
    if (currentIndex < AppStrings.pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  void previousPage() {
    _controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.walkThroughImage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: Column(
                  children: [
                    Spacer(flex: 3),

                    Row(
                      children: List.generate(
                        AppStrings.pages.length,
                        (index) => Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(right: 6),
                            height: 4,
                            decoration: BoxDecoration(
                              color: currentIndex == index
                                  ? AppColors.white
                                  : AppColors.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: PageView.builder(
                        controller: _controller,
                        itemCount: AppStrings.pages.length,
                        onPageChanged: (i) => setState(() => currentIndex = i),
                        itemBuilder: (_, i) {
                          final page = AppStrings.pages[i];

                          return Column(
                            crossAxisAlignment: .start,
                            children: [
                              /// BACK BUTTON (not first page)
                              const Spacer(),

                              /// TITLE
                              Text(
                                page.title,
                                style: const TextStyle(
                                  color: AppColors.textWhite,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  height: 1.3,
                                ),
                              ),

                              AppSpacing.hBox10,

                              /// SUBTITLE
                              Text(
                                page.subtitle,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),

                              AppSpacing.hBox40,
                            ],
                          );
                        },
                      ),
                    ),

                    AppSpacing.hBox20,

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (currentIndex != 0)
                          IconButton(
                            onPressed: previousPage,
                            icon: SvgPicture.asset(
                              AppAssets.walkthroughBackArrow,
                            ),
                          ),
                        AppSpacing.wBox10,
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: nextPage,
                              child: Text(
                                currentIndex == AppStrings.pages.length - 1
                                    ? "Get Started"
                                    : "Next",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentGeometry.topRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text(
                    "SKIP",
                    style: TextStyle(color: AppColors.textWhite),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
