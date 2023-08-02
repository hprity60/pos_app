// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'package:assignment_app/features/sign_in/domain/repositories/sign_in_rpository.dart';

import '../../data/models/sign_in_request_model.dart';
import '../../data/models/sign_in_response_model.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInRepository signInRepository;
  String errorMessage = "";
  SignInBloc({required this.signInRepository}) : super(SignInInitial()) {
    on<LoggedInEvent>((event, emit) async {
      emit(SignInLoadingState());
      try {
        final signInData = await signInRepository.signIn(
            signInRequestModel: event.signInRequestModel);
        emit(SignInSuccessState(signInResponseModel: signInData));
      } on DioException catch (e) {
        errorMessage = e.error.toString();
        emit(SignInFailureState(
          errorMessage: errorMessage,
        ));
      } catch (e) {
        // DebugPrint.print(e.toString());
        emit(SignInFailureState(
          errorMessage: (e.toString()),
        ));
      }
    });
  }
}
