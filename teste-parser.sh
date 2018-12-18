#!/bin/sh
exec scala "$0" "$@"
!#


import scala.io.Source

object Parser {
    var rules = scala.collection.mutable.Map[String, String]()
    var dependencies1 = scala.collection.mutable.Map[String, List[String]]()
    var stack_dependencies = scala.collection.mutable.Stack[String]()
    var stack_dependencies1 = scala.collection.mutable.Stack[String]()

    def parser(): Unit = {
        var lastKey = ""
        
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
                    
                        dependencies1 = dependencies1+ (teste(0) -> dependencies)
                        //println(dependencies1)

                    }
                    else if (teste.size == 1){
                        dependencies1 = dependencies1+ (teste(0) -> List("empty"))
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
        var root = ""


        dependencies1.keys.foreach( (target) =>
            if (target ==  "all"){
                stack_dependencies.push(dependencies1(target)(0))
                root = stack_dependencies.pop()
                engine()
            } 
        )
        def engine(){
            if (dependencies1.contains(root)){
                for (x <- 0 to (dependencies1(root).size)-1 ){
                    stack_dependencies1.push(dependencies1(root)(x))
                    stack_dependencies.push(dependencies1(root)(x))
                    println(dependencies1(root)(x))
                }
                root = stack_dependencies.pop()
                engine()
            } else {
                println("no contents")
                stack_dependencies.pop()
                engine()
            }
        }

   
        //rules.keys.foreach( (target) =>
            //println ("target: ", target) 
            //if (dependencies1.contains(target)){
                //println("dependencie: ", dependencies1(target))
            //} else {
            //    println ("no dependencies")
            //}
            //println ("commands: ", rules(target))
        // )
        
        
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