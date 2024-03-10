import 'package:flutter/material.dart';
import 'package:mno_navigator/epub.dart';
import 'package:mno_navigator/publication.dart';
import 'package:mno_navigator/src/epub/selection/selection_popup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostRequestComponent extends StatefulWidget {
  @override
  _PostRequestComponentState createState() => _PostRequestComponentState();
}

class _PostRequestComponentState extends State<PostRequestComponent> {
  bool _isLoading = false;
  String _response = 'Response will appear here';
  String _name = "Ben Gunn";
  List<String> _entries = [r"""I began to recall what I had heard of cannibals.
  I
  was within an ace of calling for help. But the mere
  fact that he was a man, however wild, had somewhat
  reassured me, and my fear of Silver began to revive in
  proportion. I stood still, therefore, and cast about for
  some method of escape ; and as I was so thinking, the
  recollection of my pistol flashed into my mind. As soon
  as I remembered I was not defenceless, courage glowed
  again in my heart ; and I set my face resolutely for
  this man of the island, and walked briskly towards
  him.
  He was concealed by this time, behind another tree
  trunk ; but he must have been watching me closely, for
  as soon as I began to move in his direction he reappeared
  and took a step to meet me. Then he hesitated, drew
  back, came forward again, and at last, to my wonder and
  confusion, threw himself on his knees and held out his
  clasped hands in supplication.
  At that I once more stopped.
  "Who are you ? " I asked.
  "Ben Gunn," he answered, and his voice sounded
  hoarse and awkward, like a rusty lock. " I'm poor
  Ben Gunn, I am; and I haven't spoke with a Christian
  these three years."
  """,

    r"""I had made my mind up in a moment, and by way
of answer told him the whole story of our voyage, and
the predicament in which we found ourselves . He
heard me with the keenest interest, and when I had
done he patted me on the head.
"You're a good lad, Jim," he said ; " and you're
all in a clove hitch, aint you? Well, you just put your
trust in Ben Gunn—Ben Gunn's the man to do it.
Would you think it likely, now, that your squire would
prove a liberal-minded one in case of help—him being in
a clove hitch, as you remark? "
I told him the squire was the most liberal of men .
66' Ay, but you see," returned Ben Gunn, "I didn't
mean giving me a gate to keep, and a shuit of livery
clothes, and such ; that's not my mark, Jim. What
I mean is, would he be likely to come down to the toon
of, say one thousand pounds out of money that's as good
as a man's own already?"
""",

    r"""me."
And I began to run towards the anchorage, my
terrors all forgotten ; while, close at my side, the
marooned man in his goatskins trotted easily and
lightly.
66 Left, left," says he ; " keep to your left hand, mate
Jim ! Under the trees with you ! Theer's where I
killed my first goat. They don't come down here now ;
they're all mastheaded on them mountings for the fear
of Benjamin Gunn. Ah ! and there's the cetemery ".
cemetery, he must have meant. " You see the mounds ?
I come here and prayed, nows and thens, when I thought
maybe a Sunday would be about doo. It weren't quite
a chapel, but it seemed more solemn like ; and then,
says you, Ben Gunn, was short- handed—no chapling,
nor so much as a Bible and a flag, you says.'
وو
So he kept talking as I ran, neither expecting nor
receiving any answer.""",
  ];

  void _submitPostRequest(
  // String name,
  // List<String> entries
  ) async {
    setState(() {
      _isLoading = true;
    });

    var url = Uri.parse('https://walrus-app-z3kru.ondigitalocean.app/summarise?entity=character');
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "name": _name,
        "entity": "character",
        "entries": _entries,
      }),
    );

    setState(() {
      _isLoading = false;
      if (response.statusCode == 200) {
        _response = json.decode(response.body);
      } else {
        _response = 'Error: ${response.reasonPhrase}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _submitPostRequest,
              child: Text('Get AI Summary'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_response),
            ),
          ],
        );
  }
}
