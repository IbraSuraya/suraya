package utils

func GenerateKeyEncrypt(size int) ([]byte, error) {
	key, err := GenerateSalt(size)
	return key, err
}
