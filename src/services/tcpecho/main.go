package main

import (
	"fmt"
	"net"
	"os"
	"strings"

	"github.com/mschenck/lab/src/services/tcpecho/listener"
)

const (
	LISTEN_HOST = "0.0.0.0"
	LISTEN_PORT = "1337"
	BUFFER_LEN  = 512
)

func main() {

	var (
		socketAddr string
		socket     net.Listener
		connection net.Conn
		err        error

		// Parse env
		isProxyProto = os.Getenv("PROXY_PROTO")
		listenPort   = os.Getenv("LISTEN_PORT")

		// Setup listeners
		autodetect = listener.AutoDetectListener{}
		proxy      = listener.ProxyListener{}
		tcp        = listener.TcpListener{}
		listener   listener.Listener
	)

	fmt.Printf("isProxyProto: %q\n", isProxyProto)
	if isProxyProto == "auto" {
		listener = autodetect
	} else if isProxyProto == "proxy" {
		listener = proxy
	} else {
		listener = tcp
	}

	if listenPort == "" {
		listenPort = LISTEN_PORT
	}

	socketAddr = strings.Join([]string{LISTEN_HOST, listenPort}, ":")
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
		go listener.Handle(connection)
	}
}
