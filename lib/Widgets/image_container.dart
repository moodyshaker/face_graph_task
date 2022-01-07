import 'dart:io';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String imagePath;
  final Function onImagePressed;
  final bool isLoading;

  const ImageContainer({
    Key key,
    @required this.imagePath,
    @required this.onImagePressed,
    @required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onImagePressed,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                ),
                height: size.width * 0.4,
                width: size.width * 0.4,
                child: imagePath == null || imagePath.isEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                        child: const Icon(
                          Icons.photo,
                          size: 30.0,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                        child: Image.network(
                          imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              isLoading
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Container(
                        color: Colors.black.withOpacity(
                          0.6,
                        ),
                        height: size.width * 0.4,
                        width: size.width * 0.4,
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              isLoading
                  ? Container()
                  : Positioned(
                      bottom: 0.0,
                      right: 0.0,
                      child: Container(
                        width: 30.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
