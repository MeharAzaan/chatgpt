import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../Model/chatgptprovider.dart';
import 'package:provider/provider.dart';

import '../Model/uielement.dart';
class Chromeai extends StatefulWidget {
  const Chromeai({super.key});
  @override
  State<Chromeai> createState() => _ChromeaiState();
}

class _ChromeaiState extends State<Chromeai> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          'ChatGpt',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 260,
            color: const Color(0xFF1E293B),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Uielements.newchatButton(
                      () {
                    context.read<chatprovider>().emptylist();
                  },
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: const Text(
                    'Recent Chats',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Consumer<chatprovider>(
                    builder: (context, provider, child) {
                      if (provider.history.isEmpty) {
                        return const Center(
                          child: Text(
                            'No history',
                            style: TextStyle(color: Colors.white54),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: provider.history.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Text(
                              provider.history[index],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('Upgrade to Pro'),
                  ),
                ),
              ],
            ),
          ),

          // Main Chat Area
          Expanded(
            child: Column(
              children: [
                // Chat messages
                Expanded(
                  child: Consumer<chatprovider>(
                    builder: (context, provider, child) {
                      if (provider.input.isEmpty) {
                        return const Center(
                          child: Text(
                            'Start a conversation...',
                            style: TextStyle(color: Colors.black54),
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        itemCount: provider.input.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // User message
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 4),
                                  padding: const EdgeInsets.all(12),
                                  constraints:
                                  const BoxConstraints(maxWidth: 420),
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    provider.input[index],
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),

                              // Bot response or loading
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 4),
                                  padding: const EdgeInsets.all(12),
                                  constraints:
                                  const BoxConstraints(maxWidth: 420),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: index < provider.response.length
                                      ? Text(
                                    provider.response[index],
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 15),
                                  )
                                      : (provider.loading &&
                                      index ==
                                          provider.input.length - 1)
                                      ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child:
                                    CircularProgressIndicator(),
                                  )
                                      : const SizedBox.shrink(),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),

                // Input field
                Container(
                  color: const Color(0xFFF3F4F6),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: textController,
                          decoration: InputDecoration(
                            hintText: "Ask anything...",
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.send, color: Colors.blueAccent),
                        onPressed: () {
                          final text = textController.text.trim();
                          if (text.isNotEmpty) {
                            context.read<chatprovider>().sendRequest(text);
                            textController.clear();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
