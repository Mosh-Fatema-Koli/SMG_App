import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedNetworkImageUrl extends StatelessWidget {
  final String imageUrl;
  final Function(String)? onImageLoadResult;
  double? width;
  double? height;
  BoxFit? fit;
  CachedNetworkImageUrl({super.key, required this.imageUrl, this.onImageLoadResult,this.width,this.height,this.fit});


  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(imageUrl:imageUrl,height:height,width:width,fit: BoxFit.fill,
      errorWidget: (context, url, error) {
        // onImageLoadResult!('Image URL is not valid: $error');
        return const Icon(Icons.error,color: Colors.red,);
      },
    );
  }
}