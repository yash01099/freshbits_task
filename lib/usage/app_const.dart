import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'app_colors.dart';

/// Spacers
Gap gap0 = const Gap(0);
Gap gap1 = const Gap(1);
Gap gap2 = const Gap(2);
Gap gap4 = const Gap(4);
Gap gap6 = const Gap(6);
Gap gap8 = const Gap(8);
Gap gap12 = const Gap(12);
Gap gap16 = const Gap(16);
Gap gap24 = const Gap(24);
Gap gap36 = const Gap(36);
Gap gap48 = const Gap(48);

/// Paddings
EdgeInsets padding4 = const EdgeInsets.all(4);
EdgeInsets padding8 = const EdgeInsets.all(8);
EdgeInsets padding16 = const EdgeInsets.all(16);
EdgeInsets padding24 = const EdgeInsets.all(24);
EdgeInsets paddingH8 = const EdgeInsets.symmetric(horizontal: 8);
EdgeInsets paddingH2 = const EdgeInsets.symmetric(horizontal: 2);
EdgeInsets paddingV8 = const EdgeInsets.symmetric(vertical: 8);
EdgeInsets paddingH16 = const EdgeInsets.symmetric(horizontal: 16);
EdgeInsets paddingV16 = const EdgeInsets.symmetric(vertical: 16);
EdgeInsets paddingH24 = const EdgeInsets.symmetric(horizontal: 24);
EdgeInsets paddingV24 = const EdgeInsets.symmetric(vertical: 24);

/// Borders
BorderRadius circular4 = const BorderRadius.all(Radius.circular(4));
BorderRadius circular8 = const BorderRadius.all(Radius.circular(8));
BorderRadius circular12 = const BorderRadius.all(Radius.circular(12));
BorderRadius circular16 = const BorderRadius.all(Radius.circular(16));

/// Widgets
Divider divider = const Divider(height: 2);

/// Box Decoration
BoxDecoration circularDecorationWithDropShadow = BoxDecoration(
  borderRadius: BorderRadius.circular(100.0),
  boxShadow: [
    BoxShadow(
      blurRadius: 10.0,
      color: AppColors.backgroundShadow.withOpacity(0.2),
      spreadRadius: -5,
    )
  ],
);

RoundedRectangleBorder cardCircularBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(21),
);
