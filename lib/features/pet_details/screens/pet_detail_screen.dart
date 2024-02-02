import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet4u/constants/custom_colors.dart';
import 'package:pet4u/features/home/bloc/home_bloc.dart';
import 'package:pet4u/features/home/bloc/home_event.dart';
import 'package:pet4u/features/home/bloc/home_state.dart';
import 'package:pet4u/features/pet_details/widgets/pet_detail_box.dart';
import 'package:pet4u/features/theme/bloc/theme_bloc.dart';
import 'package:pet4u/features/theme/bloc/theme_event.dart';
import 'package:pet4u/models/pet_model.dart';

class PetDetailScreen extends StatefulWidget {
  const PetDetailScreen({super.key, required this.pet});
  final Pet pet;

  @override
  State<PetDetailScreen> createState() => _PetDetailScreenState();
}

class _PetDetailScreenState extends State<PetDetailScreen> {
  late ConfettiController _controller;
  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            actions: [
              PopupMenuButton(itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Text(
                            '${(context.read<ThemeBloc>().isDark ?? false) ? 'Light' : 'Dark'} mode'),
                      ],
                    ),
                  ),
                ];
              }, onSelected: (_) {
                context.read<ThemeBloc>().add(ThemeChangeEvent());
              }),
            ],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(300, 100),
                bottomRight: Radius.elliptical(300, 100),
              ),
            ),
            backgroundColor: widget.pet.species == Species.cat
                ? CustomColors.catColor
                : widget.pet.species == Species.dog
                    ? CustomColors.dogColor
                    : CustomColors.otherColor,
            expandedHeight: MediaQuery.of(context).size.height * 0.5,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: widget.pet.id,
                child: CachedNetworkImage(
                  imageUrl: widget.pet.urlToImage,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12)
                    .copyWith(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.pet.name,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 100,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          PetDetailBox(
                            value: '${widget.pet.age} months',
                            title: 'Age',
                            color: CustomColors.ageColor,
                          ),
                          const SizedBox(width: 5),
                          PetDetailBox(
                            value: '${widget.pet.weight} kg',
                            title: 'Weight',
                            color: CustomColors.weightColor,
                          ),
                          const SizedBox(width: 5),
                          PetDetailBox(
                            value: '${widget.pet.height} cm',
                            title: 'Height',
                            color: CustomColors.heightColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'About',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.pet.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Spacer(),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      bool isAdopted = context
                          .watch<HomeBloc>()
                          .adoptedPets!
                          .contains(widget.pet.id);
                      return TextButton(
                        onPressed: isAdopted
                            ? null
                            : () {
                                context.read<HomeBloc>().add(
                                      AdoptPet(petID: widget.pet.id),
                                    );
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: ConfettiWidget(
                                              confettiController: _controller,
                                              blastDirectionality:
                                                  BlastDirectionality.explosive,
                                              particleDrag: 0.05,
                                              emissionFrequency: 0.05,
                                              numberOfParticles: 50,
                                              gravity: 0.0,
                                              shouldLoop: true,
                                              colors: const [
                                                Colors.green,
                                                Colors.blue,
                                                Colors.pink,
                                                Colors.orange,
                                                Colors.purple,
                                              ]),
                                        ),
                                        AlertDialog(
                                          title: Text(
                                            'Pet adopted!',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium,
                                          ),
                                          content: Text(
                                            'You have successfully adopted ${widget.pet.name}!',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                _controller.play();
                              },
                        style: TextButton.styleFrom(
                          disabledBackgroundColor: Colors.grey,
                        ),
                        child: Text(
                          isAdopted ? 'Adopted' : 'Adopt',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.white),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
