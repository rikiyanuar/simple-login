import 'package:equatable/equatable.dart';

abstract class GeneralState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GeneralSuccessState extends GeneralState {
  final Object? object;

  GeneralSuccessState({this.object});
}

class GeneralErrorState extends GeneralState {}

class GeneralServerErrorState extends GeneralState {}

class GeneralClientErrorState extends GeneralState {}
