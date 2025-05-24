import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test/features/auth/domain/entities/user_entity.dart';
import 'package:test/features/auth/domain/repositories/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._repository) : super(LoginInitial());

  final AuthRepository _repository;

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    final result = await _repository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    result.fold(
      (failure) => emit(LoginFailure(message: failure.message)),
      (userEntity) => emit(LoginSuccess(userEntity: userEntity)),
    );
  }
}
