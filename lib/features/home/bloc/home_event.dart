sealed class HomeEvent {}

class HomeLoadEvent extends HomeEvent {}

class AdoptPet extends HomeEvent {
  final String petID;
  AdoptPet({required this.petID});
}
