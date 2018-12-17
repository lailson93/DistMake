#!/bin/sh
exec scala "$0" "$@"
!#


import scala.io.Source

object ParserHello {
    def parser(): Unit = {
        lastKey = Null
        for (line <- Source.fromFile("Makefile").getLines) {
            val line1 : String = line.stripMargin.replaceAll("\t","")
            // if ( line1.isEmpty()) || () ) {
    
            if (line1.isEmpty()) {
                line1.replaceAll("\n","")
            }
            else if (!line1.contains("#")){
                println(line1)
            }
        }


    }
    def debuger(): Unit = {


    }



    def main(args: Array[String]) {
        println("Hello, world")
        // if you want to access the command line args:
        for (line <- Source.fromFile("Makefile").getLines.toArray) {
            println(line)
        }   



        //args.foreach(println)
        
    }
}

Hello.main(args)