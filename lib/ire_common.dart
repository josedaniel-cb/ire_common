library ire_common;

// /// A Calculator.
// class Calculator {
//   /// Returns [value] plus 1.
//   int addOne(int value) => value + 1;
// }

export 'src/domain/domain_task.dart' show DomainTask;

export 'src/error/base_exception.dart' show BaseException;
export 'src/error/domain_exception.dart' show DomainException;
export 'src/error/http_client_exception.dart' show HttpClientException;
export 'src/error/repository_exception.dart' show RepositoryException;

export 'src/http/http_client.dart' show HttpClient, SerializerFnExtensions;

export 'src/persistent_storage.dart' show PersistentStorage;

export 'src/result.dart' show Result, Task;
