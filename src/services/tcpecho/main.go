package main

import (
	"bytes"
	"fmt"
	"io"
	"net"
	"os"
	"strings"

	"github.com/mailgun/proxyproto"
)

const (
	LISTEN_HOST = "localhost"
	LISTEN_PORT = "1337"
	BUFFER_LEN  = 512
)

var (
	V1Identifier = []byte("PROXY ")
	V2Identifier = []byte("\r\n\r\n\x00\r\nQUIT\n")
)

func tcpHandler(connection net.Conn) error {
	var (
		buffer         = make([]byte, BUFFER_LEN)
		ppHeaderBuffer []byte
		proxyReader    io.Reader
		err            error
		ppHeaders      *proxyproto.Header
		message        string
	)

	// Request pre-processing
	reqLen, err := connection.Read(buffer)
	if err != nil {
		fmt.Println("Error reading:", err.Error())
	}

	// Attempt proxy protocol parsing
	copy(ppHeaderBuffer, buffer)
	if bytes.HasPrefix(ppHeaderBuffer, V2Identifier) || bytes.HasPrefix(ppHeaderBuffer, V1Identifier) {
		// Proxy proto found
		proxyReader = bytes.NewReader(ppHeaderBuffer)
		ppHeaders, err = proxyproto.ReadHeader(proxyReader)
		if err != nil {
			return fmt.Errorf("failed to parse proxy protocol header")
		}
		message += fmt.Sprintf("[proxy protocol] %v", ppHeaders)
		buffer = ppHeaderBuffer
	}

	message += fmt.Sprintf("[Process socket] Local Address:%q\n", connection.LocalAddr())
	message += fmt.Sprintf("[Process socket] Remote Address:%q\n", connection.RemoteAddr())
	message += fmt.Sprintf("Message received(%d bytes):%q\n", reqLen, buffer)

	// Response
	connection.Write([]byte(message))
	connection.Close()
	return nil
}

func main() {
	var (
		socketAddr string
		socket     net.Listener
		connection net.Conn
		err        error
	)

	socketAddr = strings.Join([]string{LISTEN_HOST, LISTEN_PORT}, ":")
	socket, err = net.Listen("tcp", socketAddr)
	if err != nil {
		fmt.Println("Error listening:", err.Error())
		os.Exit(1)
	}
	defer socket.Close()

	fmt.Println("Listening on ", socketAddr)
	for {
		connection, err = socket.Accept()
		if err != nil {
			fmt.Println("Error accepting: ", err.Error())
			os.Exit(1)
		}
		go tcpHandler(connection)
	}
}
