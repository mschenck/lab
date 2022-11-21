package listener

import "net"

type Listener interface {
	Handle(net.Conn)
}
