import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:job_pilot/const/colors/app_colors.dart';
import 'package:job_pilot/core/router/router.gr.dart';
import 'package:job_pilot/features/authentication/view/auth_form_view.dart';
import 'package:job_pilot/features/login/view/widget/login_image_illustration.dart';
import 'package:job_pilot/features/login/view/widget/login_sign_up_btn.dart';
import 'package:job_pilot/shared/widget/animations/slide_animation_builder.dart';
import 'package:job_pilot/shared/widget/buttons/app_primary_btn.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage(
  deferredLoading: true,
)
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginView();
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _hasScrolledToForm = false;

  final ScrollController _scrollController = ScrollController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final GlobalKey _blueContainerKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    // Add listeners to focus nodes
    _emailFocusNode.addListener(_handleFocusChange);
    _passwordFocusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if ((_emailFocusNode.hasFocus || _passwordFocusNode.hasFocus) && !_hasScrolledToForm) {
      _hasScrolledToForm = true;
      // Get the position of the blue container
      // You'll need to use a GlobalKey to get its position
      final RenderBox renderBox = _blueContainerKey.currentContext?.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);

      // Animate scrolling to the blue container
      _scrollController.animateTo(
        position.dy - 10, // Subtract a small offset to place it at the top with a little margin
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      // Reset the flag when both fields lose focus
      if (!_emailFocusNode.hasFocus && !_passwordFocusNode.hasFocus) {
        _hasScrolledToForm = false;
      }
    }
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _scrollController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _blueContainerKey.currentState?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  SlideAnimationBuilder(
                    delay: Durations.short3,
                    child: const LoginIllustrationImage().objectTopCenter().h(350),
                  ),
                  Positioned(
                    top: 0,
                    right: 15,
                    child: LoginSignUpBtn(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SlideAnimationBuilder(
                  delay: Durations.medium2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back!',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text('Enter your email & password'),
                        ],
                      ),
                      // 20.heightBox,
                      Container(
                        key: _blueContainerKey,
                        child: AuthFormView(
                          authBtn: PrimaryButton(
                            color: AppColors.kPrimaryColor,
                            // fontColor: AppColors.kwhite,
                            labelText: 'Login',
                            onPressed: () => context.navigateTo(HomeRoute()),
                          ),
                          formKey: _formKey,
                          isSignUp: false,
                          emailFocusNode: _emailFocusNode,
                          passwordFocusNode: _passwordFocusNode,
                        ),
                      ),
                      20.heightBox,
                    ],
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
