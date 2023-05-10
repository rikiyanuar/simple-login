import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  final String? message;

  ServerFailure({this.message});
}

class ClientFailure extends Failure {
  final String? message;

  ClientFailure({this.message});
}

class NoDataFailure extends Failure {}
