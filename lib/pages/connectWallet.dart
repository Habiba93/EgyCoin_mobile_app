import 'dart:convert';
import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class wallet extends StatefulWidget {
  const wallet({Key? key}) : super(key: key);

  @override
  State<wallet> createState() => _walletState();
}

class _walletState extends State<wallet> {
  var CONTRACT_ABI = [
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "spender",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "value",
				"type": "uint256"
			}
		],
		"name": "approve",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "spender",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "allowance",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "needed",
				"type": "uint256"
			}
		],
		"name": "ERC20InsufficientAllowance",
		"type": "error"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "sender",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "balance",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "needed",
				"type": "uint256"
			}
		],
		"name": "ERC20InsufficientBalance",
		"type": "error"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "approver",
				"type": "address"
			}
		],
		"name": "ERC20InvalidApprover",
		"type": "error"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "receiver",
				"type": "address"
			}
		],
		"name": "ERC20InvalidReceiver",
		"type": "error"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "sender",
				"type": "address"
			}
		],
		"name": "ERC20InvalidSender",
		"type": "error"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "spender",
				"type": "address"
			}
		],
		"name": "ERC20InvalidSpender",
		"type": "error"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "owner",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "spender",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "value",
				"type": "uint256"
			}
		],
		"name": "Approval",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "to",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "value",
				"type": "uint256"
			}
		],
		"name": "transfer",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "from",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "to",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "value",
				"type": "uint256"
			}
		],
		"name": "Transfer",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "from",
				"type": "address"
			},
			{
				"internalType": "address",
				"name": "to",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "value",
				"type": "uint256"
			}
		],
		"name": "transferFrom",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "owner",
				"type": "address"
			},
			{
				"internalType": "address",
				"name": "spender",
				"type": "address"
			}
		],
		"name": "allowance",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "account",
				"type": "address"
			}
		],
		"name": "balanceOf",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "decimals",
		"outputs": [
			{
				"internalType": "uint8",
				"name": "",
				"type": "uint8"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "name",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "symbol",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "totalSupply",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
];

  var CONTRACT_ADDRESS = '0x950a44fdcdba3eac4a18611e8fa8f17c4e23fba6';

  late W3MService _w3mService;
  TextEditingController _receiverController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeWeb3Model();
  }

  void _initializeWeb3Model() async {
    W3MChainPresets.chains.putIfAbsent('11155111', () => _sepoliaChain);
    _w3mService = W3MService(
      projectId: '0fefcc9c27553a0a7a1d186e8f47361e',
      metadata: const PairingMetadata(
        name: 'EgyCoin',
        description: 'First Dapp CBDC in Egypt',
        url: 'https://www.walletconnect.com/',
        icons: ['https://walletconnect.com/walletconnect-logo.png'],
        redirect: Redirect(
          native: 'eth_app://',
          universal: 'https://www.walletconnect.com',
        ),
      ),
    );
    await _w3mService.init();
  }

  void signMessage() async {
    _w3mService.launchConnectedWallet();
    var hash = await _w3mService.web3App!.request(
      topic: _w3mService.session?.topic ?? 'default topic',
      chainId: 'eip155:11155111',
      request: SessionRequestParams(
        method: 'personal_sign',
        params: ['welcome karim tareek', CONTRACT_ADDRESS],
      ),
    );
    debugPrint(hash);
  }

  String? getUserWalletAddress() {
    if (_w3mService.isConnected && _w3mService.session != null) {
      print('My login wallet is : ${_w3mService.session?.address}');
      return _w3mService.session?.address;
    }
    return null;
  }
 Future<void> erc20BalanceOf() async {
    final deployedContract = DeployedContract(
      ContractAbi.fromJson(jsonEncode(CONTRACT_ABI), 'EGYCOIN'),
      EthereumAddress.fromHex(CONTRACT_ADDRESS),
    );
    final result = await _w3mService.requestReadContract(
      deployedContract: deployedContract,
      functionName: 'balanceOf',
      rpcUrl: 'https://rpc.sepolia.org/',
      parameters: [
        EthereumAddress.fromHex(await getUserWalletAddress() ?? ''),
      ],
    );
    print('My balance: $result');
  }




