package utils

import (
	"encoding/base64"
	"strconv"

	"github.com/IbraSuraya/suraya/config"
	"golang.org/x/crypto/argon2"
)

var viper = config.NewViper()
var size_salt, _ = strconv.Atoi(viper.GetString("utils.pass.size_salt"))
var time, _ = strconv.Atoi(viper.GetString("utils.pass.argon2.time"))
var memory, _ = strconv.Atoi(viper.GetString("utils.pass.argon2.memory"))
var threads, _ = strconv.Atoi(viper.GetString("utils.pass.argon2.threads"))
var keyLen, _ = strconv.Atoi(viper.GetString("utils.pass.argon2.keyLen"))

func HashArgon2(password string) (string, string, error) {
	salt, err := GenerateSalt(size_salt)
	if err != nil {
		return "", "", err
	}
	key := argon2.IDKey([]byte(password), salt, uint32(time), uint32(memory), uint8(threads), uint32(keyLen))
	hashBase64 := base64.StdEncoding.EncodeToString(key)
	saltBase64 := base64.StdEncoding.EncodeToString(salt)
	return hashBase64, saltBase64, nil
}

func VerifyArgon2(password, hashBase64, saltBase64 string) bool {
	salt, _ := base64.StdEncoding.DecodeString(saltBase64)
	key := argon2.IDKey([]byte(password), salt, uint32(time), uint32(memory), uint8(threads), uint32(keyLen))
	hashNewBase64 := base64.StdEncoding.EncodeToString(key)
	return hashBase64 == hashNewBase64
}
