package listener

import (
	"fmt"
	"io"
	"net"
)

type TcpListener struct{}

func (t TcpListener) Handle(connection net.Conn) {
	var (
		buffer  []byte
		err     error
		message string
		reqLen  int
	)

	// Request pre-processing
	buffer, err = io.ReadAll(connection)
	if err != nil {
		fmt.Println("error reading:", err.Error())
	}

	message += fmt.Sprintf("[process socket] Source:%q Destination:%q\n", connection.LocalAddr(), connection.RemoteAddr())
	message += "\n"
	message += string(buffer)
	message += "\n"
	message += fmt.Sprintf("Message size received: %d bytes\n", reqLen)

	// Response
	connection.Write([]byte(message))
	connection.Close()
}
