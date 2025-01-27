package utils

import (
	"crypto/aes"
	"crypto/cipher"
	"crypto/rand"
	"encoding/base64"
	"io"
	"strconv"

	"github.com/spf13/viper"
)


func getConfigEncryptAES(viper *viper.Viper) (int) {
	size_nonce, _ := strconv.Atoi(viper.GetString("utils.pass.AES_256_GCM.size_nonce"))
	return size_nonce
}

// EncryptAES mengenkripsi teks dengan AES-256-GCM
func EncryptAES(plaintext string, viper *viper.Viper, key []byte) (string, string, error) {
	size_nonce := getConfigEncryptAES(viper)

	block, err := aes.NewCipher(key)
	if err != nil {
		return "", "", err
	}

	nonce := make([]byte, size_nonce) // Nonce untuk GCM
	if _, err := io.ReadFull(rand.Reader, nonce); err != nil {
		return "", "", err
	}

	aesGCM, err := cipher.NewGCM(block)
	if err != nil {
		return "", "", err
	}

	ciphertext := aesGCM.Seal(nil, nonce, []byte(plaintext), nil)
	ciphertextBase64 := base64.StdEncoding.EncodeToString(ciphertext)
	nonceBase64 := base64.StdEncoding.EncodeToString(nonce)

	return ciphertextBase64, nonceBase64, nil
}

// DecryptAES mendekripsi teks dengan AES-256-GCM
func DecryptAES(ciphertextBase64, nonceBase64 string, key []byte) (string, error) {
	block, err := aes.NewCipher(key)
	if err != nil {
		return "", err
	}

	nonce, err := base64.StdEncoding.DecodeString(nonceBase64)
	if err != nil {
		return "", err
	}
	ciphertext, err := base64.StdEncoding.DecodeString(ciphertextBase64)
	if err != nil {
		return "", err
	}

	aesGCM, err := cipher.NewGCM(block)
	if err != nil {
		return "", err
	}

	plaintext, err := aesGCM.Open(nil, nonce, ciphertext, nil)
	if err != nil {
		return "", err
	}

	return string(plaintext), nil
}
