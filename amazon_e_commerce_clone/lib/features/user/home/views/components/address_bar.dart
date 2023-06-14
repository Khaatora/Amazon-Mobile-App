import 'package:amazon_e_commerce_clone/core/features/main/view_model/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressBar extends StatelessWidget {
  const AddressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.only(left: 8),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(
              255,
              114,
              226,
              221,
            ),
            Color.fromARGB(
              255,
              162,
              236,
              233,
            ),
          ],
          stops: [0.5, 1.0],
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 20,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: BlocBuilder<MainCubit, MainState>(
              buildWhen: (previous, current) =>
                  current.user.name != previous.user.name,
              builder: (context, state) {
                return Text(
                  "Delivery to ${state.user.name} - ${state.user.address}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                );
              },
            ),
          )),
          const Padding(padding: EdgeInsets.only(right: 5,top: 2), child: Icon(
            Icons.arrow_drop_down_circle_outlined,
            size: 18.0,
          ),),
        ],
      ),
    );
  }
}
