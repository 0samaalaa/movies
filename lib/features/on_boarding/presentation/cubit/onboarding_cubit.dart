import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/preferences_helper.dart';

class OnboardingCubit extends Cubit<bool> {
  final PreferencesHelper preferencesHelper;

  OnboardingCubit(this.preferencesHelper)
      : super(preferencesHelper.hasSeenOnboarding);

  Future<void> completeOnboarding() async {
    await preferencesHelper.setHasSeenOnboarding(true);
    emit(true);
  }
}
