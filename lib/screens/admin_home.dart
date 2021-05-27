import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tvshowsapp/screens/update_tv_show.dart';
import 'package:animate_do/animate_do.dart';
import 'package:tvshowsapp/screens/update_tv_show_home.dart';
import 'package:tvshowsapp/screens/view_admin.dart';
import 'package:tvshowsapp/screens/delete_tv_show.dart';
import 'package:tvshowsapp/screens/view_admin.dart';

import 'add_tv_show.dart';
import 'delete_tv_show.dart';

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Image.asset("assets/grd.jpg", fit: BoxFit.cover),
          title: Text(
            "                        Admin Panel",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                  color: Colors.grey[900], letterSpacing: .5, fontSize: 16),
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                  icon: Icon(
                Icons.format_list_bulleted_outlined,
                color: Colors.green[900],
              )),
              Tab(
                  icon: Icon(
                Icons.post_add,
                color: Colors.green[900],
              )),
              Tab(
                  icon: Icon(
                Icons.edit,
                color: Colors.green[900],
              )),
              Tab(
                  icon: Icon(
                Icons.delete_outline,
                color: Colors.red[900],
              )),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            new ViewAdmin(),
            new AddTvShows(),
            new UpdateShow(),
            new DeleteShow(),
          ],
        ),
      ),
    );
  }
}
