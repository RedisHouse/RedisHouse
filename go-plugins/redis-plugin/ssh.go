package redis_plugin

import (
	"fmt"
	"github.com/mitchellh/go-homedir"
	"golang.org/x/crypto/ssh"
	"io/ioutil"
	"log"
	"net"
)

func getSSHClient(argsMap map[interface{}]interface{}) (*ssh.Client, error) {

	addr := argsMap["sshAddress"].(string) + ":" + argsMap["sshPort"].(string)

	config := &ssh.ClientConfig{
		User: argsMap["sshUser"].(string),
		//Auth: []ssh.AuthMethod{
		//	ssh.Password(sshPassword),
		//},
		//需要验证服务端，不做验证返回nil，没有该参数会报错
		HostKeyCallback: func(hostname string, remote net.Addr, key ssh.PublicKey) error {
			return nil
		},
	}

	if _, ok := argsMap["useSSHPrivateKey"]; ok && argsMap["useSSHPrivateKey"].(bool) {
		config.Auth = []ssh.AuthMethod{
			publicKeyAuthFunc(argsMap),
		}
	} else {
		config.Auth = []ssh.AuthMethod{ssh.Password(argsMap["sshPassword"].(string))}
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

func publicKeyAuthFunc(argsMap map[interface{}]interface{}) ssh.AuthMethod {

	kPath := argsMap["sshPrivateKey"].(string)
	keyPath, err := homedir.Expand(kPath)
	if err != nil {
		log.Fatal("find key's home dir failed", err)
	}
	key, err := ioutil.ReadFile(keyPath)
	if err != nil {
		log.Fatal("ssh key file read failed", err)
	}

	var signer ssh.Signer
	if _, ok:= argsMap["sshPrivateKeyPassword"]; ok {
		signer, err = ssh.ParsePrivateKeyWithPassphrase(key, []byte(argsMap["sshPrivateKeyPassword"].(string)))
	} else {
		signer, err = ssh.ParsePrivateKey(key)

	}
	if err != nil {
		log.Fatal("ssh key signer failed", err)
	}
	return ssh.PublicKeys(signer)
}
