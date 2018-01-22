package main

import (
  "github.com/gin-gonic/gin"
  "flag"
  "fmt"

  beat "github.com/karpikpl/gin1/pkg/beat"
  ping "github.com/karpikpl/gin1/pkg/ping"
)

func setupRouter(mode string) *gin.Engine {
    gin.SetMode(    mode)

  r := gin.Default()

  r.GET("/ping", ping.Handler)
  r.POST("/sym/beat", beat.Handler)

  return r
}

func main()  {

       portPtr := flag.Int("p", 8080,       "port")
  modePtr := flag.String("mode", "debug", "Mode - 'release' or 'debug'")
  flag.Parse()

  fmt.Printf("Starting gin on %d in %s mode\n", *modePtr)

  r := setupRouter(*modePtr);
  r.Run(fmt.Sprintf(":%d", *portPtr))
}
