import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kfca/models/project.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectBlurb extends StatelessWidget {
  const ProjectBlurb({
    super.key,
    required this.screenWidth,
    required this.project,
    required this.isLastItem,
  });

  final double screenWidth;
  final Project project;
  final bool isLastItem;

  Widget insertDivider() {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Divider(thickness: 1, color: Colors.black12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child:
                Image.asset(project.imagePath, fit: BoxFit.cover, height: 42),
          ),
          const SizedBox(height: 12),
          Text(project.title,
              style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: project.desc,
                    style: DefaultTextStyle.of(context)
                        .style
                        .copyWith(fontSize: screenWidth < 500 ? 12 : 15)),
                if (project.linkText.isNotEmpty)
                  TextSpan(
                      text: project.linkText,
                      style: DefaultTextStyle.of(context).style.copyWith(
                          fontSize: screenWidth < 500 ? 12 : 15,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launchUrl(Uri.parse(project.link))),
              ]),
              maxLines: 16,
              softWrap: true,
            ),
          ),
          Visibility(
            visible: !isLastItem,
            child: insertDivider(),
          ),
        ],
      ),
    );
  }
}
