import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


 class calenderPage extends StatefulWidget {
  @override
  _calenderPageState createState() => _calenderPageState();
}

class _calenderPageState extends State<calenderPage> {
  
  
  CalendarController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    
    super.initState();
    _controller = CalendarController();
} 

@override

Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Calendar'),
        backgroundColor: Colors.cyan,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              initialCalendarFormat: CalendarFormat.month,
              //dayHitTestBehavior: HitTestBehavior.deferToChild,
              
              calendarStyle: CalendarStyle(
                  todayColor: Colors.orange,
                  selectedColor: Colors.cyan,
                  todayStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white)),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                
                formatButtonDecoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(color: Colors.white),
                formatButtonShowsNext: false,
                
              ),
              startingDayOfWeek: StartingDayOfWeek.saturday,
              onDaySelected: onSelected,
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,

                    decoration: BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                todayDayBuilder: (context, date, events) => Container(
                  
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),

              ),
              calendarController: _controller,
            )
          ],
        ),
      ),
    );
  }

  void onSelected(DateTime day, List events){
    
      _show(context, day.day.toString());
  }



  Future _show(BuildContext context, String day) async{

showDialog(
                context: context,
                builder: (BuildContext context) {
    return AlertDialog(
                      title: Text('On This Day'),
                      titleTextStyle: TextStyle (
                        //backgroundColor: Colors.cyan,
                        color: Colors.cyan,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600, 
                      ), 
                      content: Container(
                        padding: EdgeInsets.all(5.0),
                        width: 230.0,
                        height: 110.0,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child : Row(
                                  children: <Widget>[
                                    Text('Measurement: '),

                                    Container(
                                      child: Text(''),
                                    )
                                  ],
                                  
                                )  
                              ),

                              Container(
                                padding: EdgeInsets.all(5.0),
                                child : Row(
                                  children: <Widget>[
                                    Text('Mood: '),

                                    Container(
                                      child: Text(''),
                                    )
                                  ],
                                  
                                )  
                              ),

                              Container(
                                padding: EdgeInsets.all(5.0),
                                child : Row(
                                  children: <Widget>[
                                    Text('Meal: '),

                                    Container(
                                      child: Text(''),
                                    )
                                  ],
                                  
                                ) 
                              ),
                            ],
                          ),
                        ),
                      ));
                });

  }
}