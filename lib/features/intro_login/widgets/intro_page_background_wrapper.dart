import 'package:flutter/material.dart';
import 'package:job_pilot/const/resource.dart';

// class IntroLoginBackgroundWrapper extends StatelessWidget {
//   const IntroLoginBackgroundWrapper({
//     super.key,
//     required this.imageURL,
//   });

//   final String imageURL;

//   @override
//   Widget build(BuildContext context) {
//     return CachedNetworkImage(
//       imageUrl: imageURL,
//       imageBuilder: (context, imageProvider) => _IntroLoginBody(
//         image: imageProvider,
//       ),
//       placeholder: (context, url) => const Skeleton(),
//       errorWidget: (context, url, error) => const Icon(Icons.error),
//     );
//   }
// }

class IntroLoginBackground extends StatelessWidget {
  const IntroLoginBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
            child: Image.asset(
              R.ASSETS_IMAGES_BACKGORUND_1_JPEG,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black12.withOpacity(0.1),
                  Colors.black12,
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
