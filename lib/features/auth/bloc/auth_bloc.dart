import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:toko_klontong_gema/data/local/local_storage.dart';
import 'package:toko_klontong_gema/features/auth/domain/services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthService service = AuthService();
  AuthBloc() : super(AuthInitial()) {
    on<AuthLogin>((event, emit) async {
      try {
        emit(AuthLoading());
        await Future.delayed(const Duration(seconds: 3));
        Codec<String, String> stringToBase64 = utf8.fuse(base64);
        String userencoded = stringToBase64.encode(event.username);
        String passencoded = stringToBase64.encode(event.password);

        if (userencoded == 'dXNlcnRlc3Q=' && passencoded == 'cGFzc3dvcmQ=') {
          StatusLoginPreferences.setStatusLogin('true');
          emit(AuthLoginSuccess(name: event.username));
        } else {
          emit(AuthFailed('Username or password\ndoes not match!'));
        }
      } catch (e) {
        emit(AuthFailed(e.toString()));
      }
    });

    on<AuthLogout>((event, emit) async {
      emit(AuthLoading());
      StatusLoginPreferences.setStatusLogin('false');
      await Future.delayed(const Duration(seconds: 3));
      emit(AuthInitial());
    });
  }
}
