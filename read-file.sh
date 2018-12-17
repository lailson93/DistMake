#!/bin/sh
exec scala "$0" "$@"
!#

import scala.io.Source
import scala.collection.mutable.ListBuffer

object Hello {
    def main(args: Array[String]) {
        var lastKey = ""
        
        var rules = scala.collection.mutable.Map[String, String]()
        var dependencies1 = scala.collection.mutable.Map[String, List[String]]()
        //var tuplarules = new ListBuffer[String,List[String]]()
        //var rules = new ListBuffer[Map[String,String]]()
       // var dependencies1 = new ListBuffer[Map[String,List[String]]]()
        for (line <- Source.fromFile("Makefile").getLines()) {
            val line1  = line.stripMargin.replaceAll("\t","")
            // if ( line1.isEmpty()) || () ) {
    
            if (line1.isEmpty()) {
                line1.replaceAll("\n","")
            }
            else if (!line1.contains("#")){
                if (line1.contains(":")){
                     //val teste = line1.split(':').map(x=>x.trim).toString
                     val teste = line1.split(':').map(x=>x.trim).toList
                     var newRule = teste(0)
                     lastKey = newRule
                    if (teste.size == 2){
                        var dependencies = teste(1).split(' ').map(x=>x.trim).toList
                        var listRUle = List(teste(0),dependencies)
                        dependencies1 += (teste(0) -> dependencies)
                        
                        var dependencia=  List(listRUle(0)->listRUle(1)).toMap
                        //dependencies1 += listRUle(0).toString -> listRUle(1).toString
                        
                        
                        
                        //dependencies1 += dependencia
                        //println(listRUle)
                        println(dependencia)
                        //println(dependencies1)

                    }
                    //println(teste)
                    //println(rules)
                } else {
                    if (line1 != lastKey){
                        val listCommand = List(lastKey,line1)
                        //var listCommandRule = List(listCommand(0) ->listCommand(1)).toMap
                        //testeMap += (listCommand(0) ->listCommand(1))
                        rules += (lastKey -> line1)
                        //rules+=listCommandRule
                       // val command = line1
                        
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



        //args.foreach(println)
        
    }
}

Hello.main(args)
