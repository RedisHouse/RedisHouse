package redis_plugin

import (
	"fmt"
	"golang.org/x/crypto/ssh"
	"net"
)

func getSSHClient(sshUser, sshPassword, sshPrivateKey, sshPrivateKeyPassword, addr  string) (*ssh.Client, error) {

	config := &ssh.ClientConfig{
		User: sshUser,
		Auth: []ssh.AuthMethod{
			ssh.Password(sshPassword),
		},
		//需要验证服务端，不做验证返回nil，没有该参数会报错
		HostKeyCallback: func(hostname string, remote net.Addr, key ssh.PublicKey) error {
			return nil
		},
	}

	sshConn, err := net.Dial("tcp", addr)
	if nil != err {
		fmt.Println("net dial err: ", err)
		return nil, err
	}

	clientConn, chans, reqs, err := ssh.NewClientConn(sshConn, addr, config)
	if nil != err {
		sshConn.Close()
		fmt.Println("ssh client conn err: ", err)
		return nil, err
	}

	client := ssh.NewClient(clientConn, chans, reqs)

	return client, nil
}
