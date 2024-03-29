import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopbolt/ui/app_manager/app_manager_state.dart';

class AppManagerCubit extends Cubit<AppManagerState> {
  AppManagerCubit() : super(AppManagerInitial());

  void onSettingsChange() => emit(SettingsChange());

  void onObscureChange() => emit(ObscureChange());

  void onFavoriteChange() => emit(FavoriteChange());
}
