#!/bin/sh
exec scala "$0" "$@"
!#

import scala.io.Source
import scala.collection.mutable.ListBuffer

object Hello {
    def main(args: Array[String]) {
        var lastKey = ""
        
        var testeMap = scala.collection.mutable.Map[String, String]()
        var rules = new ListBuffer[Map[String,String]]()
        var dependencies1 = new ListBuffer[Map[String,List[String]]]()
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
                        //tuplarules += List(teste(0),dependencies)
                        var listRUle = List(teste(0),dependencies)
                        var dependencia=  List(listRUle(0)->listRUle(1)).toMap
                        //dependencies1 += dependencia
                        //println(listRUle)
                        //println(dependencies)
                        //println(dependencia)

                    }
                    //println(teste)
                    //println(rules)
                } else {
                    if (line1 != lastKey){
                        val listCommand = List(lastKey,line1)
                        //var listCommandRule = List(listCommand(0) ->listCommand(1)).toMap
                        //testeMap += (listCommand(0) ->listCommand(1))
                        testeMap += (lastKey -> line1)
                        //rules+=listCommandRule
                       // val command = line1
                        
                    } else {
                        println("problem with MakeFile format")
                    }
                }
            }
        } 
        //println(dependencies1)
        println(testeMap)  



        //args.foreach(println)
        
    }
}

Hello.main(args)
