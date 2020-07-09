import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

import 'base_event.dart';

abstract class BaseBloc {
  StreamController<BaseEvent> _eventStreamController =
      StreamController<BaseEvent>();

  Sink<BaseEvent> get event => _eventStreamController.sink;

  StreamController<BaseEvent> _likedEventSubject=BehaviorSubject<BaseEvent>();
  Stream<BaseEvent> get likedEventStream => _likedEventSubject.stream;
  Sink<BaseEvent> get likedEventSink => _likedEventSubject.sink;

  StreamController<BaseEvent> _processEventSubject =
  BehaviorSubject<BaseEvent>();
  Stream<BaseEvent> get processEventStream => _processEventSubject.stream;
  Sink<BaseEvent> get processEventSink => _processEventSubject.sink;

  BaseBloc(){
    _eventStreamController.stream.listen((event) {
      dispatchEvent(event);
    });
  }

  void dispatchEvent(BaseEvent event);

  @mustCallSuper
  void dispose() {
    _eventStreamController.close();
    _likedEventSubject.close();
    _processEventSubject.close();
  }
}
