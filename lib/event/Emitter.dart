typedef EventCallback<T> = void Function(T args);

var EventBus = new Emitter();

const LOGIN_EVENT = 'login';
const REFRESH_TODO = 'refresh_todo';

class Emitter {
  Emitter._internal();

  static Emitter _instance = new Emitter._internal();

  factory Emitter() => _instance;

  var _subscriptions = new Map<String, List<EventCallback>>();

  void on(eventName, EventCallback callback) {
    if (eventName == null || callback == null) {
      throw new ArgumentError.notNull('evnetName or Callback');
    }
    _subscriptions[eventName] ??= new List<EventCallback>();
    _subscriptions[eventName].add(callback);
  }

  void off(eventName, [EventCallback callback]) {
    if (_unsafeName(eventName)) {
      return;
    }
    if (callback == null) {
      _subscriptions.remove(eventName);
    } else {
      _subscriptions[eventName].remove(callback);
    }
  }

  void emit(eventName, [args]) {
    if (_unsafeName(eventName)) {
      return;
    }
    var callbackList = _subscriptions[eventName];
    //从后向前遍历防止callback中off本身造成的错误
    int start = callbackList.length - 1;
    for (var i = start; i > -1; i--) {
      callbackList[i](args);
    }
  }

  bool _unsafeName(eventName) {
    return eventName == null || !_subscriptions.containsKey(eventName);
  }
}
