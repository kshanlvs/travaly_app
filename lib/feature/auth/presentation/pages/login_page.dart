import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travaly_app/core/constants/app_constants.dart';
import 'package:travaly_app/feature/auth/presentation/bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(CheckAuthStatusEvent());
    });

    _controller = AnimationController(
      vsync: this,
      duration: AppConstants.durationXL,
    )..forward();

    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('${AppText.welcome}, ${state.user.name}!')),
            );
            context.go('/home');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              // Background gradient
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primaryDark, AppColors.primaryColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),

              // Background icon watermark
              const Positioned(
                top: -80,
                right: -60,
                child: Opacity(
                  opacity: 0.15,
                  child: Icon(
                    Icons.travel_explore,
                    size: AppConstants.imageHeightXXL,
                    color: Colors.white,
                  ),
                ),
              ),

              SafeArea(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.spacingXXL),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),

                        // Headline section
                        Text(
                          AppText.yourGatewayTo,
                          style: TextStyle(
                            color: AppColors.white
                                .withOpacity(AppConstants.opacitySecondary),
                            fontSize: AppConstants.fontSizeL,
                          ),
                        ),
                        const SizedBox(height: AppConstants.spacingXS),
                        const Text(
                          AppText.luxuryHotel,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: AppConstants.fontSizeDisplayS,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: AppConstants.spacingXXL),

                        // Login card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(AppConstants.spacingXL),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(
                                AppConstants.borderRadiusL),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                AppText.welcome,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: AppConstants.fontSizeXL,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: AppConstants.spacingS),
                              const Text(
                                'Sign in to explore luxury stays',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: AppConstants.fontSizeM,
                                ),
                              ),
                              const SizedBox(height: AppConstants.spacingXL),
                              if (state is AuthLoading)
                                const CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                )
                              else ...[
                                _buildGoogleSignInButton(context),
                                const SizedBox(height: AppConstants.spacingM),
                                _buildDisabledButton(
                                  icon: Icons.apple,
                                  label: AppText.signIn,
                                  platform: 'Apple',
                                ),
                                const SizedBox(height: AppConstants.spacingS),
                                _buildDisabledButton(
                                  icon: Icons.facebook,
                                  label: AppText.signIn,
                                  platform: 'Facebook',
                                ),
                                const SizedBox(height: AppConstants.spacingM),
                                _buildGuestButton(context),
                              ],
                            ],
                          ),
                        ),

                        const Spacer(),

                        // Footer
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: AppConstants.spacingL),
                            child: Text(
                              'By continuing, you agree to our Terms & Privacy Policy',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.white
                                    .withOpacity(AppConstants.opacitySecondary),
                                fontSize: AppConstants.fontSizeS,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGoogleSignInButton(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        minimumSize: const Size(double.infinity, AppConstants.buttonHeightL),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
        ),
      ),
      icon: const Icon(Icons.g_mobiledata,
          color: AppColors.white, size: AppConstants.iconSizeXL),
      onPressed: () {
        context.read<AuthBloc>().add(SignInWithGoogleEvent());
      },
      label: const Text(
        '${AppText.signIn} with Google',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
      ),
    );
  }

  Widget _buildGuestButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Add guest navigation here
      },
      child: const Text(
        'Continue as Guest',
        style: TextStyle(
          color: AppColors.primaryDark,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildDisabledButton({
    required IconData icon,
    required String label,
    required String platform,
  }) {
    return OutlinedButton.icon(
      onPressed: null,
      icon: Icon(icon, color: AppColors.textSecondary.withOpacity(0.5)),
      label: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$label with $platform',
            style: TextStyle(
              color: AppColors.textSecondary.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: AppConstants.spacingXS),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingS / 1.5,
                vertical: AppConstants.spacingXS / 2),
            decoration: BoxDecoration(
              color: AppColors.textSecondary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusS),
            ),
            child: const Text(
              'Coming soon',
              style: TextStyle(
                fontSize: AppConstants.fontSizeXS,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, AppConstants.buttonHeightL),
        side: BorderSide(
          color: AppColors.textSecondary.withOpacity(0.3),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
        ),
      ),
    );
  }
}
