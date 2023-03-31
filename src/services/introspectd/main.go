// Introspectd - Handles requests and reports back about the given request and
// environment it's running in.
package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"strings"
)

func main() {
	http.HandleFunc("/", handler)
	log.Fatal(http.ListenAndServe("0.0.0.0:8000", nil))
}

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "%q %q %q\n\n", r.Method, r.URL, r.Proto)

	// Request headers
	fmt.Fprintln(w, "Headers:")
	for k, v := range r.Header {
		var output string
		if len(v) > 1 {
			output = "[" + strings.Join(v, ", ") + "]"
		} else {
			output = strings.Join(v, "")
		}
		fmt.Fprintf(w, "%32v\t%v\n", fmt.Sprintf("%s", k), output)
	}
	fmt.Fprintln(w, "")

	// OS Env
	fmt.Fprintln(w, "Env:")
	for _, envStr := range os.Environ() {
		parts := strings.Split(envStr, "=")
		fmt.Fprintf(w, "%32v\t%v\n", parts[0], strings.Join(parts[1:], "="))
	}
	fmt.Fprintln(w, "Update2!")

	fmt.Fprintln(w, "")
}
