import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    Key key,
    this.text,
    this.icon,
    this.width,
    this.height = 40.0,
    @required this.onPressed,
    this.isEnabled = true,
    this.isEnabledStream,
  }) : super(key: key);

  final String text;

  final ImageIcon icon;

  final double width;

  final double height;

  final VoidCallback onPressed;

  final bool isEnabled;

  final Observable<bool> isEnabledStream;

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<PrimaryButton> {
  @override
  void initState() {
    // If onPressed callback is null, the button should be disabled.
    _isEnabled = widget.isEnabled && widget.onPressed != null;
    _isPressed = false;
    if (widget.isEnabledStream != null) {
      _isEnabledSubscription = widget.isEnabledStream.listen(_handleIsEnabledStreamEvent);
    }
    super.initState();
  }

  static const Gradient _gradientDefault = LinearGradient(colors: <Color>[
    Color(0xff0667d6),
    Color(0xff0077ff),
  ], begin: Alignment(0.0, -2.0), end: Alignment(0.0, 1.0));

  static const Gradient _gradientPressed = LinearGradient(colors: <Color>[
    Color(0xFF213ade),
    Color(0xFF0022ff),
  ], begin: Alignment(0.0, -1.0), end: Alignment(0.0, 1.0));

  static const Gradient _gradientDisabled = LinearGradient(colors: <Color>[
    Color(0x468e8aff),
    Color(0xA65854b8),
  ], begin: Alignment(0.0, -1.0), end: Alignment(0.0, 1.0));

  static const Color _borderDefault = Color(0xFF000000);
  static const Color _borderPressed = Color(0xFF000000);
  static const Color _borderDisabled = Color(0xFF000000);

  bool _isPressed;
  bool _isEnabled;
  StreamSubscription<bool> _isEnabledSubscription;
  Timer _timer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          gradient: _isEnabled ? (_isPressed ? _gradientPressed : _gradientDefault) : _gradientDisabled,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _isEnabled ? (_isPressed ? _borderPressed : _borderDefault) : _borderDisabled, width: 1.2),
        ),
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), child: _buildWidgetsOnButton()),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    if (_isEnabled) {
      setState(() => _isPressed = true);
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (_isEnabled) {
      widget.onPressed();
      // On a quick tap the pressed state is not shown, because the state
      // changes too fast, hence we introduce a delay.
      _timer = Timer(const Duration(milliseconds: 100), () => setState(() => _isPressed = false));
    }
  }

  void _onTapCancel() {
    if (_isEnabled) {
      setState(() => _isPressed = false);
    }
  }

  void _handleIsEnabledStreamEvent(bool value) {
    // If a null value is emitted reset enabled state to default.
    value ??= widget.isEnabled;

    // If onPressed callback is null, the button should be disabled.
    if (widget.onPressed == null) {
      value = false;
    }

    // Only update state if the new value is different from the previous.
    if (value != _isEnabled) {
      setState(() {
        _isEnabled = value;
      });
    }
  }

  Widget _buildWidgetsOnButton() {
    const TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 20);

    if (widget.text != null && widget.icon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          widget.icon,
          const SizedBox(
            width: 5,
          ),
          Text(
            widget.text,
            style: textStyle,
          ),
        ],
      );
    } else if (widget.text != null) {
      return Center(
          child: Text(
        widget.text,
        style: textStyle,
      ));
    } else if (widget.icon != null) {
      return Center(
        child: widget.icon,
      );
    }

    return null;
  }

  @override
  void dispose() {
    _isEnabledSubscription?.cancel();
    _timer?.cancel();
    super.dispose();
  }
}
