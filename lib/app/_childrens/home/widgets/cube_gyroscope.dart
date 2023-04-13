import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:tipti_test/app/_childrens/home/bloc/bloc.dart' as bloc;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tipti_test/app/common_widgets/btn_widget.dart';
import 'package:tipti_test/app/constants/assets.dart';
import 'package:tipti_test/app/constants/settings.dart';
import 'package:tipti_test/app/constants/texts.dart';
import 'package:tipti_test/app/models/home_models/coordinate_model.dart';

class CubeGyroscopeMain extends StatefulWidget {
  const CubeGyroscopeMain({
    Key? key,
  }) : super(key: key);

  @override
  State<CubeGyroscopeMain> createState() => _CubeGyroscopeMainState();
}

class _CubeGyroscopeMainState extends State<CubeGyroscopeMain> {
  @override
  void initState() {
    super.initState();
    _startListener();
  }

  @override
  void dispose() {
    _cancelListener();
    super.dispose();
  }

  static const stream = EventChannel(Settings.channelCube);

  late StreamSubscription _streamSubscription;

  void _startListener() {
    _streamSubscription = stream.receiveBroadcastStream().listen(_listenStream);
  }

  void _cancelListener() {
    _streamSubscription.cancel();
  }

  void _listenStream(value) {
    CoordinateModel _coordinateModel;
    _coordinateModel = CoordinateModel.fromJson(jsonDecode(value));
    context.read<bloc.Bloc>().add(
          bloc.ChangeDegreesEvent(
            CoordinateModel(
              x: ((_coordinateModel.x * 0.0174533 * 6) / 1.00000042858),
              y: ((_coordinateModel.y * 0.0174533 * 6) / 1.00000042858),
              z: ((_coordinateModel.z * 0.0174533 * 6) / 1.00000042858),
            ),
            _coordinateModel,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<bloc.Bloc, bloc.State>(
      builder: (context, state) {
        return SizedBox(
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  ButttonCustom(
                    onTap: _startListener,
                    label: TextUIValues.play,
                    fontSize: 11,
                    height: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ButttonCustom(
                    onTap: _cancelListener,
                    label: TextUIValues.stop,
                    fontSize: 11,
                    height: 20,
                  ),
                ],
              ),
              SizedBox(
                width: size.width * 0.2,
              ),
              Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(state.model.degreeX)
                  ..rotateY(state.model.degreeY)
                  ..rotateZ(state.model.degreeZ),
                alignment: Alignment.center,
                child: const Center(
                  child: CubeGyroscope(),
                ),
              ),
              SizedBox(
                width: size.width * 0.2,
              ),
              SizedBox(
                width: size.width * .15,
                child: Text(
                  "\nX: ${state.model.coordinateModel.x.toStringAsFixed(4)}\nY: ${state.model.coordinateModel.y.toStringAsFixed(4)}\nZ: ${state.model.coordinateModel.z.toStringAsFixed(4)}\n",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CubeGyroscope extends StatelessWidget {
  const CubeGyroscope({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CubeGyroscopeSide(
            backgroundImage: AssetsUIValues.logoTiptiOragne,
            color: Colors.red,
            alignment: Alignment.centerLeft,
            transform: Matrix4.identity()
              ..translate(
                0.0,
                0.0,
                -25.0,
              )),
        CubeGyroscopeSide(
            backgroundImage: AssetsUIValues.logoTiptiOragne,
            color: Colors.red,
            alignment: Alignment.centerLeft,
            transform: Matrix4.identity()..translate(0.0, 0.0, 25.0)),
        CubeGyroscopeSide(
            color: Colors.orange,
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..translate(25.0, 0.0, 0.0)
              ..rotateY(-pi / 2)),
        CubeGyroscopeSide(
            color: Colors.orange,
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..translate(25.0, 0.0, 0.0)
              ..rotateY(-pi / 2)),
        CubeGyroscopeSide(
            color: Colors.blue,
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..translate(0.0, 25.0, 0.0)
              ..rotateX(pi / 2)),
        CubeGyroscopeSide(
            color: Colors.blue,
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..translate(0.0, -25.0, 0.0)
              ..rotateX(pi / 2)),
      ],
    );
  }
}

class CubeGyroscopeSide extends StatelessWidget {
  const CubeGyroscopeSide({
    Key? key,
    required this.transform,
    required this.color,
    required this.alignment,
    this.backgroundImage,
  }) : super(key: key);
  final Matrix4 transform;
  final Color color;
  final Alignment alignment;
  final String? backgroundImage;
  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: transform,
      alignment: alignment,
      child: Container(
        color: color,
        child: backgroundImage != null
            ? Image.asset(
                backgroundImage ?? "",
                height: 50,
              )
            : const SizedBox(
                height: 50,
                width: 50,
              ),
      ),
    );
  }
}
