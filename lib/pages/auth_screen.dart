import 'package:egycoin_mobile_app/pages/transfer_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:egycoin_mobile_app/pages/home_page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

enum SupportState { unknown, supported, unSupported }

class _AuthScreenState extends State<AuthScreen> {
  final LocalAuthentication _auth = LocalAuthentication();
  SupportState _supportState = SupportState.unknown;
  List<BiometricType>? _availableBiometrics;

  @override
  void initState() {
    super.initState();
    _checkBiometricSupport();
    _getAvailableBiometrics();
  }

  Future<void> _checkBiometricSupport() async {
    late bool isBiometricSupported;
    try {
      isBiometricSupported = await _auth.isDeviceSupported();
      print("Biometric supported: $isBiometricSupported");
    } on PlatformException catch (e) {
      print(e);
      isBiometricSupported = false;
    }

    setState(() {
      _supportState =
          isBiometricSupported ? SupportState.supported : SupportState.unSupported;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> biometricTypes;
    try {
      biometricTypes = await _auth.getAvailableBiometrics();
      print('Supported biometrics $biometricTypes');
    } on PlatformException catch (e) {
      print(e);
      biometricTypes = [];
    }

    if (!mounted) return;

    setState(() {
      _availableBiometrics = biometricTypes;
    });
  }

  Future<void> _authenticateWithBiometrics() async {
    try {
      final authenticated = await _auth.authenticate(
        localizedReason: 'Authenticate with fingerprint',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (!mounted) return;

      if (authenticated) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  void _navigateToTransactionSuccessfulScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TransferSuccessScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometric Authentication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _supportState == SupportState.supported
                  ? 'Biometric authentication is supported on this device'
                  : _supportState == SupportState.unSupported
                      ? 'Biometric authentication is not supported on this device'
                      : 'Checking biometric support...',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _supportState == SupportState.supported
                    ? Colors.green
                    : _supportState == SupportState.unSupported
                        ? Colors.red
                        : Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Center(child: Text('Supported biometrics: $_availableBiometrics')),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/icons/fingerprint.png',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _authenticateWithBiometrics,
                  child: const Text('Authenticate with fingerprint'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
