package utils

import (
	"encoding/base64"
	"strconv"

	"github.com/spf13/viper"
	"golang.org/x/crypto/argon2"
)

func getConfigHashArgon2(viper *viper.Viper) (int, int, int, int, int, string) {
	size_salt, _ := strconv.Atoi(viper.GetString("utils.pass.size_salt"))
	time, _ := strconv.Atoi(viper.GetString("utils.pass.argon2.time"))
	memory, _ := strconv.Atoi(viper.GetString("utils.pass.argon2.memory"))
	threads, _ := strconv.Atoi(viper.GetString("utils.pass.argon2.threads"))
	keyLen, _ := strconv.Atoi(viper.GetString("utils.pass.argon2.keyLen"))
	pepper := viper.GetString("utils.pass.argon2.keyLen")

	return size_salt, time, memory, threads, keyLen, pepper
}

func HashArgon2(password string, viper *viper.Viper) (string, string, error) {
	size_salt, time, memory, threads, keyLen, pepper := getConfigHashArgon2(viper)
	passwordBytes := []byte(password + pepper)

	salt, err := GenerateSalt(size_salt)
	if err != nil {
		return "", "", err
	}
	hash := argon2.IDKey(passwordBytes, salt, uint32(time), uint32(memory), uint8(threads), uint32(keyLen))
	hashBase64 := base64.StdEncoding.EncodeToString(hash)
	saltBase64 := base64.StdEncoding.EncodeToString(salt)
	return hashBase64, saltBase64, nil
}

func VerifyArgon2(password, hashBase64, saltBase64 string, viper *viper.Viper) bool {
	_, time, memory, threads, keyLen, pepper := getConfigHashArgon2(viper)
	passwordBytes := []byte(password + pepper)

	salt, _ := base64.StdEncoding.DecodeString(saltBase64)

	key := argon2.IDKey(passwordBytes, salt, uint32(time), uint32(memory), uint8(threads), uint32(keyLen))

	hashNewBase64 := base64.StdEncoding.EncodeToString(key)

	return hashBase64 == hashNewBase64
}
