package listener

import (
	"bytes"
	"fmt"
	"io"
	"net"

	"github.com/mailgun/proxyproto"
)

const (
	BUFFER_LEN = 512
)

var (
	V1Identifier = []byte("PROXY ")
	V2Identifier = []byte("\r\n\r\n\x00\r\nQUIT\n")
)

type AutoDetectListener struct{}

func (a AutoDetectListener) Handle(connection net.Conn) {
	var (
		buffer      = make([]byte, BUFFER_LEN)
		proxyReader io.Reader
		err         error
		ppHeaders   *proxyproto.Header
		message     string
	)

	// Request pre-processing
	reqLen, err := connection.Read(buffer)
	if err != nil {
		fmt.Println("error reading:", err.Error())
	}

	// Attempt proxy protocol parsing
	if bytes.HasPrefix(buffer, V2Identifier) || bytes.HasPrefix(buffer, V1Identifier) {

		// Proxy proto found
		proxyReader = bytes.NewReader(buffer)
		ppHeaders, err = proxyproto.ReadHeader(proxyReader)
		if err != nil {
			fmt.Println("failed to parse proxy protocol header")
		}
		message += fmt.Sprintf("[proxy protocol] Source:%q: Destination:%q version:%d\n", ppHeaders.Source, ppHeaders.Destination, ppHeaders.Version)
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
