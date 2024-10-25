import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/AppColors.dart';

class CustomButtonWithGradient extends StatelessWidget {
  const CustomButtonWithGradient({
    super.key,
    required this.onButtonClick,
    required this.title,
  });

  final Function() onButtonClick;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [
            AppColors.lightPurple,
            AppColors.pinkishPurple,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: onButtonClick,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadowColor: Colors.transparent,
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onItemClick,
    required this.title,
  });

  final Function() onItemClick;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.mediumGray),
      child: ElevatedButton(
        onPressed: onItemClick,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadowColor: Colors.transparent,
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
    );
  }
}

class CustomTitleWidget extends StatelessWidget {
  const CustomTitleWidget({
    super.key,
    required this.title,
    required this.fontSize,
  });

  final String title;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: fontSize,
      ),
      textAlign: TextAlign.center,
    );
  }
}
