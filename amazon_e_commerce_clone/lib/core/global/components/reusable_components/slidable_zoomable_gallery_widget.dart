import 'package:amazon_e_commerce_clone/core/constants/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'loader.dart';

class SlidableZoomableGalleryWidget extends StatefulWidget {
  const SlidableZoomableGalleryWidget(
      {super.key,
      required this.images,
      this.imageWidth,
      this.flex = 1,
      this.height = 200, this.enableCurrentIndexIndicator = true, this.autoScroll = false, this.widgetWidth, this.backgroundColor, this.margin, this.padding});

  final List<String> images;
  final double? imageWidth;
  final double? widgetWidth;
  final double height;
  final int flex;
  final Color? backgroundColor;
  final bool enableCurrentIndexIndicator;
  final bool autoScroll;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  State<SlidableZoomableGalleryWidget> createState() =>
      _SlidableZoomableGalleryWidgetState();
}

class _SlidableZoomableGalleryWidgetState
    extends State<SlidableZoomableGalleryWidget> {
  int _index = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    if(widget.autoScroll){
      _pageController.nextPage(duration: const Duration(), curve: Curves.linear);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.widgetWidth,
      margin: widget.margin,
      padding: widget.padding,
      child: Stack(
        children: [
          PhotoViewGallery.builder(
            itemCount: widget.images.length,
            pageController: _pageController,
            customSize: widget.imageWidth != null
                ? Size(widget.imageWidth! - (widget.padding?.horizontal ?? 0.0), widget.height - (widget.padding?.vertical ?? 0.0))
                : Size.fromHeight(widget.height - (widget.padding?.vertical ?? 0.0)),
            onPageChanged: (index) => setState(() {
              _index = index;
            }),
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                maxScale: PhotoViewComputedScale.covered * 2,
                minScale: PhotoViewComputedScale.contained * 0.8,
                imageProvider: CachedNetworkImageProvider(
                  widget.images[index],
                ),
              );
            },
            backgroundDecoration: BoxDecoration(
              color: widget.backgroundColor,
            ),
            loadingBuilder: (context, event) {
              return const Loader();
            },
          ),
          widget.enableCurrentIndexIndicator ? Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.images.map((img) {
                int index = widget.images.indexOf(img);
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  width: 16.0,
                  height: 16.0,
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 2,
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _index == index
                          ? AppColors.selectedNavBarColor
                          : const Color.fromRGBO(0, 0, 0, 0.4)),
                );
              }).toList(),
            ),
          ) : const SizedBox(),
        ],
      ),
    );
  }


}
