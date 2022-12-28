//> using scala "3.1"
//> using lib "com.lihaoyi::cask:0.8.3"

import scala.util.*
import Properties.*
import java.time.*

/**
  * package/run with: 
    {{{
      which scala-cli || brew install Virtuslab/scala-cli/scala-cli
      scala-cli package App.scala -o app.jar -f --assembly
      java -jar app.jar
    }}}

    or just

    {{{
      scala-cli App.scala
    }}}
  */
object App extends cask.MainRoutes {

  @cask.get("/")
  def getRoot() = s"""GET /health
                     |GET /host
                     |GET /env
                     |GET /props""".stripMargin

  extension (str : String) {
    def quoted = s"\"$str\""
  }
  extension (map : Map[String, _]) {
    def asJson = map.map {
      case (k, null) => s"${k.quoted} : null"
      case (k, v) => s"${k.quoted} : ${v.toString.quoted}"
    }.mkString("{\n\t",",\n\t","}")
  }

  @cask.get("/health")
  def getHealthCheck() = s"${ZonedDateTime.now(ZoneId.of("UTC"))}"
  
  @cask.get("/host")
  def getHost() = java.net.InetAddress.getLocalHost().getHostName()

  @cask.get("/env")
  def getEnv() = sys.env.asJson

  @cask.get("/props")
  def getProps() = sys.props.toMap.asJson

  override def host: String = "0.0.0.0"
  override def port = envOrElse("PORT", propOrElse("PORT", 8080.toString)).toInt

  initialize()

  println(s""" 🚀 running on $host:$port {verbose : $verbose, debugMode : $debugMode }  🚀""")
}