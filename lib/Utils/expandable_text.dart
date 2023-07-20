import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;

  ExpandableText({required this.text, this.maxLines = 3});

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final textSpan = TextSpan(
          text: widget.text,
          style: TextStyle(color: Colors.white),
        );

        final textPainter = TextPainter(
          text: textSpan,
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        );

        textPainter.layout(maxWidth: constraints.maxWidth);

        final isTextOverflowed = textPainter.didExceedMaxLines;

        final textWidget = Text(
          widget.text,
          maxLines: _isExpanded ? null : widget.maxLines,
          overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white),
        );

        final moreButton = isTextOverflowed
            ? TextButton(
          onPressed: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Text(
            _isExpanded ? 'Show Less' : 'Show More',
            style: TextStyle(
              color: Colors.grey, // Customize the color as needed
            ),
          ),
        )
            : Container();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            textWidget,
            if ((textWidget.maxLines == null || textWidget.maxLines == widget.maxLines))
              moreButton,
          ],
        );
      },
    );
  }
}
