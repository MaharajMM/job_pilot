import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pilot/const/resource.dart';
import 'package:job_pilot/core/router/router.gr.dart';
import 'package:job_pilot/features/authentication/const/auth_form_keys.dart';
import 'package:job_pilot/features/authentication/view/auth_form_view.dart';
import 'package:job_pilot/features/login/view/widget/login_sign_up_btn.dart';
import 'package:job_pilot/features/sign_up/controller/signup_pod.dart';
import 'package:job_pilot/features/sign_up/view/widgets/sign_up_btn.dart';
import 'package:job_pilot/shared/utility/utilities.dart';
import 'package:job_pilot/shared/widget/animations/slide_animation_builder.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SignUpView();
  }
}

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final _signUpFormKey = GlobalKey<FormBuilderState>();

  final ScrollController _scrollController = ScrollController();
  final FocusNode _nameFocusNode = FocusNode();
  final GlobalKey _signUpBlueContainerKey = GlobalKey();
  bool _hasScrolledToForm = false; // Track if we've already scrolled

  @override
  void initState() {
    super.initState();

    // Add listeners to focus nodes
    _nameFocusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (_nameFocusNode.hasFocus && !_hasScrolledToForm) {
      _hasScrolledToForm = true;
      // Get the position of the blue container
      // You'll need to use a GlobalKey to get its position
      final RenderBox renderBox =
          _signUpBlueContainerKey.currentContext?.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);

      // Animate scrolling to the blue container
      _scrollController.animateTo(
        position.dy - 100, // Subtract a small offset to place it at the top with a little margin
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    // Reset the flag when both fields lose focus
    if (!_nameFocusNode.hasFocus) {
      _hasScrolledToForm = false;
    }
  }

  void signUpUser() {
    if (_signUpFormKey.currentState?.validate() ?? false) {
      final fields = _signUpFormKey.currentState!.fields;
      final name = fields[AuthFormKeys.name]!.value as String;
      final email = fields[AuthFormKeys.email]!.value as String;
      final password = fields[AuthFormKeys.password]!.value as String;
      final confirmPassword = fields[AuthFormKeys.confirmPassword]!.value as String;

      ref.watch(signUpUserProvider.notifier).registerUser(
            name: name,
            email: email,
            password: password,
            confirmPassword: confirmPassword,
            onRegisterUser: () {
              Utilities.flushBarSuccessMessage(
                message: 'Sign up successful',
                context: context,
              );
              // Handle user registration
              context.navigateTo(HomeRoute());
            },
            onRegisterError: (error) {
              // Show error message
              Utilities.flushBarErrorMessage(
                message: 'Sign up failed: $error',
                context: context,
              );
            },
          );
    } else {
      HapticFeedback.lightImpact();
      Feedback.forTap(context);
    }
  }

  @override
  void dispose() {
    _signUpFormKey.currentState?.dispose();
    _scrollController.dispose();
    _nameFocusNode.dispose();
    _signUpBlueContainerKey.currentState?.dispose();

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
                    child: Image.asset(
                      R.ASSETS_ILLUSTRATIONS_AUTH_ILLUSTRATION_2_PNG,
                      fit: BoxFit.contain,
                    ).objectTopCenter().h(350),
                  ),
                  Positioned(
                    top: 0,
                    right: 15,
                    child: LoginSignUpBtn(
                      isLogin: true,
                    ),
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
                            'Start Your Journey',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text('Unlock Your Experience'),
                        ],
                      ),
                      20.heightBox,
                      Container(
                        key: _signUpBlueContainerKey,
                        child: AuthFormView(
                          authBtn: SignUpButton(
                            onSubmit: () => signUpUser(),
                          ),
                          formKey: _signUpFormKey,
                          isSignUp: true,
                          nameFocusNode: _nameFocusNode,
                        ),
                      ),
                      50.heightBox,
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
