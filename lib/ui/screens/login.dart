import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:pantry_mate/ui/widgets/google_sign_in_button.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Private methods within build method help us to
    // organize our code and recognize structure of widget
    // that we're building:
    BoxDecoration _buildBackground() {
      return BoxDecoration(
          image: DecorationImage(
        image: AssetImage('' /* assets/brooke-lark-unsplash.jpg */),
        fit: BoxFit.cover,
      ));
    }

    /**************************************
     * Need to update the Text to Pantry Items or create new method
     **************************************/
    Text _buildText() {
      return Text(
        'Recipes',
        style: Theme.of(context).textTheme.headline,
        textAlign: TextAlign.center,
      );
    }

    return Scaffold(
      backgroundColor: Colors.orange,
      // decoration: _buildBackground(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildText(),
            // Space between "Recipes" and the button:
            SizedBox(height: 50.0),
            GoogleSignInButton(
              onPressed: () =>
                  // Replace the current page.
                  // After navigating to replacement, it's not possible
                  // to go back to the previous page.
                  Navigator.of(context).pushReplacementNamed('/'),
            )
          ],
        ),
      ),
    );
  }
}
