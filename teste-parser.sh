#!/bin/sh
exec scala "$0" "$@"
!#


import scala.io.Source

object Parser {
    var rules = scala.collection.mutable.Map[String, String]()
    var dependencies1 = scala.collection.mutable.Map[String, List[String]]()

    def parser(): Unit = {
            var lastKey = ""
        
        //var rules = scala.collection.mutable.Map[String, String]()
       // var dependencies1 = scala.collection.mutable.Map[String, List[String]]()

        for (line <- Source.fromFile("Makefile").getLines()) {
            val line1  = line.stripMargin.replaceAll("\t","")
    
            if (line1.isEmpty()) {
                line1.replaceAll("\n","")
            }
            else if (!line1.contains("#")){
                if (line1.contains(":")){
                    val teste = line1.split(':').map(x=>x.trim).toList
                    var newRule = teste(0)
                    lastKey = newRule
                    if (teste.size == 2){
                        var dependencies = teste(1).split(' ').map(x=>x.trim).toList
                        var listRUle = List(teste(0),dependencies)
                        dependencies1 += (teste(0) -> dependencies)
                        
                        var dependencia=  List(listRUle(0)->listRUle(1)).toMap

                        //println(dependencia)

                    }

                } else {
                    if (line1 != lastKey){
                        val listCommand = List(lastKey,line1)
                        rules += (lastKey -> line1)
                        
                    } else {
                        println("problem with MakeFile format")
                    }
                }
            }
        } 
        println("dependencias: \n")
        println(dependencies1)
        println("Rules: \n")
        println(rules)  
    }
    def debuger(): Unit = {
        rules.keys.foreach( (target) =>
            //println ("target: ", target) 
            if (dependencies1.contains(target)){
                println("dependencie: ", dependencies1(target))
            } else {
                println ("no dependencies")
            }
            //println ("commands: ", rules(target))
        )
        
        
        //for ( (target,command) <- rules) {
        //    //println( "target:",target)
            
        //   for ( (target1,dependencie) <- dependencies1){
        //        if (target.contains(target1)){
        //            println ("dependencies: ",rules(target))
        //        }
        //    }
        //}

    }



    def main(args: Array[String]) {
        parser()
        debuger()
        //args.foreach(println)
        
    }
}

Parser.main(args)