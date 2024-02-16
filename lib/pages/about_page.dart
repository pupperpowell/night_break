import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Text(
                'about this app',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '''night break is an app designed specifically for the staff (current and former) of the metropolis of boston camp, which theoretically allows for a tailored social media experience, unlike traditional apps like instagram or facebook.
      
                  night break's features are unique from other platforms, and are entirely determined by the staff who use it. a roadmap of features will be created in the future.
                  
                  This app is an independent platform created by George Powell and is not officially affiliated with the Metropolis of Boston Camp or the Greek Orthodox Metropolis of Boston. Any views or opinions expressed on this platform are those of the individual users and do not necessarily reflect the official positions or policies of the camp or the metropolis.''',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