Future<void> transferToOtherAccount() async {
  final receiverAddress = _receiverController.text;
  final amountInput = double.tryParse(_amountController.text) ?? 0.0;
  final decimals = 18;
  final baseUnitAmount = BigInt.from(amountInput * pow(10, decimals));

  final senderAddress = _w3mService.session?.address;
  if (senderAddress == null || receiverAddress.isEmpty) {
    print('Transfer failed: Invalid sender or receiver address');
    return;
  }

  try {
    final contractAbiJson = jsonEncode(CONTRACT_ABI);
    final deployedContract = DeployedContract(
      ContractAbi.fromJson(contractAbiJson, 'EGYCOIN'),
      EthereumAddress.fromHex(CONTRACT_ADDRESS),
    );

    final result = await _w3mService.requestWriteContract(
      topic: _w3mService.session?.topic ?? 'default topic',
      chainId: 'eip155:11155111',
      rpcUrl: 'https://rpc.sepolia.org/',
      deployedContract: deployedContract,
      functionName: 'transfer',
      transaction: Transaction(
        from: EthereumAddress.fromHex(senderAddress),
        to: EthereumAddress.fromHex('0xcd223b3f8f2f392190592deffcf1ebd6b8283941'), // Corrected this line
        value: EtherAmount.zero(),
        data: Uint8List.fromList('0x'.codeUnits), // Adding empty data
        gasPrice: EtherAmount.inWei(BigInt.from(1000000000)), // Gas price in wei
        maxGas: 1000000, // Maximum gas
      ),
      parameters: [EthereumAddress.fromHex('0xcd223b3f8f2f392190592deffcf1ebd6b8283941'), baseUnitAmount], // Corrected this line
    );

    print('Transfer successful: $result');
  } catch (e) {
    print('Transfer failed: $e');
  }
}






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EgyCoin Wallet"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Welcome to the Decentralized App",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: 20),
            TextField(
              controller: _receiverController,
              decoration: InputDecoration(
                labelText: 'Receiver Address',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Amount to Transfer',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: transferToOtherAccount,
              child: Text("Transfer"),
            ),
            SizedBox(height: 20),
            W3MConnectWalletButton(service: _w3mService),
            SizedBox(height: 10),
            W3MNetworkSelectButton(service: _w3mService),
            SizedBox(height: 10),
            W3MAccountButton(service: _w3mService),
          ],
        ),
      ),
    );
  }
}

const _chainId = '11155111';

final _sepoliaChain = W3MChainInfo(
  chainName: 'EGYCOIN',
  chainId: _chainId,
  namespace: 'eip155:$_chainId',
  tokenName: 'EGYCOIN',
  rpcUrl: 'https://rpc.sepolia.org/',
  blockExplorer: W3MBlockExplorer(
    name: 'Sepolia Explorer',
    url: 'https://sepolia.etherscan.io/',
  ),
);

final CONTRACT_ABI = [
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "spender",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "value",
				"type": "uint256"
			}
		],
		"name": "approve",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "spender",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "allowance",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "needed",
				"type": "uint256"
			}
		],
		"name": "ERC20InsufficientAllowance",
		"type": "error"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "sender",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "balance",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "needed",
				"type": "uint256"
			}
		],
		"name": "ERC20InsufficientBalance",
		"type": "error"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "approver",
				"type": "address"
			}
		],
		"name": "ERC20InvalidApprover",
		"type": "error"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "receiver",
				"type": "address"
			}
		],
		"name": "ERC20InvalidReceiver",
		"type": "error"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "sender",
				"type": "address"
			}
		],
		"name": "ERC20InvalidSender",
		"type": "error"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "spender",
				"type": "address"
			}
		],
		"name": "ERC20InvalidSpender",
		"type": "error"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "owner",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "spender",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "value",
				"type": "uint256"
			}
		],
		"name": "Approval",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "to",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "value",
				"type": "uint256"
			}
		],
		"name": "transfer",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "from",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "to",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "value",
				"type": "uint256"
			}
		],
		"name": "Transfer",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "from",
				"type": "address"
			},
			{
				"internalType": "address",
				"name": "to",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "value",
				"type": "uint256"
			}
		],
		"name": "transferFrom",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "owner",
				"type": "address"
			},
			{
				"internalType": "address",
				"name": "spender",
				"type": "address"
			}
		],
		"name": "allowance",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "account",
				"type": "address"
			}
		],
		"name": "balanceOf",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "decimals",
		"outputs": [
			{
				"internalType": "uint8",
				"name": "",
				"type": "uint8"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "name",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "symbol",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "totalSupply",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
];

const CONTRACT_ADDRESS = '0x950a44fdcdba3eac4a18611e8fa8f17c4e23fba6';
