package listener

import (
	"fmt"
	"io"
	"net"

	"github.com/mailgun/proxyproto"
)

type ProxyListener struct{}

func (p ProxyListener) Handle(connection net.Conn) {
	var (
		buffer    []byte
		err       error
		ppHeaders *proxyproto.Header
		message   string
		reqLen    int
	)

	// Request pre-processing
	ppHeaders, err = proxyproto.ReadHeader(connection)
	if err != nil {
		fmt.Println("error reading proxy headers:", err.Error())
		connection.Close()
		return
	}
	buffer, err = io.ReadAll(connection)
	if err != nil {
		fmt.Println("error reading data:", err.Error())
	}

	message += fmt.Sprintf("[proxy protocol] Source:%q Destination:%q Version:%d\n", ppHeaders.Source, ppHeaders.Destination, ppHeaders.Version)
	message += fmt.Sprintf("[process socket] Source:%q Destination:%q\n", connection.LocalAddr(), connection.RemoteAddr())
	message += "\n"
	message += string(buffer)
	message += "\n"
	message += fmt.Sprintf("Message size received: %d bytes\n", reqLen)

	// Response
	connection.Write([]byte(message))
	connection.Close()
}
