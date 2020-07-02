import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class OpenContainerWrapper extends StatelessWidget {
  const OpenContainerWrapper({
    this.closedBuilder,
    this.transitionType,
    this.onClosed,
    this.child,
    this.margin,
  });

  final OpenContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;
  final ClosedCallback<bool> onClosed;
  final Widget child;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      color: Colors.transparent,
      child: OpenContainer<bool>(
        transitionDuration: Duration(milliseconds: 500),
        transitionType: transitionType,
        openBuilder: (BuildContext context, VoidCallback _) {
          return child;
        },
        onClosed: onClosed,
        tappable: false,
        closedBuilder: closedBuilder,
      ),
    );
  }
}
