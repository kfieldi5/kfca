import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kfca/providers/project_list_provider.dart';
import 'package:kfca/ui/components/project_blurb.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class WorkDialog extends ConsumerWidget {
  const WorkDialog({super.key, required this.screenWidth});

  final double screenWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(projectListProvider);
    return PointerInterceptor(
      child: Container(
          margin: EdgeInsets.symmetric(
              vertical: (screenWidth < 500) ? 20 : 72,
              horizontal: (screenWidth < 500) ? 20 : screenWidth / 4),
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Color(0xFFd2b48c),
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          child: DefaultTextStyle(
            style: TextStyle(
                fontFamily: 'Coves',
                fontSize: (screenWidth < 500) ? 14 : 22,
                overflow: TextOverflow.ellipsis,
                color: Colors.white,
                fontWeight: FontWeight.w700),
            child: Stack(children: [
              ListView.builder(
                itemCount: projects.length,
                itemBuilder: (context, index) => ProjectBlurb(
                  screenWidth: screenWidth,
                  project: projects[index],
                  isLastItem: (index == projects.length - 1),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              )
            ]),
          )),
    );
  }
}
