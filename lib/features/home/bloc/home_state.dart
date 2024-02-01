import 'package:pet4u/models/pet_model.dart';

sealed class HomeState {}

class HomeInit extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}

class HomeLoaded extends HomeState {
  final List<Pet> pets;
  final Set<Species> species;

  HomeLoaded({required this.pets, required this.species});
}
