import 'package:flutter/material.dart';
import 'package:tipti_test/app/common_widgets/btn_widget.dart';
import 'package:tipti_test/app/constants/assets.dart';
import 'package:tipti_test/app/constants/texts.dart';

class NoResultWidget extends StatelessWidget {
  const NoResultWidget({
    this.image,
    Key? key,
    this.message,
    this.onTap,
    this.title,
  }) : super(key: key);

  final String? image;
  final String? message;
  final GestureTapCallback? onTap;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.10,
        ),
        Image.asset(
          AssetsUIValues.noResults,
          height: 40,
          width: 40,
        ),
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              if (title != null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              if (message != null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  child: Text(
                    message!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              if (onTap != null)
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: ButttonCustom(
                    onTap: onTap,
                    label: TextUIValues.reload,
                    fontSize: 14,
                    height: 30,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
