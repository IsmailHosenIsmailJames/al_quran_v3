import 'package:al_quran_v3/src/screen/home/pages/audio/cubit/audio_ui_controller_cubit.dart';
import 'package:al_quran_v3/src/theme/colors/app_colors.dart';
import 'package:al_quran_v3/src/theme/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AudioControllerUi extends StatefulWidget {
  const AudioControllerUi({super.key});

  @override
  State<AudioControllerUi> createState() => _AudioControllerUiState();
}

class _AudioControllerUiState extends State<AudioControllerUi> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioUiControllerCubit, AudioUiControllerState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (!state.expanded) {
              context.read<AudioUiControllerCubit>().setExpanded(true);
            }
          },
          child: AnimatedContainer(
            margin: const EdgeInsets.only(left: 10, right: 10),
            duration: const Duration(milliseconds: 300),
            height: state.expanded ? 100 : 50,
            width: state.expanded ? MediaQuery.of(context).size.width : 50,
            decoration: BoxDecoration(
              borderRadius:
                  state.expanded
                      ? BorderRadius.circular(roundedRadius)
                      : BorderRadius.circular(1000),
              color:
                  state.expanded
                      ? Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade900
                          : Colors.grey.shade200
                      : AppColors.primaryColor,
            ),
            child: Stack(
              children: [
                if (!state.expanded)
                  const SizedBox(
                    height: 50,
                    width: 50,
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                if (state.expanded)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: IconButton(
                        style: IconButton.styleFrom(
                          padding: EdgeInsets.zero,
                          iconSize: 15,
                        ),
                        onPressed: () {
                          if (state.expanded) {
                            context.read<AudioUiControllerCubit>().setExpanded(
                              false,
                            );
                          }
                        },
                        icon: const Icon(Icons.close_fullscreen_rounded),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
