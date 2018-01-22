package ping

import (
	"github.com/gin-gonic/gin"
)

// handles POST /sym/beat route
func Handler(c *gin.Context) {
	c.String(200, "pong")
}
