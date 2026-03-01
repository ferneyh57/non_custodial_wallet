import 'package:dio/dio.dart';

/// Exception for JSON-RPC errors from the Alchemy API.
class RpcException implements Exception {
  final String message;
  final int? code;

  const RpcException(this.message, {this.code});

  bool get isSponsoredRequired => message.contains('sponsored operations');

  @override
  String toString() => 'RpcException: $message';
}

/// Dio-based JSON-RPC 2.0 client for Alchemy endpoints.
///
/// Supports two URL modes:
/// - Fixed [baseUrl] set at construction (e.g. swap datasource)
/// - Per-call [url] parameter (e.g. token/transfer with network.rpcUrl)
class AlchemyRpcClient {
  final Dio _dio;
  final String? baseUrl;

  AlchemyRpcClient(this._dio, {this.baseUrl});

  /// Executes a JSON-RPC call and returns `result` as `Map<String, dynamic>`.
  Future<Map<String, dynamic>> call({
    required String method,
    required List<dynamic> params,
    String? url,
  }) async {
    final targetUrl = url ?? baseUrl;
    assert(targetUrl != null, 'Either baseUrl or per-call url must be provided');

    final response = await _dio.post<Map<String, dynamic>>(
      targetUrl!,
      data: {
        'jsonrpc': '2.0',
        'id': 1,
        'method': method,
        'params': params,
      },
    );

    final json = response.data;
    if (json == null) {
      throw RpcException('Empty response from RPC', code: -1);
    }

    if (json.containsKey('error')) {
      final error = json['error'] as Map<String, dynamic>;
      final message = error['message'] as String? ?? 'Unknown RPC error';
      final code = error['code'] as int?;
      throw RpcException(message, code: code);
    }

    return json['result'] as Map<String, dynamic>;
  }
}
