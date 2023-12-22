import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:flutter/material.dart';

class WorkerCard extends StatefulWidget {
  WorkerCard({
    super.key,
    required this.name,
    required this.rate,
    required this.ratenum,
    required this.profileimg,
    required this.peice,
  });
  final String name;
  final String rate;
  final String ratenum;
  final String profileimg;
  final String peice;

  @override
  State<WorkerCard> createState() => _WorkerCardState();
}

class _WorkerCardState extends State<WorkerCard> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: context.getHeight(divide: 7),
        width: context.getWidth(divide: 1.1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xffeff0eb),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                  height: context.getHeight(divide: 8.5),
                  width: context.getWidth(divide: 4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      "${widget.profileimg}",
                      fit: BoxFit.fill,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text("السعر التقريبي ${widget.peice}رس"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.green[300]),
                      Text(widget.rate),
                      Text(
                        widget.ratenum,
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.grey[500]),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey[500]),
                      Text(
                        "7 كم",
                        style: TextStyle(color: Colors.grey[500]),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 90),
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        isFav = true;
                        print(isFav);
                      });
                    },
                    icon: Icon(isFav ? Icons.favorite : Icons.favorite_border)))
          ],
        ));
  }
}

class kdmatWedget extends StatelessWidget {
  const kdmatWedget({
    super.key,
    required this.img,
    required this.text,
  });
  final String img;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: context.getHeight(divide: 5.4),
        width: context.getWidth(divide: 2.5),
        color: Color(0xffeff0eb),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(img)),
            ),
            Text(
              text,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
