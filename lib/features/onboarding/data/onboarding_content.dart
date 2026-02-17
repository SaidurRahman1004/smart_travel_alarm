import '../../../constants/app_images.dart';

class OnboardingContent {
  final String image;
  final String title;
  final String description;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

//data of 3 oNboarding screens
List<OnboardingContent> contents = [
  OnboardingContent(
    image: AppImages.onboarding1,
    title: "Discover the world, one journey at a time.",
    description:
        "From hidden gems to iconic destinations, we make travel simple, inspiring, and unforgettable. Start your next adventure today.",
  ),
  OnboardingContent(
    image: AppImages.onboarding2,
    title: "Explore new horizons, one step at a time.",
    description:
        "Every trip holds a story waiting to be told. Let us guide you to experiences that inspire, connect, and last a lifetime.",
  ),
  OnboardingContent(
    image: AppImages.onboarding3,
    title: "See the beauty, one journey at a time.",
    description:
        "Travel made simple and exciting—discover places you’ll love and moments you’ll never forget.",
  ),
];
